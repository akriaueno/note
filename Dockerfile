FROM debian:bullseye-slim

WORKDIR /work
COPY ./note.sh /work/
RUN mkdir /note
RUN apt-get -y update \
 && apt-get -y install \
    emacs \
    locales \
    nano \
    vim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8

ENV NOTE_DIR /note

ENTRYPOINT /work/note.sh
