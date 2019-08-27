#!/busybox/sh

# Perform the build using Kaniko
/kaniko/executor  \
--dockerfile=git-source/$COMPONENT/Dockerfile \
--destination=doesnt/matter:we-are-not-pushing \
--context=git-source/$COMPONENT/ \
--no-push \
--tarPath=image/image.tar
