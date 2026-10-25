#!/usr/bin/env bash

set -euo pipefail

read -r -p "Principal amount: " principal
read -r -p "Annual interest rate (%): " rate
read -r -p "Time period (years): " time

# Accept non-negative decimal numbers, including values such as .5.
number_re='^[0-9]+([.][0-9]+)?$|^[.][0-9]+$'
for field in principal rate time; do
  value="${!field}"
  if [[ ! "$value" =~ $number_re ]]; then
    printf 'Error: %s must be a non-negative number.\n' "$field" >&2
    exit 1
  fi
done

interest=$(awk -v p="$principal" -v r="$rate" -v t="$time" 'BEGIN { printf "%.2f", (p * r * t) / 100 }')
total=$(awk -v p="$principal" -v i="$interest" 'BEGIN { printf "%.2f", p + i }')
printf 'Simple interest: %s\n' "$interest"
printf 'Total amount: %s\n' "$total"
