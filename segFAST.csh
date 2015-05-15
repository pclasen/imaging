#! /bin/csh -ef

#########################################
# run FAST segmentation on SPGR		#
#					#
# Usage: ./segFAST.csh <sub>		#
#########################################

set DIR = $STUDY_DIR # set this in environment (e.g., ~/Documents/MIG)
set sub = $1
set ana = $DIR/$sub/ana

echo FAST $sub START: `date` >> $ana/segFAST_log.txt
fast -t 1 -n 3 -H 0.1 -I 4 -l 20.0 -o $ana/brainmask $ana/brainmask
echo FAST $sub END: `date` >> $ana/segFAST_log.txt 

