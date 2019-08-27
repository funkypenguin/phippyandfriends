#!/busybox/sh
set -x

pwd

# Retrieve the build directory which can vary across concourse workers
DIR=`ls /tmp/build/`

# Perform the build using Kaniko
/kaniko/executor  \
--dockerfile=/tmp/build/$DIR/git-source/$COMPONENT/Dockerfile \
--destination=doesnt/matter:we-are-not-pushing \
--context=/tmp/build/$DIR/git-source/$COMPONENT/ \
--no-push
--tarPath=/tmp/build/$DIR/image/image.tar
