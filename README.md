# jenkins-custom-docker

Example for building a Jenkins custom docker image with a customizable set of plugins

Build:  docker build -t <tag-name> .
Run  : docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home <tag-name>

Open plugins.txt to customize the set of plugins that will be downloaded and configured.

Uses the config as code plugin to customize Jenkins.  See config-as-code.yml