FROM centos:centos7

LABEL maintainer "genzouw <genzouw@gmail.com>"

RUN yum install -y \
  https://rpm.nodesource.com/pub_12.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm \
;

RUN echo -e $'\n\
alias vi='vim'\n\
set -o vi\n\
' >> /root/.bashrc

ENV PS1 '$ '

RUN yum install -y epel-release \
  && yum install -y \
       automake \
       gcc \
       gcc-c++ \
       git \
       golang \
       make \
       nodejs \
       vim \
  && rm -rf /var/cache/yum/* \
  && yum clean all \
;
