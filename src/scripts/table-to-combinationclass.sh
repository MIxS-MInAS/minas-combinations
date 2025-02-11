#! /usr/bin/env bash

## Requires a comma-separated table with the following format:
## Checklist	ChecklistURI	Extension 1	CheckList2URI	Extension 2	Existing Combination	Full name	Example

table=$1

## TODO: FIX BUG THAT INCLUDES FIRST LINE -> ALMOST FIXED, CHECK

while read line; do

  checklist=$(echo "$line" | cut -d, -f1)
  checklist_uri=$(echo "$line" | cut -d, -f2)
  extension=$(echo "$line" | cut -d, -f3)
  extension_uri=$(echo "$line" | cut -d, -f4)
  checklist_lower=$(echo $checklist | tr '[:upper:]' '[:lower:]')
  extension_lower=$(echo $extension | tr '[:upper:]' '[:lower:]')
  #example=$(echo "$line" | cut -d, -f6)

  echo "SLOT #########################"
  echo "${checklist_lower}_${extension_lower}_ancient_data:
  description: Data that comply with Ancient combined with ${checklist}${extension}
  title: ${checklist}${extension}Ancient Data
  domain: MixsCompliantData
  slot_uri: MIXS:${checklist_lower}_${extension_lower}_ancient_data
  multivalued: true
  range: ${checklist}${extension}Ancient
  inlined: true
  inlined_as_list: true
    " >>minas-combination-slots.txt

  echo "CLASSES #########################"
  echo "${checklist}${extension}Ancient:
  description: MIxS Data that comply with the ${checklist} checklist, and ${extension} and Ancient extensions.
  title: ${checklist}${extension} combined with Ancient
  in_subset:
      - combination_classes
  is_a: Ancient
  mixins:
      - ${checklist}${extension}
  class_uri: MIXS:${checklist_uri}_${extension_uri}_9999903" >>minas-combination-classes.txt

  echo "COMPLIANT_DATA_SLOTS #########################"
  echo "- ${checklist_lower}_${extension_lower}_ancient_data" >>minas-combination-compliantdataslots.txt

done <<<"$(tail +2 $table)"
