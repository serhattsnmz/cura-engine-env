FROM ubuntu:16.04

# Install Packages

RUN apt update \
    && apt install -y apt-utils libtool dh-autoreconf \
    && apt install -y cmake python3-dev python3-sip-dev git

# Add Directories

ADD protobuf-3.6.1/ /cura/protobuf
ADD libArcus-3.6.0/ /cura/libArcus
ADD CuraEngine-3.6.0/ /cura/curaEngine
ADD printer-settings/ /printer-settings

# Install Protobuf

WORKDIR /cura/protobuf
RUN chmod +x ./autogen.sh && ./autogen.sh
RUN chmod +x ./configure && ./configure
RUN make
RUN make install
RUN ldconfig

# Install libArcus

RUN mkdir /cura/libArcus/build
WORKDIR /cura/libArcus/build
RUN cmake ..
RUN make
RUN make install

# Install CuraEngine

RUN mkdir /cura/curaEngine/build
WORKDIR /cura/curaEngine/build
RUN cmake ..
RUN make
RUN make install