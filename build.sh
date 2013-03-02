#!/bin/sh

set -x

IMG=shykes/devbox:eb5b60baebd62d85
DEST=_tmp/dockerbuilder

# Print the most recently created conntainer
# (warning this is a hack susceptible to race conditions)
# We need because 'docker run' can't inject stdin and return the container ID at the same time
# (solution: implement that)
last() { docker ps -a -q | head -n 1; }

run_and_commit() { docker run $4 -a $1 /bin/sh -c "touch /tmp/$RANDOM; $2"; docker commit $(last) $3; }

# This is a hack (what I really want is an image copy)
copy() { run_and_commit $1 /bin/true $2; }

TMP=_tmp/$RANDOM

if [ -z "$DEST" ]; then
	echo "Usage: $0 dest"
	exit 1
fi

copy $IMG $TMP

# Inject file
run_and_commit $TMP 'cat > /usr/local/bin/dockerbuilder; chmod +x /usr/local/bin/dockerbuilder' $TMP -i < dockerbuilder

# Save final image
copy $TMP $DEST
