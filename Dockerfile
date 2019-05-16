From ubuntu:18.04
MAINTAINER TCass <heytcass@gmail.com>

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    unzip \
    git \
    curl
RUN cd /tmp && \
  git clone --depth 1 https://github.com/tensorflow/models.git tensorflow-models && \
  curl -OL https://github.com/google/protobuf/releases/download/v3.7.1/protoc-3.7.1-linux-x86_64.zip && \
  unzip -a protoc-3.7.1-linux-x86_64.zip -d protobuf && \
  mv protobuf/bin /tmp/tensorflow-models/research && \
  cd /tmp/tensorflow-models/research/ && \
  ./bin/protoc object_detection/protos/*.proto --python_out=. && \
  mkdir -p /build/tensorflow/object_detection && \
  touch /build/tensorflow/object_detection/__init__.py && \
  mv object_detection/data /build/tensorflow/object_detection && \
  mv object_detection/utils /build/tensorflow/object_detection && \
  mv object_detection/protos /build/tensorflow/object_detection && \
  rm -rf /tmp/*