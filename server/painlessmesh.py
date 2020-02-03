#!/usr/bin/env python3
"""
Program implementing a painlessMesh node that can run on any computer

Dependencies:
    Python 3

To run just make this script executable and run it.
"""
import argparse
import json
import logging
import random
import socket
import threading
import time
import types

port = 5555

logging.basicConfig()
logger = logging.getLogger(__name__)

PACKAGE_TYPE_DROP = 3
PACKAGE_TYPE_TIME_SYNC = 4
PACKAGE_TYPE_NODE_SYNC_REQUEST = 5
PACKAGE_TYPE_NODE_SYNC_REPLY = 6
PACKAGE_TYPE_BROADCAST = 8         # application data for everyone
PACKAGE_TYPE_SINGLE = 9            # application data for a single node

TIME_SYNC_ERROR = -1
TIME_SYNC_REQUEST = 0
TIME_REQUEST = 1
TIME_REPLY = 2

def _read_json_object(connection):
    first_run = True
    data = bytes()
    while True:
        b = connection.recv(1)
        if b == b'\x00':
            break
        data += b
    return json.loads(data.decode("utf-8"))

adjust_time = 0

def node_time():
    return int(time.time() * 1000000 + adjust_time)

class Node(object):
    def __init__(self):
        self.node_id = 0
        self.connections = {}
        self.receive = None
        self.mutex = threading.Lock()

    def _maintenance(self):
        while True:
            self.mutex.acquire()
            try:
                curr_t = time.time()
                logger.debug("Checking for unused connections")
                for from_id, conn in dict(self.connections).items():
                    self.send_node_sync(from_id)
                    if curr_t - conn.last_received > 60:
                        self.remove_connection(from_id)
            finally:
                self.mutex.release()
            time.sleep(6)

    def init_maintenance(self):
        self.thread = threading.Thread(target=self._maintenance)
        self.thread.setDaemon(True)
        self.thread.start()

    def init_connection(self, conn):
        logger.debug("New connection")
        from_id = 0
        try:
            while True:
                json_ = _read_json_object(conn)
                self.mutex.acquire()
                try:
                    logger.debug("Received message: {}".format(json_))
                    if (from_id == 0 and
                            (json_["type"] == PACKAGE_TYPE_TIME_SYNC or
                            json_["type"] == PACKAGE_TYPE_NODE_SYNC_REQUEST or
                            json_["type"] == PACKAGE_TYPE_NODE_SYNC_REPLY)):
                        from_id = json_["from"]
                        mesh_connection = Connection()
                        mesh_connection.tcp = conn
                        mesh_connection.node_id = from_id
                        self.connections[from_id] = mesh_connection

                    if from_id in self.connections:
                        self.connections[from_id].last_received = time.time()

                    self.handle_message(from_id, json_)
                finally:
                    self.mutex.release()
        except socket.error as e:
            logger.error("Failed to read from client: {}".format(e))
        self.mutex.acquire()
        try:
            self.remove_connection(from_id)
        finally:
            self.mutex.release()

    def init_server(self, port):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        sock.bind(("0.0.0.0", port))
        sock.listen()
        self.init_maintenance()
        while True:
            c, addr = sock.accept()
            logger.debug("Connected from {}".format(addr))
            thread = threading.Thread(target=self.init_connection, args=(c, ))
            thread.setDaemon(True)
            thread.start()
        sock.close()

    def init_client(self, addr):
        self.init_maintenance()

        while True:
            try:
                sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                sock.connect(addr)

                # client initialize with node sync to get all connections right ahead
                pack = {
                    "dest": 0,
                    "from": self.node_id,
                    "type": PACKAGE_TYPE_NODE_SYNC_REQUEST,
                    "subs": []
                }
                sock.sendall(json.dumps(pack, separators=(',', ':')).
                    encode("utf-8") + b'\0')

                self.init_connection(sock)
            except Exception as e:
                logger.debug("Exception: {}".format(e))
                logger.warning("Unable to connect to: {}. Retrying in 10 seconds".
                    format(addr))
                time.sleep(10)

    def on_receive(self, callback):
        self.receive = types.MethodType(callback, self)

    def send_single(self, dest, msg):
        pack = {
            "dest": dest,
            "from": self.node_id,
            "type": PACKAGE_TYPE_SINGLE,
            "msg": msg
        }

        for k, v in dict(self.connections).items():
            if v.contains_id(dest):
                self.safe_write(k, pack)
                return True
        return False

    def send_broadcast(self, msg):
        pack = {
            "dest": 0,
            "from": self.node_id,
            "type": PACKAGE_TYPE_BROADCAST,
            "msg": msg
        }

        for k in list(self.connections):
            logger.debug("sendBroadcast: send message to {}.".format(k))
            self.safe_write(k, pack)
        return True

    def safe_write(self, connection_id, data):
        pkge = json.dumps(data, separators=(',', ':')).encode("utf-8")
        logger.debug("Send to {}, msg {}".format(connection_id, pkge))
        try:
            if connection_id in self.connections:
                # append a zero character
                self.connections[connection_id].tcp.sendall(bytes(pkge) + b'\0')
                return True
        except Exception as e:
            self.remove_connection(connection_id)
            logger.error("Failed to write to client: {}".format(e))
        return False

    def remove_connection(self, conn_id):
        if conn_id in self.connections:
            logger.debug("Removing connection {}: ".format(conn_id))
            self.connections[conn_id].tcp.close()
            del self.connections[conn_id]

            # Inform the other nodes
            for other_id in self.connections:
                self.send_node_sync(other_id, True)
            return True
        return False

    def handle_message(self, from_id, json_):
        global adjust_time
        if not from_id in self.connections:
            logger.debug("Unknown nodeId")
            return False

        if (json_["type"] == PACKAGE_TYPE_NODE_SYNC_REQUEST or
                json_["type"] == PACKAGE_TYPE_NODE_SYNC_REPLY):
            self.connections[from_id].subs = [SubConnection(x) for x in
                json_["subs"]]
            if json_["type"] == PACKAGE_TYPE_NODE_SYNC_REQUEST:
                self.send_node_sync(from_id, False)
        elif json_["type"] == PACKAGE_TYPE_TIME_SYNC:
            time_received = node_time()
            tS = json_["msg"]
            if tS["type"] != TIME_REPLY:
                pack = {
                    "dest": from_id,
                    "from": self.node_id,
                    "type": PACKAGE_TYPE_TIME_SYNC,
                }
                if tS["type"] == TIME_SYNC_REQUEST:
                    tS["t0"] = node_time()
                elif tS["type"] == TIME_REQUEST:
                    tS["t1"] = time_received
                    tS["t2"] = node_time()
                tS["type"] += 1
                pack["msg"] = tS
                self.safe_write(from_id, pack)
            else:
                adjust_time += ((tS["t1"] - tS["t0"]) / 2 + (tS["t2"] -
                    time_received) / 2)
        elif json_["type"] == PACKAGE_TYPE_BROADCAST:
            # if broadcast, forward it and pass it to received callback
            for k, v in dict(self.connections).items():
                if not v.contains_id(from_id): # Don't send it back
                    self.safe_write(k, json_)
            if callable(self.receive):
                self.receive(json_["from"], json_["msg"])
        elif json_["type"] == PACKAGE_TYPE_SINGLE:
            dest = json_["dest"]
            if callable(self.receive) and dest == self.node_id:
                self.receive(json_["from"], json_["msg"])
            else:
                # Forward it
                for k, v in dict(self.connections).items():
                    if v.contains_id(dest):
                        # forwarding
                        self.safe_write(k, json_)
                        break
        return True

    def send_node_sync(self, from_id, request=True):
        if from_id in self.connections:
            pack = {
                "dest": from_id,
                "from": self.node_id
            }
            pack["type"] = PACKAGE_TYPE_NODE_SYNC_REQUEST if request else (
                PACKAGE_TYPE_NODE_SYNC_REPLY)
            pack["subs"] = [v.json() for k, v in self.connections.items() if
                k != from_id]
            self.safe_write(from_id, pack)
        else:
            logger.debug("Connection not found during node sync")

