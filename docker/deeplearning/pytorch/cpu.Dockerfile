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

ARG TORCH_VERSION=1.10
# TODO: Make this work when TORCH_VERSION includes the patch version. Currently,
# it only works for 'TORCH_VERSION=X.Y' formats.
RUN pip install --upgrade pip \
    && export TORCH_LATEST_VERSION=$(pip index versions torch | grep -Eo "${TORCH_VERSION}.[0-9]" | head -1) \
    && pip install --no-cache-dir \
    torch==$TORCH_LATEST_VERSION+cpu \
    -f https://download.pytorch.org/whl/torch_stable.html

# TODO: Possibly also install 'torchvision' and 'torchaudio' CPU-only versions?
# Either need to add the version number as an argument, or find a clever way to 
# find the latest compatible version using 'pip'.
