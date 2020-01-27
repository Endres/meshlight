from flask import Flask, jsonify, render_template
from flask_bootstrap import Bootstrap

import time
import threading

class RGBColor(object):
    def __init__(self):
        self.r = 0
        self.g = 0
        self.b = 0

run = 0
pixel_count = 15
color_data = [0]*(3*pixel_count)

class TimeFrameRunner(object):
    def __init__(self):
        self.counter = 0

    def main(self):
        global run, color_data
        self.running = True
        while self.running:
            self.counter += 1
            run = self.counter

            # run animations here
            color_data = [255-x for x in color_data]

            time.sleep(1/2)
            # if no sleep desired, pass 0 to sleep for yield!

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
    return render_template("index.html", fps=run)


@app.route('/api/get_data')
def request_colors():
    return jsonify({'color_data': color_data, 'pixel_count': pixel_count})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True, use_reloader=False)
