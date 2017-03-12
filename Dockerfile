
FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV container docker

MAINTAINER FastFreddi


# clean out, update and install some base utilities
RUN apt-get -y update && apt-get -y upgrade && apt-get clean && \
		apt-get -y install apt-utils lsb-release curl git cron at logrotate rsyslog \
			ssmtp lsof procps sysvinit-core sysvinit-utils \
			initscripts libudev1 udev util-linux && \
		apt-get clean

# remove systemd
RUN cp /usr/share/sysvinit/inittab /etc/inittab
RUN apt-get remove --purge --auto-remove systemd && \
    echo -e 'Package: systemd\nPin: release *\nPin-Priority: -1' > /etc/apt/preferences.d/systemd && \
    echo -e '\n\nPackage: *systemd*\nPin: release *\nPin-Priority: -1' >> /etc/apt/preferences.d/systemd && \
    echo -e '\nPackage: systemd:amd64\nPin: release *\nPin-Priority: -1' >> /etc/apt/preferences.d/systemd && \
    echo -e '\nPackage: systemd:i386\nPin: release *\nPin-Priority: -1' >> /etc/apt/preferences.d/systemd

# set random root password
# RUN P="$(dd if=/dev/random bs=1 count=8 2>/dev/null | base64)" ; echo $P && echo "root:$P" | chpasswd
# set to foobar
# RUN P="foobar" ; echo $P && echo "root:$P" | chpasswd


# stuff for HomeSeer
RUN apt-get update && apt-get upgrade -y && \
		apt-get install -y mono-vbnc libmono-system-web4.0.cil libmono-system-design4.0.cil \
		libmono-system-web-extensions4.0-cil libmono-system-runtime-caching4.0-cil flite chromium \
		libmono-system-data-datasetextensions4.0-cil libmono-system-xml-linq4.0-cil mono-complete sudo wget vim screen && \
		apt-get update -y && apt-get clean

# HomeSeer Install
RUN wget http://homeseer.com/updates3/hs3_linux_3_0_0_312.tar.gz && \
	tar xvf hs3_linux_3_0_0_312.tar.gz -C /usr/local && rm hs3_linux_3_0_0_312.tar.gz

# HomeSeer Startup
ADD homeseer /etc/init.d/homeseer
RUN chmod -R 755 /etc/init.d/homeseer && update-rc.d homeseer defaults

CMD ["/bin/bash"]
