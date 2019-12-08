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
    lua-devel \
    make \
    mercurial \
    ncurses-devel \
    nodejs \
    perl-ExtUtils-Embed \
    perl-devel \
    python-devel \
    rpm-build \
    w3m \
  && yum clean all \
  && rm -rf /var/cache/yum/* \
;

RUN git clone \
  https://github.com/vim/vim.git \
  "/usr/local/src/vim"

RUN cd /usr/local/src/vim \
  && ./configure \
    --with-local-dir=/usr \
    --enable-multibyte \
    --enable-tclinterp \
    --disable-xsmp \
    --disable-netbeans \
    --disable-gtktest \
    --disable-gpm \
    --disable-selinux \
    --without-gnome \
    --enable-luainterp=yes \
    --enable-signs -enable-python3interp=yes \
  && make -j2 \
  && make install \
  && rm -rf /usr/local/src/vim \
  ;

RUN ln -s \
  "/usr/local/bin/vim" \
  "/usr/local/bin/vi"

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

ENTRYPOINT ["/bin/bash"]
