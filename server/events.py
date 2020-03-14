#!/usr/bin/env python3
import astral
import astral.sun
import datetime
import inspect
import pytz
import re
import sys

class Always(object):
    PRIORITY = -999

    def trigger(self):
        return True

class GeoTimed(object):
    PRIORITY = 1

    LATITUDE = 51
    LONGITUDE = 7
    ELEVATION = 0

    # the class variable state has following values:
    # 0: not triggered yet
    # 1: Sunset has triggered -> next is Sunrise
    # 2: Sunrise has triggered -> next is Sunset

    def update_suntime(self):
        if not self.suntime or (self.suntime["noon"].date() !=
            datetime.datetime.utcnow().date()):
            self.suntime = astral.sun.sun(astral.Observer(GeoTimed.LATITUDE, GeoTimed.LONGITUDE, GeoTimed.ELEVATION))

    def __init__(self):
        self.state = None
        self.suntime = None
        self.got = False
        self.update_suntime()

    def trigger(self, which):
        status = self.status()
        if status != self.state:
            self.state = status
            self.got = False
        if status == which and not self.got:
            self.got = True
            return True
        return False

    def status(self):
        self.update_suntime()
        if (self.suntime["sunset"] >= pytz.utc.localize(datetime.datetime.utcnow())
            and self.suntime["sunrise"] < pytz.utc.localize(datetime.datetime.utcnow())):
            return "Sunrise"
        return "Sunset"

eventInstances = {}

def parseEventString(s):
    m = re.match(r"(.+?)(?:\((.+?)\))?$", s)
    if not m:
        return None
    classname = m.group(1)
    params = m.group(2).split(",") if m.group(2) else []
    for i, v in enumerate(params):
        if v.isdigit():
            params[i] = int(v)
        else:
            try:
                params[i] = float(v)
            except:
                pass
    if classname not in eventInstances:
        # not yet in instances
        for member in inspect.getmembers(sys.modules[__name__], inspect.isclass):
            if member[0] == classname:
                eventInstances[classname] = member[1]()
                break
        if classname not in eventInstances:
            return None
    return (eventInstances[classname], params)

def parseEventStringTrigger(s):
    obj, params = parseEventString(s)
    return obj.trigger(*params)

def containsEvent(l, ev):
    for e in l:
        if e[0].__class__ == ev:
            return True
    return False
