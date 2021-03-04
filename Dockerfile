# ubuntu 20.04 LTS
FROM ubuntu:20.04
MAINTAINER nade0303@gmail.com

# prevent interactive install requirements
ARG DEBIAN_FRONTEND=noninteractive
# wine branch
ARG WINE_BRANCH="stable"

# install requirement packages
RUN apt-get update \
			&& apt-get install -y --no-install-recommends \
			ca-certificates \
			git \
			gnupg \
			gpg-agent \
			software-properties-common \
			wget

# remove apt package lists
RUN rm -rf /var/lib/apt/lists/*

# enable 32 bit architecture
RUN dpkg --add-architecture i386
# download and add repository key
RUN wget -nc -O winehq.key https://dl.winehq.org/wine-builds/winehq.key \
	&& APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add winehq.key
# add repository
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' \
	&& apt-get update
# install stable wine
RUN apt-get install -y --install-recommends winehq-${WINE_BRANCH}

# remove apt pcakge lists
RUN rm -rf /var/lib/apt/lists/*

#RUN wget -nv -O- https://dl.winehq.org/wine-builds/winehq.key | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - \
#    && apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(grep VERSION_CODENAME= /etc/os-release | cut -d= -f2) main" \
#    && dpkg --add-architecture i386 \
#    && apt-get update \
#    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --install-recommends winehq-${WINE_BRANCH} \
#    && rm -rf /var/lib/apt/lists/*
