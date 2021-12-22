# docker-images
Repository for automatically building base Docker images with Github Actions.  I use these images for personal projects and educational purposes.  By design, I have tried to make them secure and self-sufficient, but make no guarantees if you decide to use them in your work.

All images are available in Docker Hub: https://hub.docker.com/u/fkodom

## Automatic Builds

All images are re-built and published to Docker Hub each Sunday at midnight (Central).  In theory, this means that the latest security patches/updates are added to the base images every week.  The versions for Python and other essential packages (e.g. Python==3.8, PyTorch==1.9) are pinned, but all other packages are updated to the latest compatible version for security purposes.
