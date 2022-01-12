#!/bin/bash

set -e
ready=0
pwd
while [ $ready -eq 0 ]
do
  if    ls -1A ./results/export/ | grep -q .
  then  ready=1
  else  ready=0
  fi
  >&2 echo "Gatling Test Service is still executing and logs are not yet generated"
  sleep 1m
done

>&2 echo "Gatling Test Service completed execution. Starting report generation"
bin/gatling.sh -ro export