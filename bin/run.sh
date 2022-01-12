#!/bin/bash
## Clean reports
rm -rf target/gatling/*

# Run load test
mvn gatling:test

#Upload reports
num=1
for _dir in target/gatling/*/
do
  if [ "${_dir}" != "target/gatling/export/" ]; then
    cp ${_dir}simulation.log  target/gatling/export/$num-$HOSTNAME-simulation.log
    num=$((num+1))
  fi
done