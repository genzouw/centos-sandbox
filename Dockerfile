FROM centos:centos7

LABEL maintainer "genzouw <genzouw@gmail.com>"

RUN yum install -y \
  https://rpm.nodesource.com/pub_12.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm \
;

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
  && yum clean all \
  && rm -rf /var/cache/yum/* \
;

RUN echo -e $'\n\
alias vi='vim'\n\
set -o vi\n\
\n\
{\n\
  echo '----------'\n\
  echo "\$ uname -moi"\n\
  uname -moi\n\
  echo\n\
  echo "\$ bash -version | head -n 1"\n\
  bash -version | head -n 1\n\
  echo '----------'\n\
}\n\
' >> /root/.bashrc

ENV PS1 '\e[1;33m\n$ \e[0;37;40m'
