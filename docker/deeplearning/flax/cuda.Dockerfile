ARG UBUNTU_VERSION=20.04
ARG CUDA_VERSION=11.1.1
ARG CUDA_OPSET=devel

FROM nvidia/cuda:$CUDA_VERSION-$CUDA_OPSET-ubuntu$UBUNTU_VERSION
ENV DEBIAN_FRONTEND="noninteractive"

# Install apt-get dependencies and Google Cloud SDK, then remove
# files that are not needed to run the container.
RUN apt update --fix-missing \
    && apt install -y software-properties-common \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ARG PY_VERSION=3.9

RUN add-apt-repository ppa:deadsnakes/ppa && apt update \
    && apt install -y python$PY_VERSION-dev \
    && update-alternatives --install /usr/bin/python python /usr/bin/python$PY_VERSION 10 \
    && apt install -y python3-setuptools \
    && python -m easy_install pip \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ARG JAX_VERSION=0.3
ARG FLAX_VERSION=0.5

RUN pip install --no-cache-dir \
    jax[cuda]~=$JAX_VERSION.0 \
    jaxlib[cuda11_cudnn82] \
    -f https://storage.googleapis.com/jax-releases/jax_releases.html \
    && pip install --no-cache-dir flax~=$FLAX_VERSION.0
    
