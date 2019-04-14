FROM centos:centos7

RUN yum install -y epel-release \
  && yum install -y \
       automake \
       gcc \
       gcc-c++ \
       git \
       golang \
       make \
       nodejs \
       npm \
       vim \
  && rm -rf /var/cache/yum/* \
  && yum clean all \
;

ENV PS1 '$ '
