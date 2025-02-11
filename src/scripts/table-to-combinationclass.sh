#! /usr/bin/env bash

## Requires a tab-separated table with the following format:
## Checklist	Extension 1	Extension 2	Existing Combination	Full name	Example

table=$1

while read line; do
    checklist=$(echo "$line" | cut -d, -f1)
    extension=$(echo "$line" | cut -d, -f2)
    checklist_lower=$(echo $checklist | tr '[:upper:]' '[:lower:]')
    extension_lower=$(echo $extension | tr '[:upper:]' '[:lower:]')
    #example=$(echo "$line" | cut -d, -f6)

    echo "SLOT #########################"
    echo "${checklist_lower}_${extension_lower}_ancient_data
  description: Data that comply with Ancient combined with ${checklist}${extension}
  title: ${checklist}${extension}Ancient Data
  domain: MixsCompliantData
  slot_uri: MIXS:${checklist_lower}_${extension_lower}_ancient_data
  multivalued: true
  range: ${checklist}${extension}Ancient
  inlined: true
  inlined_as_list: true
    "
done <$table
