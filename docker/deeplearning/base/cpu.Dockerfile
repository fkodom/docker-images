ARG PY_VERSION=3.9

FROM python:$PY_VERSION
ENV DEBIAN_FRONTEND="noninteractive"

# Install apt-get dependencies and Google Cloud SDK, then remove
# files that are not needed to run the container.
RUN apt update --fix-missing && apt upgrade -y \
    && apt install -y build-essential curl ffmpeg libsm6 libxext6 software-properties-common unzip \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
