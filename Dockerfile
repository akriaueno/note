FROM debian:bullseye-slim

WORKDIR /work
COPY ./note.sh /work/
RUN mkdir /note
RUN apt-get -y update \
 && apt-get -y install \
    vim \
    emacs \
    nano \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT NOTE_DIR=/note /work/note.sh
