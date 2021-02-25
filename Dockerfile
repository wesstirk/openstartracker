FROM ubuntu:20.04

# Install build-essential
RUN apt-get update && apt-get install -y \
    build-essential

# Setup tzdata noninteractive
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install python3.8
RUN apt-get update && apt-get install -y \
    python3-dev \
    python3-pip

# Update pip
RUN pip3 install --upgrade pip

# Install opencv 
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    python3-opencv

# Install astrometry stuff
RUN apt-get update && apt-get install -y \
    astrometry.net \
    wget

# Download index files
RUN cd /usr/share/astrometry && \
    wget http://data.astrometry.net/4100/index-4112.fits && \ 
    wget http://data.astrometry.net/4100/index-4113.fits && \
    wget http://data.astrometry.net/4100/index-4114.fits && \
    wget http://data.astrometry.net/4100/index-4115.fits && \
    wget http://data.astrometry.net/4100/index-4116.fits && \
    wget http://data.astrometry.net/4100/index-4117.fits && \
    wget http://data.astrometry.net/4100/index-4118.fits && \
    wget http://data.astrometry.net/4100/index-4119.fits

# Install python deps 
RUN apt-get update && apt-get install -y \
    python3-scipy \
    python3-astropy \
    python3-systemd \
    python3-pandas \
    python3-pkgconfig

# Install important tools
RUN apt-get update && apt-get install -y \
    swig \ 
    git \
    graphviz \
    netcat \
    bc

# Install python dependencies
RUN pip3 install gprof2dot

WORKDIR /root

# Copy repo
COPY . .

# run terminal
CMD [ "/bin/bash" ]