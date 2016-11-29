#!/bin/bash

if [[ -z "$1" ]]; then
  echo "No arguments."
  exit 
fi

gcc -o "$1" -fopenmp "$1".c
