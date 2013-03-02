dockerbuilder
=============

A script to build docker (using docker).

If you don't have a) pull access to the docker repo, and b) admin access to the docker build mirror, you can't use this script. But you can read it for educational value!

## Instructions

1. Install Docker (don't have access to Docker? Get in touch and I'll hook you up)
2. Build the builder (yes, my head hurts too):  `./build.sh`
3. Run the builder: docker run -a -i _tmp/dockerbuilder /usr/local/bin/dockerbuilder REVISION AWS_ID AWS_KEY
