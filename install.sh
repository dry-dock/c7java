#!/bin/bash -e

echo "================= Adding some global settings ==================="
mkdir -p "$HOME/.ssh/"
mv /c7java/config "$HOME/.ssh/"
cat /c7java/90forceyes >> /etc/yum.conf
touch "$HOME/.ssh/known_hosts"
mkdir -p /etc/drydock

echo "================= Installing basic packages ================"

yum -y install  \
sudo \
software-properties-common \
wget \
curl \
openssh-client \
ftp \
gettext \
smbclient \
openssl \
unzip \
which

echo "================= Installing Python packages ==================="
sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
#adding key required to install python
gpgkey=http://springdale.math.ias.edu/data/puias/6/x86_64/os/RPM-GPG-KEY-puias

sudo yum install -y \
  python-devel \
  python-pip

sudo pip2 install virtualenv==16.5.0
sudo pip2 install pyOpenSSL==19.0.0

export JQ_VERSION=1.5*
echo "================= Adding JQ $JQ_VERSION ==================="
sudo yum install -y jq-"$JQ_VERSION"

echo "================= Installing CLIs packages ======================"

export GIT_VERSION=2.18.0
echo "================= Installing Git $GIT_VERSION ===================="
sudo yum install -y http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
sudo yum install -y git-"$GIT_VERSION"

export GCLOUD_SDKREPO=249.0*
echo "================= Adding gcloud $GCLOUD_SDKREPO  ============"
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
#adding key required to install gcloud
rpm --import  https://packages.cloud.google.com/yum/doc/yum-key.gpg
rpm --import  https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
sudo yum install -y google-cloud-sdk-"$GCLOUD_SDKREPO"

export AWS_VERSION=1.16.173
echo "================= Adding awscli $AWS_VERSION ===================="
sudo pip install awscli=="$AWS_VERSION"

AZURE_CLI_VERSION=2.0*
echo "================ Adding azure-cli $AZURE_CLI_VERSION  =============="
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install -y azure-cli-$AZURE_CLI_VERSION

export JFROG_VERSION=1.25.0
echo "================= Adding jfrog-cli $JFROG_VERSION==================="
wget -nv https://api.bintray.com/content/jfrog/jfrog-cli-go/"$JFROG_VERSION"/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 -O jfrog
sudo chmod +x jfrog
sudo mv jfrog /usr/bin/jfrog

echo "================== Installing java packages ==================="

GRADLE_VERSION=5.4.1
echo "Installing gradle version: $GRADLE_VERSION"
echo "================ Installing gradle ================="
wget -nv https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-all.zip
unzip -qq gradle-$GRADLE_VERSION-all.zip -d /usr/local && rm -f gradle-$GRADLE_VERSION-all.zip
ln -fs /usr/local/gradle-$GRADLE_VERSION/bin/gradle /usr/bin
echo 'export PATH=$PATH:/usr/local/gradle-$GRADLE_VERSION/bin' >> /etc/drydock/.env

APACHE_MAVEN_MAJOR_VERSION=3
APACHE_MAVEN_VERSION=3.6.1
echo "Installing apache-maven version: $APACHE_MAVEN_VERSION"
echo "================ Installing apache-maven-$APACHE_MAVEN_VERSION ================="
wget -nv http://www-eu.apache.org/dist/maven/maven-$APACHE_MAVEN_MAJOR_VERSION/$APACHE_MAVEN_VERSION/binaries/apache-maven-$APACHE_MAVEN_VERSION-bin.tar.gz
tar xzf apache-maven-$APACHE_MAVEN_VERSION-bin.tar.gz -C /usr/local && rm -f apache-maven-$APACHE_MAVEN_VERSION-bin.tar.gz
ln -fs /usr/local/apache-maven-$APACHE_MAVEN_VERSION/bin/mvn /usr/bin
echo 'export PATH=$PATH:/usr/local/apache-maven-$APACHE_MAVEN_VERSION/bin' >> /etc/drydock/.env

APACHE_ANT_VERSION=1.10.6
echo "Installing apache-ant version: $APACHE_ANT_VERSION"
echo "================ Installing apache-ant-$APACHE_ANT_VERSION ================="
wget -nv https://archive.apache.org/dist/ant/binaries/apache-ant-$APACHE_ANT_VERSION-bin.tar.gz
tar xzf apache-ant-$APACHE_ANT_VERSION-bin.tar.gz -C /usr/local && rm -f apache-ant-$APACHE_ANT_VERSION-bin.tar.gz
ln -fs /usr/local/apache-ant-$APACHE_ANT_VERSION/bin/ant /usr/bin
echo 'export ANT_HOME=/usr/local/apache-ant-$APACHE_ANT_VERSION' >> /etc/drydock/.env
echo 'export PATH=$PATH:/usr/local/apache-ant-$APACHE_ANT_VERSION/bin' >> /etc/drydock/.env

for file in /c7java/version/*.sh;
do
  $file
done
