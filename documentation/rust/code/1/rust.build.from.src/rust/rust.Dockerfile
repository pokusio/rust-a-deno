# ARG DEBIAN_IMAGE_TAG=bullseye-20220527-slim
ARG DEBIAN_IMAGE_TAG=$DEBIAN_IMAGE_TAG
# ARG PYTHON_IMAGE_TAG=3.11.0b3-bullseye
ARG PYTHON_IMAGE_TAG=$PYTHON_IMAGE_TAG

# FROM debian:$DEBIAN_IMAGE_TAG
FROM python:$PYTHON_IMAGE_TAG as DEBIAN_RUST_BUILD


ARG RUST_VERSION=1.61.0
ENV RUST_VERSION=$RUST_VERSION

# ---
# if set to true, then all tools will be built and installed, including Cargo
ARG RUST_PLANET=true
ENV RUST_PLANET=$RUST_PLANET
# -- Now install all build dependencies :
#
# --- + -
# g++ 5.1 or later or clang++ 3.5 or later
#    About it :
#
#      https://packages.debian.org/bullseye/g++
#
#       This is the GNU C++ compiler, a fairly portable optimizing compiler for C++.
#
#       This is a dependency package providing the default GNU C++ compiler.
#
# --- + -
# g++ 5.1 or later or clang++ 3.5 or later
# python 3 or 2.7
# GNU make 3.81 or later
# cmake 3.13.4 or later
# ninja
# curl
# git
# ssl which comes in libssl-dev or openssl-devel
# pkg-config if you are compiling on Linux and targeting Linux
#
# --
# How funny, i find a repo whose source code is Rust language, not Python, and :
#    -> I find there is a Dockerfile :  https://github.com/rust-lang/triagebot/blob/31100ffef4bbaac93335bc31482a97274e6f9f81/Dockerfile#L10
#    -> That Dockerfile performs the build from source of the triage bot
#    -> and it installs the folowing debian packages into an Ubuntu :
#       -> g++
#       -> curl
#       -> ca-certificates
#       -> libc6-dev
#       -> make
#       -> libssl-dev
#       -> pkg-config
#       -> git
#       -> cmake
#       -> zlib1g-dev
#
#
#        RUN apt-get update -y && \
#            DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
#              g++ \
#              curl \
#              ca-certificates \
#              libc6-dev \
#              make \
#              libssl-dev \
#              pkg-config \
#              git \
#              cmake \
#              zlib1g-dev
#
# Yes, definitely the only missing rustc build from source dependencies that are missing in that list, are those related to installing python
# That's why i will adopt the following strategy :
#  -> I will use a base container tha has python3 already installed,
#  -> and will only perform python installation myself if having a python base image based on debian throws issues that are too complex.
#  -> 'docker pull python:3.11.0b3-bullseye' official python image is based on debian bullseye obviously, that's the one i'll use, which is debian bullseye based, and gives a Python version '3.11.x' env.
#
# Additionnally, I will not install the following packages since they are not in the BOM for the rustc build from source :
#
#       -> libc6-dev
#       -> zlib1g-dev
#         (note that those 2 packages have a direct dependency relation so it either i install both of them, or none, see https://packages.debian.org/bullseye/zlib1g-dev)
#
# This will leave us with installing only those exact debian packages :
#
#       -> g++
#       -> curl
#       -> ca-certificates
#       -> make
#       -> libssl-dev
#       -> pkg-config
#       -> git
#       -> cmake
#
# If we install all those packages, we have all the BOM including the python language, and we only missing one final package we need to install :   'ninja'
# So let's find what debian package must be installed to install 'ninja' on a debian bullseye :
#  * i actually find 2 debian bullseye packages related to ninja , so i will install them both : 'ninja-build' and 'generate-ninja'
#  * https://packages.debian.org/bullseye/generate-ninja
#  * https://packages.debian.org/bullseye/ninja-build
# Also note : Python version 2.7 or Python 3 : Python 2.7 reached end of life, there is no way we will use python 2.7 to build rustc from source
#
# ----
#
#
# ----
# More detailed infos on each linux packages to install :
#
# --- + -
# g++ 5.1 or later or clang++ 3.5 or later
#    About it :
#
#      https://packages.debian.org/bullseye/g++
#
#       This is the GNU C++ compiler, a fairly portable optimizing compiler for C++.
#
#       This is a dependency package providing the default GNU C++ compiler.
#
# --- + -
#


RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      g++ \
      curl \
      ca-certificates \
      make \
      libssl-dev \
      pkg-config \
      git \
      cmake
#
# note: I kept ca-certificates , well because it does not hurt, even if it is not explciitly into the rustc build from source B.O.M.


# ---
# Okay, now we are supposed to have everything w need to build the https://github.com/rust-lang/rust git repo in the 1.61.0 release verion

RUN mkdir -p /root/rust
RUN git clone https://github.com/rust-lang/rust.git /root/rust
COPY config.alltools.toml /root/rust
COPY config.minimal.toml /root/rust

WORKDIR /root/rust


COPY rust.build.install.sh .

# ---
# Build and install the rust language utilities (rtustc rustdoc rustc system library with primitives)
RUN chmod +x ./rust.build.install.sh && ./rust.build.install.sh






# ------------- ---- ---- ----  ------------- #
# ------------- TODO TODO TODO  ------------- #
# TODO : MultiStage Build with a release container where we install Rust (we'll see if possible, what files have to be copied to release build --COPY-FROM )
# ------------- ---- ---- ----  ------------- #

FROM alpine:latest as RELEASE

RUN apk update && apk --no-cache add ca-certificates bash curl
RUN mkdir -p /root/rust/provision && mkdir -p /root/rust/app
WORKDIR /root/rust/provision
COPY --from=DEBIAN_RUST_BUILD /root/rust /root/rust/provision/
COPY rust-pokus-install.sh .
RUN chmod +x ./rust-pokus-install.sh && ./rust-pokus-install.sh

# ----
# TODO :
#   create pokus non-root user with its UID GID env var
#   the /root/rust/app folder should be owned by the pokus user
#
USER pokus
# ----
#   user should be able to map his dev folder on bare machine to /root/rust/app Folder in container, as dev workspace
#
VOLUME /root/rust/app
WORKDIR /root/rust/app
ENTRYPOINT ["/bin/bash"]
