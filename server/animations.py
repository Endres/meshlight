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
class ClockHourBrightnessFader(BrightnessFader):
    def __init__(self, duration=0):
        super.__init__()
        times = datetime.datetime.now().hour % 12
        if times == 0:
            times = 12
        self.finish_duration = 10 * times

def get_animation_classes():
    exclude_list = [AnimationCollection, RGBColor]
    return [x[1] for x in inspect.getmembers(sys.modules[__name__], inspect.isclass) if not x[1] in exclude_list]

def get_class_from_animation_name(name):
    for _class in get_animation_classes():
        if _class.__name__ == name:
            return _class
    return None

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
        data = self.current_animation.frame(data, skip)
        if not skip:
            totalsteps = self.fade_time * config.TARGET_FPS
            if self.i < totalsteps:
                data = [x * self.i / totalsteps for x in data]
            elif self.i >= self.next_animation_frame - totalsteps:
                data = [x * (self.next_animation_frame - self.i) / totalsteps
                    for x in data]
        self.i += 1
        if self.i >= self.next_animation_frame:
            self.animation_index += 1
            if self.animation_index >= len(self.configuration):
                self.animation_index = 0
            self._load_animation()
        return data
