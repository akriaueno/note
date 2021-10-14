#!/bin/bash

editor=${EDITOR:-vim}
today=$(date "+%Y%m%d")
note_dir=${NOTE_DIR:-"$HOME/.note"}

if [ ! -d $note_dir ]
then
  mkdir $note_dir
fi

$editor $note_dir/$today.md
