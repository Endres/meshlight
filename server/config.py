#!/usr/bin/env python3

TARGET_FPS = 30

MESH_TIMEOUT = 9.5

DEFAULT_CONFIGURATION = [
    #{"animation": "Treppenblink", "duration": 30, "event": "Always", "until": "Always"},
    {"animation": "Blackout", "duration": 600, "event": "Always", "until": "Always"},
    {"animation": "RGBFader", "duration": 300, "event": "GeoTimed(Sunset)", "until": "GeoTimed(Sunrise)"},
    {"animation": "BrightnessFader", "duration": 20, "event": "GeoTimed(Sunset)", "until": "GeoTimed(Sunrise)"}
]

PIXEL_COUNT = 15

INITIAL_BLACKOUT = True
