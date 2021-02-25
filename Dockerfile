FROM ubuntu:20.04

# Install build-essential
RUN apt-get update && apt-get install -y \
    build-essential

# Install opencv 
RUN apt-get update && apt-get install -y \
    libopencv-dev

# Install python3.8
RUN apt-get update && apt-get install -y \
    python3-dev \
    python3-pip

# Update pip
RUN pip3 install --upgrade pip

# Install python dependencies
RUN pip3 install scipy python-opencv

# Install astrometry stuff
RUN apt-get update && apt-get install -y \
    swig \ 
    astrometry.net

# Install astropy
RUN pip3 install astropy

WORKDIR /usr/share/astrometry

# Copy repo
COPY . .

# run terminal
CMD [ "/bin/bash" ]