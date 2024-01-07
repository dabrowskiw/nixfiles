#!/usr/bin/env python3

import sys
from typing import List, Tuple
import re


def get_indent_level(line: str) -> Tuple[int, str]:
    if len(line) == 0 or not line[0] == ">":
        return (0, line)
    level = 0
    for c in line:
        if c == ">":
            level += 1
        if c not in "> ":
            break
    return (level, re.sub(r"^[> ]+", "", line))


def wrapline(
    line: str, width: int, lastline: Tuple[str, int] | None
) -> List[Tuple[str, int]]:
    res: List[Tuple[str, int]] = []
    currline = []
    numchars = 0
    (qlevel, line) = get_indent_level(line)
    qstr = ">"
    qlen = qlevel * len(qstr)
    if lastline is not None and qlevel == lastline[1]:
        words = get_indent_level(lastline[0])[1].split(" ") + line.split(" ")
    elif lastline is not None:
        res += [lastline]
        words = line.split(" ")
    else:
        words = line.split(" ")
    for word in words:
        wlen = len(word)
        if numchars == 0 or numchars + wlen + qlen <= width:
            currline += [word]
            numchars += wlen + 1
        else:
            resline = qlevel * qstr + " " + " ".join(currline)
            res += [(resline, qlevel)]
            currline = [word]
            numchars = wlen + 1
    resline = qlevel * qstr + " " + " ".join(currline)
    res += [(resline, qlevel)]
    return res


reader = sys.stdin.readlines
if len(sys.argv) == 2:
    f = open(sys.argv[1], "r")
    reader = f.readlines

emptylead = True
emptylines = 0
fulltext: List[Tuple[str, int]] = []
lastline = None
for line in reader():
    if len(line.strip()) != 0:
        emptylead = False
    if not emptylead:
        wrapped = wrapline(line.strip(), 80, lastline)
        if len(wrapped) == 1:
            fulltext += wrapped
            lastline = None
        else:
            fulltext += wrapped[:-1]
            lastline = wrapped[-1]

print("\n".join([x[0] for x in fulltext]))
