ARG PY_VERSION=3.9

FROM python:$PY_VERSION-slim
ENV DEBIAN_FRONTEND="noninteractive"

ARG JAX_VERSION=0.3
ARG FLAX_VERSION=0.3

RUN pip install --no-cache-dir \
    jax[cpu] jaxlib -f https://storage.googleapis.com/jax-releases/jax_releases.html \
    && pip install --no-cache-dir flax~=$FLAX_VERSION.0
