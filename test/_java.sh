#!/bin/bash -e

echo "============================ JDK versions ==============================="

shipctl jdk set openjdk8
printf "\n"
java -version
printf "\n"

shipctl jdk set openjdk11
printf "\n"
java -version
printf "\n"
