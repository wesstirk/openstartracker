Using the python base image becuse I can't seem to install it on ubuntu and add it to path

based on buildpack-deps so should have git and a modern c++ compiler

need apt-get update before running apt-get
use apt-get -y to supress prompts
docker best practice is to have individual dependances on their own lines

python-astropy doesn't exist on debian package list, install with pip

Python base image sets CMD to python, lets change it back to bash

Python headers are used by beast, with hardcoded reference in makefiles
TODO: There should be a way to autodetect? 
but for now we'll hardcode python3.7 because that's what apt-get install on debian for python3-dev

Why can't python find cv2..
Looks like python-opencv installs cv2 in the system python2
python3-opencv installs cv2 in the system python3
Which isn't the same as the python 3 in /usr/local/bin (the on in path)
The python installed by python3-dev is 3.7.3, rather than 3.7.10 included with the base image.. maybe we need ubuntu with python3-dev...

switching to use pip to install opencv instead of python-opencv

Actually we're just going to do this from the beginning, using ubuntu base image, installing python3.8 and pip

TODO: use requirements.txt to install python deps?

Ok, after seting tzdata install to be non-interactive, looks like we now can install all the dependencies..

What we're missing now are index files.. not sure what they are..
They are maps of the sky that the algorithm compares against

Where do they go? suggestions /usr/local/astrometry, but I don't see that directory yet

Ahh.. the directory is /usr/share/astrometry
Does that mean we can move our repository code to /root or something?

Ok.. calibration looking good..
Now I can't find nc, dot, and gprof2dot commands.. hmm..

Ok.. dot comes from graphviz, nc comes from netcat, and gprof2dot can be installed with pip...
Looks like netcat is used to pass images to startracker.py daemon

Seems to hang forever.. not sure what the deal is there..