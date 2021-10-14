#!/bin/bash

note_dir=$HOME/.note
docker_img=note:latest

if ! command -v docker &> /dev/null
then
  echo "docker could not be found."
  exit
fi

if [ ! -d "$note_dir" ]
then
  mkdir $note_dir
fi

bash_aliases='$HOME/.bash_aliases'
bashrc='$HOME/.bashrc'
bash_profile='$HOME/.bash_profile'
zshrc='$HOME/.zshrc'
profile='$HOME/.profile'

if [ -f /etc/timezone ]
then
  timezone_default=$(cat /etc/timezone)
  echo "Your timezone is $timezone_default."
fi

while true
do
  read -p "Enter your timezone. (e.g Asia/Tokyo): " timezone
  timezone=${timezone:-$timezone_default}
  if [ -z "$timezone" ]
  then
    continue
  fi
  if ! echo $timezone | grep -q '/'
  then
    echo "Invalid timzezone."
    continue
  fi
  break
done

while true
do
  clear
  echo "shell alias config file candidates"
  echo "[0] $bash_aliases"
  echo "[1] $bashrc"
  echo "[2] $bash_profile"
  echo "[3] $zshrc"
  echo "[4] $profile"
  echo "[5] Not in this list."
  read -p "Which is your shell alias config file? [0-5]: " alias_conf_num
  case "$alias_conf_num" in
    0) alias_conf_file=$bash_aliases ;;
    1) alias_conf_file=$bashrc ;;
    2) alias_conf_file=$bash_profile ;;
    3) alias_conf_file=$zshrc ;;
    4) alias_conf_file=$profile ;;
    5) read -p "Enter your alias config file path: " alias_conf_file ;;
    *) continue ;;
  esac
  read -p "Can I add note alias to $alias_conf_file? (y/n): " CHECK_YN
  case "$CHECK_YN" in
    [yY]) break;
  esac
done

echo "alias note=\"docker run -it --rm -e TZ=$timezone -e LANG=$LANG -v "'$HOME'"/.note:/note $docker_img\"" >> $(eval echo ${alias_conf_file})
echo -e "\nInstalled. Please reload shell and run \"note\" (e.g. exec "'$SHELL'" -l)"
