#! /bin/sh

ffprobe "$1" -print_format json -show_format -show_streams -v quiet
