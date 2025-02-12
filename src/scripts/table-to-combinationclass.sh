#! /usr/bin/env bash

## Author: James Fellows Yates (@jfy133)
## License: CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
## Description: This script generates the MIxS compatible slots, classes, and compliant data slots *combination classes* that can be added to MIxS schemas.

## INPUT: Requires a comma-separated table with the following format:
## Checklist	ChecklistURI	Extension 1	CheckList2URI	Extension 2	Existing Combination	Full name	Example

## OUTPUT: Three files:
## 1. minas-combination-slots.txt: Contains the slots for the combination classes
## 2. minas-combination-classes.txt: Contains the combination classes
## 3. minas-combination-compliantdataslots.txt: Contains the slots that will be added to the MixsCompliantData class

table=$1

while read line; do

  checklist=$(echo "$line" | cut -d, -f1)
  checklist_uri=$(echo "$line" | cut -d, -f2)
  extension=$(echo "$line" | cut -d, -f3)
  extension_uri=$(echo "$line" | cut -d, -f4)
  checklist_lower=$(echo $checklist | tr '[:upper:]' '[:lower:]')
  extension_lower=$(echo $extension | tr '[:upper:]' '[:lower:]')

  echo "SLOT #########################"
  echo "${checklist_lower}_${extension_lower}_ancient_data:
  description: Data that comply with Ancient combined with ${checklist}${extension}
  title: ${checklist}${extension}Ancient Data
  domain: MixsCompliantData
  slot_uri: MIXS:${checklist_lower}_${extension_lower}_ancient_data
  multivalued: true
  range: ${checklist}${extension}Ancient
  inlined: true
  inlined_as_list: true" >>minas-combination-slots.txt

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
