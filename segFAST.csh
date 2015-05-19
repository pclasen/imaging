#! /bin/csh -ef

#########################################
# run FAST segmentation on SPGR			#
# Usage: 	./segFAST.csh <study> <sub>	#
# Ex:		./segFAST.csh MIG MIG-2722	#
# p.clasen								#
#########################################

set DIR = ~/Documents/$1
set sub = $2
set ana = $DIR/$sub/ana

echo FAST $sub START: `date` >> $ana/segFAST_log.txt
fast -t 1 -n 3 -H 0.1 -I 4 -l 20.0 -o $ana/brainmask $ana/brainmask
echo FAST $sub END: `date` >> $ana/segFAST_log.txt 

# end