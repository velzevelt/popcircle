#!/bin/bash

STANDART_MESSAGE="upd"

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi



if [ -n "$1" ]; then
    git add .
    git commit -m "$1"
    git push

else
    echo "Не было задано сообщение коммита"
    echo "Использовано стандартное сообщение $STANDART_MESSAGE"
    git add .
    git commit -m $STANDART_MESSAGE
    git push
fi
