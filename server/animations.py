#!/usr/bin/env python3
import config
import datetime
from helpers import RGBColor
import inspect
import sys

class RGBFader(object):
    # idea of this animation is to specify a time, by which the circle is faded
    # through the whole color spectrum. So we need to calculate every frame,
    # depending on frame counter, config.TARGET_FPS and of course also number of
    # pixels... The beforementioned duration is given as a constructor parameter

    OPTIONS = {
        "Saturation": [0, 1, 1, "slider-float"],
        "Lightness": [0, 1, 0.5, "slider-float"],
        "Duration": [1, 600, 10, "slider-duration"],
        "Repetitions": [1, 5, 1, "slider-int"],
        "Framerate": [0, config.TARGET_FPS, config.TARGET_FPS, "slider-int"]
    }

    SATURATION = 1
    LIGHTNESS = 0.5

    def __init__(self, duration=10):
        self.i = 0
        self.duration = duration

    def frame(self, data, skip=False):
        if not skip:
            pixels = int(len(data) / 3)
            if pixels == 0:
                return data
            totalsteps = self.duration * config.TARGET_FPS
            hue = 1 - (self.i / totalsteps)
            huestep = 1 / pixels
            for i in range(pixels):
                data[i*3:i*3+3] = RGBColor.from_hls(hue % 1, RGBFader.LIGHTNESS, RGBFader.SATURATION)
                hue += huestep
        self.i += 1
        return data

class BrightnessFader(object):
    OPTIONS = {
        "Saturation": [ 0, 1, 0, "slider-float"],
        "Hue": [0, 1, 0, "slider-float"],
        "Duration": [1, 600, 10, "slider-duration"],
        "Framerate": [0, config.TARGET_FPS, config.TARGET_FPS, "slider-int"]
    }

    SATURATION = 0
    HUE = 0

    def __init__(self, duration=10):
        self.i = 0
        self.duration = duration

    def frame(self, data, skip=False):
        if not skip:
            totalsteps = self.duration * config.TARGET_FPS
            lightness = (self.i / (totalsteps / 2)) % 1
            if (self.i // (totalsteps / 2)) % 2 == 1:
                lightness = 1 - lightness
            color = RGBColor.from_hls(BrightnessFader.HUE, lightness, BrightnessFader.SATURATION)
            pixels = int(len(data) / 3)
            data = list(color) * pixels
        self.i += 1
        return data

#TODO: test / fix this!
# TODO Fix me -> rather define total duration and set precalculated duration or something, or, better call some setup function for each animation
"""for class in self.configuration:
    if class == BrightnessFader:
        times = datetime.datetime.now().hour % 12
        if times == 0:
            times = 12
        self.configuration[class]["duration"] = 10 * times"""
"""class ClockHourBrightnessFader(BrightnessFader):
    def __init__(self, duration=0):
        super.__init__()
        times = datetime.datetime.now().hour % 12
        if times == 0:
            times = 12
        self.finish_duration = 10 * times"""

class Treppenblink(object):
    OPTIONS = {
        "Framerate": [0, config.TARGET_FPS, 5, "slider-int"]
    }

    def __init__(self, framerate=5):
        self.start = [0, 0, 0]
        self.last_rgbdots = 0
        self.count_r = 50 * 256
        self.count_g = 50 * 256
        self.count_b = 50 * 256
        self.framerate = framerate / config.TARGET_FPS
        self.new_frame = 1

    def frame(self, data, skip=False):
        rgbdots = len(data) // 3

        if self.last_rgbdots != rgbdots:
            self.start = [0, rgbdots // 2, rgbdots]
            self.lightblob = []
            max_ = rgbdots // 4
            for i in range(max_):
                self.lightblob.append(((i + 1) * 255) // max_)
            self.lightblob += self.lightblob[-2::-1]
            self.last_rgbdots = rgbdots

        if not skip:
            for i in range(rgbdots):
                for j in range(3):
                    if (((rgbdots + i - self.start[j]) % rgbdots) <
                            len(self.lightblob)):
                        data[i * 3 + j] = self.lightblob[(rgbdots + i -
                            self.start[j]) % rgbdots]
                    else:
                        data[i * 3 + j] = 0

        if self.new_frame < 1:
            self.new_frame += self.framerate
        else:
            while self.new_frame >= 1:
                self.count_r = ((self.count_r + 200) + (rgbdots * 256)) % (rgbdots * 256)
                self.count_b = ((self.count_b + 150) + (rgbdots * 256)) % (rgbdots * 256)
                self.count_g = ((self.count_g - 175) + (rgbdots * 256)) % (rgbdots * 256)

                self.start[0] = self.count_r >> 8
                self.start[1] = self.count_b >> 8
                self.start[2] = self.count_g >> 8

                self.new_frame -= 1

        return data

def get_animation_classes():
    return [x[1] for x in inspect.getmembers(sys.modules[__name__], inspect.isclass) if not x[1] in _NON_ANIMATIONS]

def get_class_from_animation_name(name):
    for _class in get_animation_classes():
        if _class.__name__ == name:
            return _class
    return None

def get_animation_name_from_class(class_):
    if not class_ in _NON_ANIMATIONS:
        return class_.__name__
    return "auto"

def get_animation_configurations():
    configurations = {}
    for animation in get_animation_classes():
        configurations[animation.__name__] = animation.OPTIONS
    return configurations

active_index = 0

class AnimationCollection(object):
    def _load_animation(self):
        self.current_animation = get_class_from_animation_name(
            self.configuration[self.animation_index]["animation"])()
        self.next_animation_frame = self.configuration[self.animation_index]["duration"] * config.TARGET_FPS
        self.i = 0

    def __init__(self, configuration=config.DEFAULT_CONFIGURATION, fade_time=3):
        self.configuration = configuration
        self.animation_index = 0
        self._load_animation()
        self.fade_time = fade_time

    def frame(self, data, skip=False):
        global active_index
        data = self.current_animation.frame(data, skip)
        if not skip:
            # this frame modification fades to black between consecutive animations
            totalsteps = self.fade_time * config.TARGET_FPS
            if self.i < totalsteps:
                # fading in new animation
                data = [x * self.i / totalsteps for x in data]
            elif self.i >= self.next_animation_frame - totalsteps:
                # fading out old animation
                data = [x * (self.next_animation_frame - self.i) / totalsteps
                    for x in data]
        self.i += 1
        if self.i >= self.next_animation_frame:
            self.animation_index += 1
            if self.animation_index >= len(self.configuration):
                self.animation_index = 0
            active_index = self.animation_index
            self._load_animation()
        return data

import copy

class AnimationSequence(object):
    def __init__(self):
        self.configuration = config.DEFAULT_CONFIGURATION

    def get_sequence_data(self):
        sequence_data = copy.deepcopy(self.configuration)
        if active_index >= 0 and active_index < len(sequence_data):
            sequence_data[active_index]['is_active'] = True
        return sequence_data

_NON_ANIMATIONS = [AnimationCollection, AnimationSequence, RGBColor]
