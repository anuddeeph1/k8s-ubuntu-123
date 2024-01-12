FROM rancher/docker-dind-base

RUN sudo yum install wget -y

RUN sudo yum install git -y

RUN sudo yum install sudo -y

RUN sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

RUN sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

RUN sudo yum install java-11-openjdk.x86_64 -y

RUN sudo yum install jenkins -y

RUN sudo yum install net-tools -y

RUN sudo yum install python36 -y

RUN sudo yum install /sbin/service -y

RUN sudo yum install initscripts -y

RUN sudo yum install httpd -y

RUN sudo yum install git -y

RUN sudo yum install vim -y

RUN sudo yum install openssh-clients -y

RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

RUN sudo chmod +x ./kubectl

RUN sudo mv ./kubectl /usr/bin/

COPY  config /root/.kube/config

RUN sudo yum install ncurses -y

CMD java -jar /usr/lib/jenkins/jenkins.war && /bin/bash

EXPOSE 8085

