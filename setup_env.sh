#!/usr/bin/bash

: "Comment1
This is a shell script i'm making because I'm getting sick of setting up my 
programming environment every time I get a new computer/vm set up.
eh, not sure what do do about the root thing, I don't always want it to be root
Usage: ./setup_env.sh
"

: "Comment2
Sadly, not everything is very easily scriptable, so in this section I'm going to add some commands I like to execute
in addition to the ones listed here.
To edit the standard background in Fedora 17 change this file:
/usr/share/backgrounds/beefy-miracle/default/beefy-miracle.xml
"

yum install emacs gnome-tweak-tool starter-kit htop mysql mysql-devel mysql-server postgresql postgresql-devel R R-devel libquicktime.x86_64 -y

#Install spotify!  This will almost certainly start breaking eventually 
#as it is only for a specific version.  Also, the final rpm you need to
#install is listed in the output, but I didn't parse it out

yum install wget rpmdevtools rpm-build yum-utils -y
sudo -u $SUDO_USER rpmdev-setuptree
sudo -u $SUDO_USER cd $(rpm --eval %_sourcedir)
sudo -u $SUDO_USER wget http://leamas.fedorapeople.org/spotify/0.8.8/spotify-client.spec
sudo -u $SUDO_USER spectool -g spotify-client.spec
yum-builddep spotify-client.spec
sudo -u $SUDO_USER env QA_RPATHS=$((0x02|0x08)) rpmbuild --bb spotify-client.spec
sudo -u $SUDO_USER echo ''
sudo -u $SUDO_USER echo -e '\e[00;31mHey, you gotta install the rpm this created, it is listed in the output
of the command that was just executed\e[00m'

#install google chrome
var="[google-chrome]
name=google-chrome - 64-bit
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub"

echo "$var" > /etc/yum.repos.d/google-chrome.repo
yum install libXrandr.x86_64 libXrandr-devel.x86_64 google-chrome-stable -y

#install rvm
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel
#ehhh, I guess we can't really do this, it needs to be run as not superuser
#well, you can probably do it.. somehow.  The prerequisites are installed now though
echo -e '\e[00;31mTo install rvm and ruby: \curl -L https://get.rvm.io | bash -s stable --ruby\e[00m'
#Yay! We can do this now
sudo -u $SUDO_USER curl -L https://get.rvm.io |bash -s stable --ruby

: "Actually not needed, because of fedora-utils
#install Flash
rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
yum install flash-plugin nspluginwrapper alsa-plugins-pulseaudio libcurl -y
"

#install fedora-utils (may not need the flash and google-chrome entries then..)
#curl http://download.opensuse.org/repositories/home:/satya164:/zenity/Fedora_17/home:satya164:zenity.repo -o /etc/yum.repos.d/zenity.repo && yum update zenity
#Updated command for fedora 18, should probably put in some kind of if check
curl http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_18/home:satya164:fedorautils.repo -o /etc/yum.repos.d/fedorautils.repo && yum install fedorautils
