#!/bin/bash

no_instances=$1

for (( i=1; i<=$no_instances; i++ ));
do
  sed "s/{{test-pod-name}}/load-test-pod-$i/g" load-test-pod-template.yaml | kubectl apply -f - ;
done

kubectl apply -f report-pod.yaml

echo 'Load testing started.'
sleep 5s
running=1
progress="-"

while [ $running -eq 1 ]
do
  number_of_pods=`kubectl get pods | grep -c "Running"`
  if  [ "$number_of_pods" -eq 0 ];
  then
      running=0
      echo -ne '\n'
      echo 'Load testing completed.'
      echo 'Kubernetes Pod Status'
      kubectl get pods
      volume_path=`kubectl describe pod | grep "Path" | head -2`
      echo "Please check for reports in below path"
      echo $volume_path
  else
    running=1
    progress=${progress}"-"
    echo -ne $progress "\r"
    sleep 5s
  fi

  sleep 5s
done
