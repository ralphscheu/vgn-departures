#! /usr/bin/env bash

source /home/ralph/vgn-departures/venv/bin/activate

for station in 331 510 704; do
    python3 /home/ralph/vgn-departures/dump-departures.py \
        --station $station \
        /mnt/datalake/vgn-departures/departures-dumps
done
