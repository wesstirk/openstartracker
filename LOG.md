# General Log of Updates

## February 24, 2021 - Jackson

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


## March 2, 2021 - Wesley

I worked on getting up to speed on the Docker file that Jackson started.
When I run it I use: 
`docker run -it -v $(pwd)/:/root/repo startracker`
that way I can edit the files and have them automatically updated in the docker image. 

All in all, the Dockerfile seems to work ok, although I have the same issue of it hanging on the images. It never seems to finish. 

I started looking through the unit_test.sh and the startracker.py. 
This seems like a completely convoluted system.
Why would you setup a server expecting UDP/TCP packets just so that you could send python commands to the python script??
I think that the next thing I am going to do when I have time is create a new script, or change the old one to just be a command line tool.
Argparse makes that so easy. 

TODO: Update .gitignore we need to clean this up a little bit. 

## March 9, 2021 - Wesley

I did make a command line interface for the startracker.
It is called `startracker_cli.py`. 
I tried to change as little as posisble. 

I ran `python3 startracker_cli.py science_cam_may8_0.05sec_gain40/calibration.txt 1991.25 science_cam_may8_0.05sec_gain40/median_image.png science_cam_may8_0.05sec_gain40/samples/img4.png` in the test directory and it seemed to work ok.