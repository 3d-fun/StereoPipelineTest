#!/bin/bash

set -x verbose
rm -rfv run

stereo ../data/WV01_11JAN131652222-P1BS-10200100104A0300_sub8.tif ../data/WV01_11JAN131653180-P1BS-1020010011862E00_sub8.tif ../data/WV01_11JAN131652222-P1BS-10200100104A0300_sub8.xml ../data/WV01_11JAN131653180-P1BS-1020010011862E00_sub8.xml run/run -s stereo.default --disable-fill-holes --corr-search -20 -20 20 20 --left-image-crop-win 4096 2048 1024 1024 --use-local-homography -t rpc --alignment-method none --corr-seed-mode 1 --subpixel-mode 2
point2dem -r Earth run/run-PC.tif --nodata-value -32767
