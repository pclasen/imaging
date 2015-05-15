#! /bin/csh -ef

#########################################
# organize behavioral data              #
#										                    #
# Usage: ./beORG.csh <sub>              #
#########################################


set DIR = $STUDY_DIR # set this in environment (e.g., ~/Documents/MIG)
set sub = $1

set be = $DIR/$sub/be

mkdir $be/raw
mv $be/*.mat $be/raw
mv $be/*.txt $be/raw 

mkdir $be/clean
mkdir $be/clean/P1
mkdir $be/clean/P2

mkdir $be/onsets
mkdir $be/onsets/P1
mkdir $be/onsets/P2


## END
