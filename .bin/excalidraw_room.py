#! /usr/bin/env python
import random
import string

def random_string(selection, k):
    return ''.join(random.choice(selection) for _ in range(k))

room_set = string.digits + "abcdef"
key_set = string.ascii_letters + string.digits + "-_"

room = random_string(room_set, 20)
key = random_string(key_set, 22)
print(f"https://excalidraw.com/#room={room},{key}")

