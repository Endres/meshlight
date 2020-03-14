#!/usr/bin/env python3
import collections
import config
import datetime
from helpers import RGBColor
import inspect
import sys

class Animation(object):
    def __init__(self):
        self.properties = _default_properties(self.__class__)

class RGBFader(Animation):
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

    def __init__(self, duration=10):
        super(RGBFader, self).__init__()
        self.i = 0
        self.properties["Duration"] = duration

    def frame(self, data, skip=False):
        if not skip:
            pixels = int(len(data) / 3)
            if pixels == 0:
                return data
            totalsteps = self.properties["Duration"] * config.TARGET_FPS
            hue = 1 - (self.i / totalsteps)
            huestep = 1 / pixels
            for i in range(pixels):
                data[i*3:i*3+3] = RGBColor.from_hls(hue % 1, self.properties["Lightness"], self.properties["Saturation"])
                hue += huestep
        self.i += 1
        return data

class BrightnessFader(Animation):
    OPTIONS = {
        "Saturation": [ 0, 1, 0, "slider-float"],
        "Hue": [0, 1, 0, "slider-float"],
        "Duration": [1, 600, 10, "slider-duration"],
        "Framerate": [0, config.TARGET_FPS, config.TARGET_FPS, "slider-int"]
    }

    def __init__(self, duration=10):
        super(BrightnessFader, self).__init__()
        self.i = 0
        self.properties["Duration"] = duration

    def frame(self, data, skip=False):
        if not skip:
            totalsteps = self.properties["Duration"] * config.TARGET_FPS
            lightness = (self.i / (totalsteps / 2)) % 1
            if (self.i // (totalsteps / 2)) % 2 == 1:
                lightness = 1 - lightness
            color = RGBColor.from_hls(self.properties["Hue"], lightness, self.properties["Saturation"])
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
        super(ClockHourBrightnessFader, self).__init__()
        times = datetime.datetime.now().hour % 12
        if times == 0:
            times = 12
        self.finish_duration = 10 * times"""

class Treppenblink(Animation):
    OPTIONS = {
        "Framerate": [0, config.TARGET_FPS, 5, "slider-int"]
    }

    def __init__(self, framerate=5):
        super(Treppenblink, self).__init__()
        self.start = [0, 0, 0]
        self.last_rgbdots = 0
        self.count_r = 50 * 256
        self.count_g = 50 * 256
        self.count_b = 50 * 256
        self.properties["Framerate"] = framerate
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
            self.new_frame += self.properties["Framerate"] / config.TARGET_FPS
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

class SingleStaticRGB(Animation):
    OPTIONS = {}

    # TODO optimize the options handling process and as well allow changing the number of pixels and somehow inform the animation classes if they want

    def __init__(self):
        SingleStaticRGB.OPTIONS = collections.OrderedDict()
        for i in range(config.PIXEL_COUNT):
            SingleStaticRGB.OPTIONS["Pixel {:3}".format(i)] = [None, None, RGBColor((255, 0, 0)), "color"]
        self.properties = _default_properties(SingleStaticRGB)

    def frame(self, data, skip=False):
        for i in range(len(data) // 3):
            color = self.properties["Pixel {:3}".format(i)]
            data[i * 3] = color[0]
            data[i * 3 + 1] = color[1]
            data[i * 3 + 2] = color[2]
        return data

class Blackout(Animation):
    OPTIONS = {}

    def __init__(self):
        super(Blackout, self).__init__()

    def frame(self, data, skip=False):
        pixels = int(len(data) / 3)
        return [0]*(3*pixels)

def _default_properties(class_):
    return {key: val[2] for key, val in class_.OPTIONS.items()}

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

import copy
import events

class AnimationSequence(Animation):
    OPTIONS = {
        "Fade Time": [0, 20, 3, "slider-float"]
    }

    EVENT_POLL_INTERVAL = 30 # every n frames check for event updates

    def __init__(self, configuration=config.DEFAULT_CONFIGURATION):
        super(AnimationSequence, self).__init__()
        self.configuration = configuration
        self.animationQueue = []
        self.nextUpdate = 0
        self.animation_index = 0
        self.handleEvents()
        self.matchAnimationIndexToQueue()
        self._load_animation()

    def get_sequence_data(self):
        sequence_data = copy.deepcopy(self.configuration)
        if active_index >= 0 and active_index < len(sequence_data):
            sequence_data[active_index]['is_active'] = True
        return sequence_data

    def _load_animation(self):
        self.current_animation = get_class_from_animation_name(
            self.configuration[self.animation_index]["animation"])()
        self.next_animation_frame = self.configuration[self.animation_index]["duration"] * config.TARGET_FPS
        self.i = 0

    def matchAnimationIndexToQueue(self, increase=0):
        self.animation_index += increase
        while True:
            self.animation_index = self.animation_index % len(self.configuration)
            # increase until found an animation inside
            if self.configuration[self.animation_index] in self.animationQueue:
                break
            self.animation_index += 1
        global active_index
        active_index = self.animation_index

    def handleEvents(self):
        # TODO CLEAN THAT UP OR REIMPLEMENT
        # find all animations that would trigger right now
        # add each to the animationQueue
        # if animationQueue is empty, add "Always" elements
        # if animationQueue is still empty, do a additional blackout (must be lower priorized than normal blackout...)
        # take the first element and remove it after it was changed to

        # solve this hassle by using some kind of threads that sleep or fire when events are triggered, and not by polling every second or such.
        eventList = []
        for entry in self.configuration:
            #print("parse events of {}".format(entry["animation"]))
            parsedEvent = events.parseEventString(entry["event"])
            #print(parsedEvent)
            if parsedEvent not in eventList:
                eventList.append(parsedEvent)
            parsedEvent = events.parseEventString(entry["until"])
            #print(parsedEvent)
            if parsedEvent not in eventList:
                eventList.append(parsedEvent)
        #print("different Events:")
        #print(eventList)
        #print("check all events that trigger:")
        # remove Always Event
        triggeredEvents = [x for x in eventList if x[0].trigger(*x[1]) and x[0].__class__ != events.Always]
        # TODO somehow sort by event priorities
        #print(triggeredEvents)
        # go through events, if is triggered, add to queue
        # TODO configured events might be in the queue only a single time each, so it is not a queue per-se
        for entry in self.configuration:
            if events.parseEventString(entry["event"]) in triggeredEvents:
                #print("append {}".format(entry))
                self.animationQueue.append(entry)
        # go through until events, if until is also triggered, remove animation from queue
        oldQueue = copy.deepcopy(self.animationQueue)
        for entry in oldQueue:
            # TODO animations can also request a removal from the queue, but in this case the until has higher priority!
            if events.parseEventString(entry["until"]) in triggeredEvents or events.parseEventString(entry["event"])[0].__class__ == events.Always:
                #print("remove {}".format(entry))
                self.animationQueue.remove(entry)
        # if queue is empty, use Always events
        if not self.animationQueue:
            self.animationQueue = [x for x in self.configuration if events.parseEventString(x["event"])[0].__class__ == events.Always]
        # if queue is still empty, fallback to Blackout
        if not self.animationQueue:
            self.animationQueue.append({"animation": "Blackout", "duration": 600, "event": "Always", "until": "Always"})
        #print("====> {}".format(self.animationQueue))
        # TODO oldquuee DIFFERS???
        # for now, simply check if current index is still inside queue, so we can set it to the same index, otherwise use 0
        if self.configuration[self.animation_index] not in self.animationQueue:
            self.animation_index = 0
            self.matchAnimationIndexToQueue()
            self._load_animation()

    def frame(self, data, skip=False):
        data = self.current_animation.frame(data, skip)
        if not skip:
            # this frame modification fades to black between consecutive animations
            totalsteps = self.properties["Fade Time"] * config.TARGET_FPS
            if self.i < totalsteps:
                # fading in new animation
                data = [x * self.i / totalsteps for x in data]
            elif self.i >= self.next_animation_frame - totalsteps:
                # fading out old animation
                data = [x * (self.next_animation_frame - self.i) / totalsteps
                    for x in data]
        self.nextUpdate += 1
        if self.nextUpdate >= AnimationSequence.EVENT_POLL_INTERVAL:
            self.nextUpdate = 0
            self.handleEvents()
        self.i += 1
        if self.i >= self.next_animation_frame:
            self.matchAnimationIndexToQueue(1)
            self._load_animation()
        return data

_NON_ANIMATIONS = [Animation, AnimationSequence, RGBColor]
