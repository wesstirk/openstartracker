FROM python:3.7

# Install astrometry stuff
RUN apt-get update && apt-get install -y \
    python3-dev \
    python-scipy \
    libopencv-dev \
    python3-opencv \
    swig \ 
    python-systemd \
    astrometry.net

# Install astropy
RUN pip install astropy

# Install opencv


WORKDIR /usr/share/astrometry

# Copy repo
COPY . .

# run terminal
CMD [ "/bin/bash" ]