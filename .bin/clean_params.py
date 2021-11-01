#! /usr/bin/env python
import json
import re
import sys

def clean_params(params):
    # prints a formatted string to paste into the neo4j dashboard
    pattern = r"""['"]([^'"]+)['"]:"""
    replacer = r"\1:"
    formatted = re.sub(pattern, replacer, json.dumps(params))
    return f":param {formatted}"


if __name__ == "__main__":
    rd = sys.stdin.read()
    d = json.loads(rd)
    print(clean_params(d))