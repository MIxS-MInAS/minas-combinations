# minas-combinations

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.16495005.svg)](https://doi.org/10.5281/zenodo.16495005)

Schemas of the most common ancient DNA + sample type MIxS combination.

This repository holds _partial_ LinkML schemas of the relevant classes and slots for defining ancient DNA specific _combinations_.

The purpose of these partial schemas is they can be 'merged' into draft full schemas to extend it, using e.g. `yq` or `linkml-toolkit`.
As such they will not work 'standalone', as they reference other components of the full schemas.

See the [minas](https://github.com/MIxS-MInAS/minas) repository for such extended draft 'full' MIxS schemas including the combinations and new MInAS proposed extensions.

## Instructions for major overhauls of combinations

### Generate new combinations with orders

This happens via community work on Google Drive.
Typically this involves getting a MIxS v5 style table, adding new columns, then assigning new slot_groups/slot_usage etc.

Example document: https://docs.google.com/spreadsheets/d/14vXu2dN0tHJivnlgCNAlJfV0VIhw_ajhKI-N40UjkkU/edit?usp=sharing

### Generate combination metadata

1. Create a `combinations.csv` for an overhauled set of combinations under `assets/combination-tsvs/v<upcoming_version>`
2. Within this directory, run `bash ../../../src/scripts/table-to-combinationclass.sh combinations-<DATE>.csv`

### Generate slot specific usage

1. Download in CSV format the community re-ordered slot files from Google Sheets to the `assets/combinations-tsv/v<upcoming_version>/slots/`
2. Rename all files:

   ```bash
   rename 's/ /_/g' *
   ```

3. Within the directory, run:

   ```bash
   for file in *.csv; do
       bash ../../../../src/scripts/communityreordering-to-slotusage.sh $file
   done
   ```

### Combine the different files

1. To get the basic template of the final combinations file from the root of the repository

   ```bash
   minas_comb_ver="0.3"
   cat assets/combination-tsvs/v"$minas_comb_ver"/minas-combination-slots.txt assets/combination-tsvs/v"$minas_comb_ver"/minas-combination-classes.txt assets/combination-tsvs/v"$minas_comb_ver"/minas-combination-compliantdataslots.txt > src/mixs/schema/minas-combinations_new.yaml
   ```

2. (CURRENTLY) Manually add the contents of each newly generated `assets/combination-tsvs/v<upcoming_version>/slots/*yaml` file to the end of each corresponding class (i.e. the new `slots` and `slots_usage` should go immediately after each `class_uri`)
3. Verify the YAML file looks valid
4. Delete the old file and rename the new one:

   ```bash
   mv src/mixs/schema/minas-combinations_new.yaml src/mixs/schema/minas-combinations.yml
   ```
