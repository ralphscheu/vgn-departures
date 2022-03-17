#! /usr/bin/env bash

source /home/ralph/vgn-departures/venv/bin/activate

dataDir=/mnt/datalake/vgn-departures
departsDumpsDir=$dataDir/departures-dumps

filepathFirstDumpFile=$departsDumpsDir/`ls ${departsDumpsDir} | head -n +1`


for station in 331 510 704; do

    outFile=$dataDir/combined-dump-departures-$station.csv

    head -n +1 $filepathFirstDumpFile > $outFile  # copy CSV header
    for dumpFile in `find $departsDumpsDir -type f -name "*__departures-$station.csv"`;  do
        tail -n +2 $dumpFile >> $outFile  # copy departures dumps for station $station w/o header
    done

done
