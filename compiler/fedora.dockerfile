FROM fedora:latest
RUN dnf install -y fedora-packager rpm-build rpmdevtools rpmlint fedpkg git