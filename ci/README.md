# CI using Concourse-CI

[![concourse.elpenguino.net](https://concourse.elpenguino.net/api/v1/pipelines/phippy/jobs/launch-phippy/badge)]

This folder presents examples for using ConcourseCI for:

1. Build of the various Docker images using Kaniko (for avoiding docker and Docker-in-Docker)
2. Upload of the image to a private registry
3. Deployment of the helm chart + image to a kubernetes cluster

# Steps to setup basic example

1. Create service account `concourse` in namespace `dev` by running `kubectl apply -f dev-rbac.yml`
2. Extract the service account token by running `./create-kubeconfig.sh concourse --namespace dev`
3. Copy `vars.yml-example` to `vars.yml` and populate with your kube CA cert (*found in `/etc/kubernetes/pki/ca.crt` on kubeadm-built master nodes*), token (*extracted above*), and URL to API endpoint (*also can be extracted from the kubeconfig generated above*)
4. Create the 4 pipelines by running something like this:

```
fly -t concourse sp -c pipeline.yml -p nodebrady -l vars.yml -v component=nodebrady
fly -t concourse sp -c pipeline.yml -p parrot -l vars.yml -v component=nodebrady
fly -t concourse sp -c pipeline.yml -p phippy -l vars.yml -v component=nodebrady
fly -t concourse sp -c pipeline.yml -p captainkube -l vars.yml -v component=nodebrady

fly -t concourse unpause-pipeline -p nodebrady
fly -t concourse unpause-pipeline -p parrot
fly -t concourse unpause-pipeline -p phippy
fly -t concourse unpause-pipeline -p captainkube
```

