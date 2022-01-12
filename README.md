# load-test-gatling

This project is to run the load test against the two APIs exposed by the simple-boot-service.

Prerequiities:

1. Docker and Kubernetes installed
2. JDK 1.8 or higher installed
3. Kubernetes Dashboard ( Optional)
4. Docker Registry ( Optional; Can use any public registry instead )

Configuration:

1. For Docker Compose based testing ( Optional, by default the application will log in project root directory)
    a. We can  update volumnes for 'gatling-test-service' and 'gatling-report-service' in docker-compose.yml
    b. For 'gatling-test-service', update the volume like <local_path>:/build/target/gatling/export
    c. For 'gatling-report-service', update the volume like <local_path>:/opt/gatling/results

2. For testing with Kubernetes pod


Steps to Run :
1. Build the images using  docker compose
    docker compose build
2. Check whether you got two new images with names , gatling-test-runner and gatling-report-runner
3. Run the test
    a. With Docker Compose
        1. use the command 'docker compose up' , this would start two  container instances ( one for each image). To scale run 'docker compose up --scale gatling-test-service=<count>'
        2. Note: Scale only 'gatling-test-service' to the desired count, but run the 'gatling-report-service' only once
    b. With Kubernetes
