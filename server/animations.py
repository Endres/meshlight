#!/usr/bin/env python3
import config
from helpers import RGBColor

class AnimationCollection(object):
    # todo

    def __init__(self):
        self.current_animation = 0

    def get_animation_list():
        return []

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
