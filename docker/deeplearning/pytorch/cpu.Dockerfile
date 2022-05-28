ARG PY_VERSION=3.9

FROM python:$PY_VERSION-slim
ENV DEBIAN_FRONTEND="noninteractive"

ARG TORCH_VERSION=1.10
# TODO: Make this work when TORCH_VERSION includes the patch version. Currently,
# it only works for 'TORCH_VERSION=X.Y' formats.
RUN pip install --upgrade --no-cache-dir pip \
    && export TORCH_LATEST_VERSION=$(pip index versions torch | grep -Eo "${TORCH_VERSION}.[0-9]" | head -1) \
    && pip install --no-cache-dir torch==$TORCH_LATEST_VERSION+cpu \
    -f https://download.pytorch.org/whl/torch_stable.html

# TODO: Possibly also install 'torchvision' and 'torchaudio' CPU-only versions?
# Either need to add the version number as an argument, or find a clever way to 
# find the latest compatible version using 'pip'.
