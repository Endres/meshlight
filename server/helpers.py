#!/usr/bin/env python3
import colorsys
import operator

class RGBColor(tuple):
    def __new__(self, r=0, g=0, b=0):
        try:
            iterator = iter(r)
        except TypeError:
            return tuple.__new__(RGBColor, (r, g, b))
        else:
            return tuple.__new__(RGBColor, r)

    r = property(operator.itemgetter(0))
    g = property(operator.itemgetter(1))
    b = property(operator.itemgetter(2))

    def from_hls(h, l, s):
        value = colorsys.hls_to_rgb(h, l, s)
        rgb = [int(c * 256) if int(c * 256) < 256 else 255 for c in value]
        return RGBColor(rgb)

    def from_hsv(h, s, v):
        value = colorsys.hsv_to_rgb(h, s, v)
        rgb = [int(c * 256) if int(c * 256) < 256 else 255 for c in value]
        return RGBColor(rgb)

    def from_yiq(y, i, q):
        value = colorsys.yiq_to_rgb(y, i, q)
        rgb = [int(c * 256) if int(c * 256) < 256 else 255 for c in value]
        return RGBColor(rgb)
