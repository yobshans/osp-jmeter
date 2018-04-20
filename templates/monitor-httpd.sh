#! /bin/bash

inputfile=http-tmp.txt
outputfile=http-stat.csv

printf "%s %s %s %s %s %s %s %s %s %s %s %s\n" "CurrenTime" "TotalAccesses" "TotalTraffic" "ServerLoad1" "ServerLoad2" "ServerLoad3" "CPULoad" "Requests/Sec" "Bytes/Sec" "Bytes/request" "RequestProcessed" "IdleWorkers" > $outputfile
while :
do
	links http://172.17.1.22/server-status > $inputfile
        CURTIME=$(awk '$1=="Current" {print $5}' $inputfile)
	ACCESS=$(awk '$1=="Total" {print $3}' $inputfile)
	TRAFFIC=$(awk '$5=="Total" {print $7}' $inputfile)
	LOAD1=$(awk '$2=="load:" {print $3}' $inputfile)	
	LOAD2=$(awk '$2=="load:" {print $4}' $inputfile) 
	LOAD3=$(awk '$2=="load:" {print $5}' $inputfile) 
	CPULOAD=$(awk '$9=="CPU" && $10=="load" {print $8}' $inputfile)
	REQSEC=$(awk '$2=="requests/sec" {print $1}' $inputfile)
	BYTESEC=$(awk '$5=="B/second" {print $4}' $inputfile)
	BYTEREQ=$(awk '$8=="B/request" {print $7}' $inputfile)	
	REQPRO=$(awk '$2=="requests" && $3=="currently" {print $1}' $inputfile)
	IDLEWOR=$(awk '$7=="idle" && $8=="workers" {print $6}' $inputfile)

	printf "%s %s %s %s %s %s %s %s %s %s %s %s\n" "$CURTIME" "$ACCESS" "$TRAFFIC" "$LOAD1" "$LOAD2" "$LOAD3" "$CPULOAD" "$REQSEC" "$BYTESEC" "$BYTEREQ" "$REQPRO" "$IDLEWOR" >> $outputfile 
	sleep 30 
done
