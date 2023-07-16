#!/usr/bin/bash

input_file=$1
file_name=$(basename "$input_file")
output_file_name="${file_name%.cast}.gif"
output_file="/workdir/$output_file_name"

agg --font-family "Hack Nerd Font Mono" "$input_file" "$output_file"
