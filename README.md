# cloudbees-jenkins-jcasc

Example for building a CloudBees Jenkins docker image with a customizable set of plugins utilizing JCasc

```bash
Build:  docker build -t <tag-name> .
```
```bash 
Run  : docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home <tag-name>
```
  
Open plugins.txt to customize the set of plugins that will be downloaded and configured.  Uses the config as code plugin to customize Jenkins.  See config-as-code.yml

Also contains example Knative tekton-pipeline for building, pushing to docker hub and deploying to a Kubernetes cluster.  For more details on tekton-pipelines see: https://github.com/knative/build-pipeline

To push to docker hub you will need to create a secret on your cluster with your docker hub credentials:

```bash
kubectl create secret docker-registry dockerhub-push-secret --docker-server=https://index.docker.io/v1/ --docker-email=<docker-email> --docker-username=<docker-username> --docker-password=<docker-pass>
```