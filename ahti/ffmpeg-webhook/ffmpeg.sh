#! /bin/sh

ffmpeg -i "$1" -map_chapters -1 -r 8 -filter:v 'fps=fps=8, scale=854:-1' -c:s mov_text "$2"
