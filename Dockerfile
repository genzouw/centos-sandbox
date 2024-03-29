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
    man \
    mercurial \
    ncurses-devel \
    nodejs \
    perl-ExtUtils-Embed \
    perl-devel \
    python-devel \
    rpm-build \
    w3m \
  && yum reinstall --setopt=tsflags='' -y \
    bash \
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
export PS1="\n\[\e[1;33m\]\$ \[\e[m\]"\n\
alias vi='vim'\n\
set -o vi\n\
\n\
{\n\
  echo '----------'\n\
  echo "\$ uname -moi"\n\
  uname -moi\n\
  echo\n\
  echo "\$ head -n 2 /etc/os-release"\n\
  head -n 2 /etc/os-release\n\
  echo\n\
  echo "\$ bash -version | head -n 1"\n\
  bash -version | head -n 1\n\
  echo '----------'\n\
}\n\
' >> /root/.bashrc

ENTRYPOINT ["/bin/bash"]
