FROM jenkins

USER root
RUN apt-get update && apt-get install bzip2

# install docker
RUN bash -c "if ! [ -e /usr/lib/apt/methods/https ]; then apt-get update && apt-get install -y apt-transport-https; fi"

RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

RUN \
  sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list" && \
  apt-get update && apt-get install -y lxc-docker && \
  rm /etc/apt/sources.list.d/docker.list

RUN apt-get install sudo

RUN sudo adduser jenkins sudo

RUN echo "jenkins   ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN gpasswd -a jenkins docker

USER jenkins

# install leiningen
RUN echo $PATH
RUN \
    cd /usr/bin && \
    # sudo wget http://github.com/technomancy/leiningen/raw/master/bin/lein && \
    sudo wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    sudo chmod +x lein

RUN lein self-install