class SubConnection(object):
    def __init__(self, json_ = {"nodeId": 0, "subs": []}):
        self.node_id = json_["nodeId"]
        self.subs = ([SubConnection(x) for x in json_["subs"]] if "subs" in
            json_ else [])

    def contains_id(self, id):
        if self.node_id == id:
            return True
        if not len(self.subs): # or not self.subs?
            return False
        for k, v in self.subs.items():
            if v.contains_id(id):
                return True

    def json(self):
        pack = {
            "nodeId": self.node_id,
            "subs": [x.json() for x in self.subs]
        }
        return pack

class Connection(SubConnection):
    def __init__(self):
        super().__init__()
        self.tcp = None
        self.last_received = 0

node = None

def main():
    global node, port
    node = Node()
    node.node_id = random.randint(0, 0xFFFFFFFF)
    # print("Node ID: {}".format(node.node_id))
    def on_receive(self, from_, msg):
        print(msg)
    node.on_receive(on_receive)

    def task():
        while True:
            node.mutex.acquire()
            msg = {
                "topic": "logNode",
                "nodeId": node.node_id
            }
            node.send_broadcast(msg)
            node.mutex.release()
            time.sleep(120)

    main_thread = threading.Thread(target=task)
    main_thread.setDaemon(True)
    main_thread.start()

    parser = argparse.ArgumentParser()
    parser.add_argument("-v", "--verbose", help="Enable debug messages",
                        action="store_true")

    parser.add_argument("-p", "--port", help="Optional port (default is 5555)",
                        type=int, default=5555)

    parser.add_argument("-c", "--client",
                        help="Run in client mode. Need to provide ip of the node to connect to.",
                        type=str)

    args = parser.parse_args()

    if args.verbose:
        logger.setLevel(logging.DEBUG)

    # Rest is needed to run the server/client. Don't change this unless you
    # know what you are doing
    port = args.port

    if args.client:
        node.init_client((args.client, port))
    else:
        node.init_server(port)

if __name__ == "__main__":
    main()
