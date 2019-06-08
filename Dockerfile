FROM ubuntu:xenial

RUN apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean

# Install OpenJDK JRE
RUN apt-get install openjdk-8-jre-headless -y

# Install haveged in order to fix the slow startup of the UniFi Controller
RUN apt-get install haveged -y

RUN apt-get install wget apt-transport-https -y

# Add a new source to the list of sources from which packages can be obtained with 'apt'
RUN echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list

# Add the GPG Keys
RUN wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg

# Update the package list and install UniFi
RUN apt-get update && apt-get install unifi -y

# Disable and stop the default mongodb instance (as UniFi starts its own instance)
RUN systemctl disable mongodb
# RUN systemctl stop mongodb

ENV BASEDIR=/usr/lib/unifi \
    DATADIR=/unifi/data \
    LOGDIR=/unifi/log

 # STUN
EXPOSE 3478/udp
# Speed test
EXPOSE 6789/tcp
# Device/ controller comm.
EXPOSE 8080/tcp
# Controller GUI/API as seen in a web browser
EXPOSE 8443/tcp
# HTTP portal redirection
EXPOSE 8880/tcp
# HTTPS portal redirection
EXPOSE 8843/tcp
# AP discovery
EXPOSE 10001/udp 
      
WORKDIR /usr/lib/unifi
ENTRYPOINT java -jar lib/ace.jar start