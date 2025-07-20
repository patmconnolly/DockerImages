FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y g++ make libcurl4-openssl-dev