# cloudbees-jenkins-jcasc

Example for customizing the CloudBees Jenkins docker distribution with a customizable set of plugins utilizing JCasc
  
Open plugins.txt to customize the set of plugins that will be downloaded and configured.  Uses the config as code plugin to customize Jenkins.  See config-as-code.yml

Also contains example Knative tekton-pipeline for building, pushing to docker hub and deploying to a Kubernetes cluster.  For more details on installing tekton-pipelines see: https://github.com/knative/build-pipeline

To push to docker hub you will need to create a secret on your cluster with your docker hub credentials:

```bash
kubectl create secret docker-registry dockerhub-push-secret --docker-server=https://index.docker.io/v1/ --docker-email=<docker-email> --docker-username=<docker-username> --docker-password=<docker-pass>
```

After tekton-pipelines are installed, apply the tekton-pipelines yaml file:

```bash
kubectl apply -f tekton-build-push-deploy-git.yaml
```
The above command will kick off the manual PipelineRun.  To get logs for the Tekton pipeline step:

```bash
kubectl -n default logs <pod-name> -c <step name>
```

Where step name is something like: build-step-build-and-push
