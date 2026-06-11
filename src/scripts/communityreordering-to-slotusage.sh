#! /usr/bin/env bash

## Author: James Fellows Yates (@jfy133)
## License: CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
## Description: This script generates the MIxS/LinkML slot-usage lists for combination classes.

## INPUT: Requires a **comma-separated** table with at a minimum the following columns (all others are ignored):
## Source	SUBSET	ORDER	slot_group	slot_group_order	slot_usage	name

## OUTPUT: One files:
## 1. <input_file_name>-slotusage.yaml

table=$1

echo "    slots:" >temp.slots
echo "    slot_usage:" >temp.slotusage

while read line; do

  slot_name=$(echo "$line" | cut -d, -f7)
  slot_rank=$(echo "$line" | cut -d, -f6)
  slot_group=$(echo "$line" | cut -d, -f4)

  echo "## PROCESSING $slot_name"

  ## Slots list
  echo "      - ${slot_name}" >>temp.slots

  ## Slots list
  {
    echo "      ${slot_name}:"
    echo "        rank: ${slot_rank}"
    echo "        slot_group: ${slot_group}"
  } >>temp.slotusage
done <<<"$(tail +2 $table)"

cat temp.slots temp.slotusage >"${table%.csv}-slotscombined.yaml"

rm temp*
