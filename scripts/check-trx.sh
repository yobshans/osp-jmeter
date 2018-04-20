#!/bin/bash

if [ "$1" != "" ]; then
    echo "Directory parameter is $1"
    # check results
    TRX_RESULT=$(grep 's="false"' $1/xml/result.jtl |wc -l)
    if [[ $TRX_RESULT -gt 0 ]]; then
       echo "There are $TRX_RESULT failed transactions"
       echo "$(grep 's="false"' $1/xml/result.jtl | awk '{print $8}')"	 
       exit 1
    else
       echo "There are no failed transactions"
    fi
else
    echo "Directory parameter is empty"
    exit 1
fi

