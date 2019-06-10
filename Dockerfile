FROM centos:7.6.1810

ADD . /c7java

RUN /c7java/install.sh && rm -rf /tmp && mkdir /tmp && chmod 1777 /tmp

ENV BASH_ENV "/etc/drydock/.env"
