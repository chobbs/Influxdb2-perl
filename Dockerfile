FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y install gcc && \
    apt-get clean
