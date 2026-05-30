ARG EL_VERSION=10
FROM almalinux:${EL_VERSION}
RUN dnf install -y gcc-c++ make libcurl-devel