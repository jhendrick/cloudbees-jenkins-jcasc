FROM jenkins/jenkins:lts

LABEL maintainer "jhendrick@cloudbees.com"

USER root

#skip setup wizard and disable CLI
ENV JVM_OPTS -Djenkins.CLI.disabled=true -server
ENV TZ="/usr/share/zoneinfo/America/New_York"

#install suggested and additional plugins
#ENV JENKINS_UC http://jenkins-updates.cloudbees.com

#config-as-code plugin configuration
COPY config-as-code.yml /usr/share/jenkins/config-as-code.yml
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/config-as-code.yml

COPY ./jenkins_ref /usr/share/jenkins/ref

#install suggested and additional plugins
#ENV JENKINS_UC http://jenkins-updates.cloudbees.com
COPY plugins.txt plugins.txt
COPY jenkins-support /usr/local/bin/jenkins-support
COPY install-plugins.sh /usr/local/bin/install-plugins.sh
RUN  chmod +x /usr/local/bin/install-plugins.sh

RUN /usr/local/bin/install-plugins.sh $(cat plugins.txt)

USER jenkins