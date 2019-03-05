# cloudbees-jenkins-jcasc

Example for customizing the CloudBees Jenkins docker distribution with a customizable set of plugins utilizing JCasc
  
Open plugins.txt to customize the set of plugins that will be downloaded and configured.  Uses the config as code plugin to customize Jenkins.  See config-as-code.yml

Also contains example Knative tekton-pipeline for building, pushing to docker hub and deploying to a Kubernetes cluster.  For more details on installing tekton-pipelines see: https://github.com/knative/build-pipeline

To push to docker hub you will need to create a secret on your cluster with your docker hub credentials:
```
kubectl create secret docker-registry dockerhub-push-secret --docker-server=https://index.docker.io/v1/ --docker-email=<docker-email> --docker-username=<docker-username> --docker-password=<docker-pass>
```

After creating the secret, it needs to applied to the service account being used:
```
kubectl edit serviceaccount default
```
This will open the resource in the default text editor, under the secrets add the newly created secret:
```
secrets:
  - name: default-token-zd84v
  - name: dockerhub-push-secret
```

After tekton-pipelines are installed, apply the tekton-pipelines yaml file:
```
kubectl apply -f tekton-build-push-deploy-git.yaml
```

The above command will kick off the manual PipelineRun.  To get logs for the Tekton pipeline step:
```
kubectl -n default logs <pod-name> -c build-step-<step-name>
```

Where step name is something like: *build-and-push*

The end result will be the CloudBees Jenkins container successfully deployed and running in the cluster.  To get the endpoint where CloudBees is running, run the following command:

```
kubectl get services -l app=jenkins-web
```
