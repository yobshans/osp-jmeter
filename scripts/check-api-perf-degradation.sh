#!/bin/bash

if [ "$1" != "" ]; then
  #echo "Directory parameter is $1"
  TRX_RESULT=$(grep 'FAIL' $1/mrg/compare-api.csv |wc -l)
  if [[ $TRX_RESULT -gt 0 ]]; then
    echo "Detected API performance degradation"
    echo "API_Label,Status,Diff_Msec,Diff_Percent"
    cat $1/mrg/compare-api.csv | while read line
    do
        LINE_RESULT=$(echo $line | cut -d',' -f2)
        if [[ $LINE_RESULT =  FAIL ]]; then
            echo $line
        fi
    done
    exit 1
  else
    echo "There are no API performance degradation"
  fi
else
  echo "Directory parameter is empty"
  exit 1
fi
