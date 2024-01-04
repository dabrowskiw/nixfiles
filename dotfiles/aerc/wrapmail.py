#!/usr/bin/python

import sys
from typing import List

def get_indent_level(line: str) -> int:
    if len(line) == 0 or not line[0] == ">":
        return 0
    level = 0
    for c in line:
        if c == ">":
            level += 1
        if c not in "> ":
            return level


def wrapline(line: str, width: int) -> List[str]:
    words = line.split(" ")
    res = []
    line = []
    numchars = 0
    qlevel = get_indent_level(line)
    for word in words:
        wlen = len(word)
        if numchars == 0 or numchars + wlen <= width:
            line += [word]
            numchars += wlen+1
        else:
            if len(res) == 0:
                resline = " ".join(line)
            else:
                resline = " ".join(line) + qlevel*"> " + " ".join(line)
            res += [resline]
            line = [word]
            numchars = wlen+1
    if len(res) == 0:
        resline = " ".join(line)
    else:
        resline = " ".join(line) + qlevel*"> " + " ".join(line)
    res += [resline]
    return res



emptylead = True
emptylines = 0
for line in sys.stdin.readlines():
    if len(line.strip()) != 0:
        emptylead = False
    if not emptylead:
        if len(line.strip()) == 0:
            emptylines += 1
        else:
            if emptylines != 0:
                print((emptylines-1)*"\n")
                emptylines = 0
            print("\n".join(wrapline(line.strip(), 80))) 

