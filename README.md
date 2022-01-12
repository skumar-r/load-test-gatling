# load-test-gatling

This project is to run the load test against the two APIs exposed by the simple-boot-service.

<b>Prerequiities:</b>

1. Docker and Kubernetes installed
2. JDK 1.8 or higher installed
3. Kubernetes Dashboard ( Optional)
4. Docker Registry ( Optional; Can use any public registry instead )
5. Maven version 3.1.0 for simple-boot-service

<b>Configuration:</b>

1. For Docker Compose based testing ( Optional, by default the application will log in project root directory)<br />
    a. We can  update volumnes for 'gatling-test-service' and 'gatling-report-service' in docker-compose.yml<br />
    b. For 'gatling-test-service', update the volume like <local_path>:/build/target/gatling/export<br />
    c. For 'gatling-report-service', update the volume like <local_path>:/opt/gatling/results<br />

2. For testing with Kubernetes pod <br/>
    a. Change directory to k8s-deployment <br/>
    b. Open 'load-test-pod-template.yaml' and update <br/>
        1.  'volumes.hostPath.path' with the path where we require simulation logs to be placed. Volume Path format : '/<folder1>/<folder2>/export' <br/>
        2. 'containers.image'  with the registry path from where kubernetes can pull the image of test service <br/>
    c.  Open 'report-pod.yaml' and update the 'volumes.hostPath.path' with the path where we have simulation logs  and update the image location as well in 'containers.image'. <br/>
            Volume Path format : '/<folder1>/<folder2>'   Note: Use the path  given in 2.b.1 , but without '/export' <br/>


<b>Steps to Run :</b>
1. Build the images using  docker compose<br />
    docker compose build
2. Check whether you got two new images with names , gatling-test-runner and gatling-report-runner<br />
3. Build and Start the simple-boot-service <br />
3. Run the test<br />
    a. With Docker Compose<br />
        1. use the command 'docker compose up' , this would start two  container instances ( one for each image). To scale run 'docker compose up --scale gatling-test-service=<count>' <br />
        2. Note: Scale  'gatling-test-service' only to the desired count, but run the 'gatling-report-service' with 1 instance <br />
    b. With Kubernetes<br />
