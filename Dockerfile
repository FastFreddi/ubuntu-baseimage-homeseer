
FROM phusion/baseimage:latest

ENV DEBIAN_FRONTEND noninteractive
ENV container docker

MAINTAINER FastFreddi

# set random root password
# RUN P="$(dd if=/dev/random bs=1 count=8 2>/dev/null | base64)" ; echo $P && echo "root:$P" | chpasswd
# set to foobar
# RUN P="foobar" ; echo $P && echo "root:$P" | chpasswd

# stuff for HomeSeer
RUN apt-get update && apt-get upgrade -y && \
		apt-get install -y mono-devel mono-vbnc flite chromium-browser aha ffmpeg alsa-base alsa-utils curl sudo wget vim screen && \
 		apt-get -y remove brltty && \
		apt-get update -y && apt-get clean

# HomeSeer Install
RUN wget https://homeseer.com/updates4/linux_4_1_10_0.tar.gz -O homeseer.tar.gz && \
 	tar xvf xvzf homeseer.tar.gz -C /usr/local && rm homeseer.tar.gz

# HomeSeer Startup
ADD runhomeseer.sh /etc/service/homeseer/run
RUN chmod -R 755 /etc/service/homeseer/run
ADD stophomeseer.sh /etc/service/homeseer/stop
RUN chmod -R 755 /etc/service/homeseer/stop
ADD stop_homeseer.sh /usr/local/HomeSeer/stop_homeseer.sh
RUN chmod -R 755 /usr/local/HomeSeer/stop_homeseer.sh

CMD ["/sbin/my_init"]
