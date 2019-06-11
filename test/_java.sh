#!/bin/bash -e

echo "============================ JDK versions ==============================="
echo "update-alternatives --list java"
update-alternatives --list java
printf "\n\n"

echo "update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java"
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/bin/java
printf "\n"
java -version
printf "\n"

echo "update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java"
update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java
printf "\n"
java -version
printf "\n"
