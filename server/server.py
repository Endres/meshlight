#!/usr/bin/env python3
from flask import Flask, jsonify, render_template
from flask_bootstrap import Bootstrap

from animations import AnimationCollection
import animations
import config

import socket
import time
import threading

fps = config.TARGET_FPS
pixel_count = 15
color_data = [0]*(3*pixel_count)

ajax_requests = 0

class TimeFrameRunner(object):
    def __init__(self):
        self.counter = 0
        self.frame_counter = 0

        #self.animation_collection = AnimationCollection()

    def main(self):
        global fps, color_data, ajax_requests, pixel_count
        self.running = True

        animation = animations.AnimationCollection()
        skip_frame = False
        time_to_sleep = 0
        time_start = time.time()

        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        sock.bind(("", 9876))

        broadcast_ip = "192.168.7.255"

        while self.running:
            self.counter += 1

            # decide wether frameskip is still active
            time_to_sleep += 1 / config.TARGET_FPS
            if time_to_sleep > 0:
                skip_frame = False
                self.frame_counter += 1

            # run animations here
            last_color_data = [] + color_data
            color_data = animation.frame(color_data, skip=skip_frame)

            # send to the mesh network, but only if we have something to send
            if not skip_frame and last_color_data != color_data:
                sock.sendto(b"\x00" + bytes([int(x) for x in color_data]),
                    (broadcast_ip, 9876))
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
                """pixel_count -= 1
                del color_data[-3:]
                if pixel_count == -1:
                    pixel_count = 50
                    color_data = [0]*(3*pixel_count)"""

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
Bootstrap(app)

# suppress flooding of AJAX log messages
import logging
log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

@app.route('/')
def request_index():
    return render_template("index.html", fps=fps)


@app.route('/api/get_data')
def request_colors():
    global ajax_requests
    ajax_requests += 1
    return jsonify({'color_data': color_data, 'pixel_count': pixel_count, 'fps': fps})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True, use_reloader=False)
