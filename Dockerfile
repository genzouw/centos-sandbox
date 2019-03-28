FROM centos:centos7

RUN yum install -y epel-release \
  && yum install -y git vim make \
  && rm -rf /var/cache/yum/* \
  && yum clean all \
;

ENV PS1 '$ '
