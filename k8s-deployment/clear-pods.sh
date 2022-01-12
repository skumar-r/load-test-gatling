#!/bin/bash

no_instances=$1
echo "Started clearing Load Test pods"
for (( i=1; i<=$no_instances; i++ ));
do
  kubectl delete pod load-test-pod-$i
done

echo "Started clearing Report Generation pod"
kubectl delete pod gatling-report-runner
