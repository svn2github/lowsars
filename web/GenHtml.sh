#!/bin/bash
cat part0 > "$1"
cat "$1.title" >> "$1"
cat part1 >> "$1"
cat "$1.in" >> "$1"
cat part2 >> "$1"

