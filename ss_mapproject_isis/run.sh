#!/bin/bash

set -x verbose
rm -rfv run

echo localhost > machines.txt

mapproject ../data/sfs-DEM.tif ../data/sfs-cam.cub run/run.tif --tile-size 50 --nodes-list machines.txt


