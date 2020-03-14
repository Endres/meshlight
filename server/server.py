#!/usr/bin/env python3
from flask import Flask, jsonify, render_template, request

import animations
import config

import socket
import time
import threading

fps = config.TARGET_FPS
color_data = [0]*(3*config.PIXEL_COUNT)
auto = animations.AnimationSequence()

ajax_requests = 0

blackout = config.INITIAL_BLACKOUT

class TimeFrameRunner(object):
    def __init__(self):
        self.counter = 0
        self.frame_counter = 0
        self.sock = None

    def connect(self):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        self.sock.bind(("", 9876))

    def disconnect(self):
        if self.sock:
            self.sock.close()
            self.sock = None

    def main(self):
        global fps, color_data, ajax_requests, animation
        self.running = True

        animation = auto
        skip_frame = False
        time_to_sleep = 0
        time_start = time.time()
        last_sent = 0

        self.connect()

        broadcast_ip = "192.168.7.255"

        while self.running:
            self.counter += 1

            # decide wether frameskip is still active
            # when blackout, always process a frame only each second
            time_to_sleep += 1 / (config.TARGET_FPS if not blackout else 1)
            if time_to_sleep > 0:
                skip_frame = False
                self.frame_counter += 1

            # run animations here
            last_color_data = [] + color_data
            color_data = (animation.frame(color_data, skip=skip_frame) if
                not blackout else [0] * 3 * config.PIXEL_COUNT)

            # send to the mesh network, but only if we have something to send
            if ((not skip_frame and last_color_data != color_data) or
                    time.time() > last_sent + config.MESH_TIMEOUT):
                while True:
                    try:
                        self.sock.sendto(
                            b"\x00" + bytes([int(x) for x in color_data]),
                            (broadcast_ip, 9876))
                        last_sent = time.time()
                        break
                    except:
                        self.disconnect()
                        time.sleep(1)
                        self.connect()
            else:
                #print("nothing sent")
                pass

            # some status info for the log every second
            if self.counter % config.TARGET_FPS == 0:
                fps = self.frame_counter
                self.frame_counter = 0
                print("AJAX Requests/s: {} FPS: {}".format(ajax_requests, fps))
                ajax_requests = 0

                # only for debugging / testing without a real world scenario
                """config.PIXEL_COUNT -= 1
                del color_data[-3:]
                if config.PIXEL_COUNT == -1:
                    config.PIXEL_COUNT = 50
                    color_data = [0]*(3*config.PIXEL_COUNT)"""

            time_end = time.time()
            time_to_sleep -= time_end - time_start
            if time_to_sleep < 0:
                skip_frame = True
                #print("Frame skipping!")
            else:
                time.sleep(time_to_sleep)
                time_to_sleep = 0
            time_start = time.time()
            if time_to_sleep < 0:
                # no sleep was done, so at least yield!
                time.sleep(0)

time_frame_runner = TimeFrameRunner()
time_frame_thread = threading.Thread(target=time_frame_runner.main)
time_frame_thread.setDaemon(True)
time_frame_thread.start()

app = Flask(__name__)

# suppress flooding of AJAX log messages
import logging
log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

import random

@app.route('/')
def request_index():
    return render_template("index.html", fps=fps,randint=random.randrange(1,50000))
    # TODO remove this randint when development is done... or move static script to dynamic, or find another solution

@app.route('/api/get_frame')
def request_get_frame():
    global ajax_requests
    ajax_requests += 1
    return jsonify({'pixel_count': config.PIXEL_COUNT, 'color_data': color_data})

def buildProperties():
    if animations.get_animation_name_from_class(animation.__class__) == "auto":
        # TODO properties of current sequence index
        pass
    return animation.properties

@app.route('/api/get_data')
def request_get_data():
    global ajax_requests
    ajax_requests += 1
    return jsonify({
        'fps': fps,
        'animations': animations.get_animation_configurations(),
        'sequence': auto.get_sequence_data(),
        'mode': animations.get_animation_name_from_class(animation.__class__),
        'blackout': blackout,
        'properties': buildProperties()
    })

@app.route('/api/set_data', methods=['POST'])
def request_set_data():
    content = request.get_json(silent=True)
    if "mode" in content:
        class_ = animations.get_class_from_animation_name(content["mode"])
        global animation
        animation = class_() if class_ else auto
    if "blackout" in content:
        global blackout
        blackout = content["blackout"]
    if "propertiesTarget" in content and "properties" in content:
        if animations.get_class_from_animation_name(content["propertiesTarget"]["mode"]):
            class_ = animations.get_class_from_animation_name(content["propertiesTarget"]["mode"])
            if animation.__class__ == class_:
                print("property update")
                animation.properties.update(content["properties"])
        else:
            # auto mode
            if "sequenceId" in content["propertiesTarget"]:
                # single sequence entry
                # TODO handle, also keep sequence order updates etc. in mind
                pass
            else:
                # general auto properties
                auto.properties.update(content["properties"])

    return "{}" # better to return an empty json response than nothing

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True, use_reloader=False)
