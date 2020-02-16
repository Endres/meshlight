#!/usr/bin/env python3

TARGET_FPS = 30

MESH_TIMEOUT = 9.5

DEFAULT_CONFIGURATION = [
    {"animation": "Treppenblink", "duration": 30, "event": {"type": "Always"}},
    {"animation": "RGBFader", "duration": 30, "event": {"type": "Always"}},
    {"animation": "BrightnessFader", "duration": 20, "event": {"type": "Always"}}
]

PIXEL_COUNT = 15
