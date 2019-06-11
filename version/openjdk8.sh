#!/bin/bash -e

echo "================ Installing openjdk8 ================="
sudo yum install -y java-1.8.0-openjdk-devel

ln -s /usr/lib/jvm/java-1.8.0-openjdk /usr/lib/jvm/java-8-openjdk-amd64

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac 1
