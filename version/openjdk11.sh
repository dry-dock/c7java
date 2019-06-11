#!/bin/bash -e

export JAVA_VERSION=11

export OPENJDK_VERSION=11.0.2
echo "================= Installing openjdk $OPENJDK_VERSION ==================="
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget "https://download.java.net/java/GA/jdk11/9/GPL/openjdk-"$OPENJDK_VERSION"_linux-x64_bin.tar.gz"
tar -xzf openjdk-"$OPENJDK_VERSION"_linux-x64_bin.tar.gz
mv jdk-"$OPENJDK_VERSION"/ java-"$JAVA_VERSION"-openjdk-amd64

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-"$JAVA_VERSION"-openjdk-amd64/bin/java
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-"$JAVA_VERSION"-openjdk-amd64/bin/javac 
