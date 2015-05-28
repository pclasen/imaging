#! /bin/csh -ef

#####################################################################################
# Wrapper to make, run, and document 1st level FEAT designs							#
# Usage: ./L1.csh <study> <example sub> <phase> <model> <example feat> 				#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./L1.csh MIG MIG-2722 P1 M1 P1M1R1_un005 									#
# Ex:	 ./L1.csh RAP RAP-???? M1 M1R1_un005 										#
# p.clasen																			#
#####################################################################################

# set arguments
set study = $1
set examSub = $2

if ($1 == MIG) then

	# study specific 
	set phase = $3
	set model = $4
	set examFeat = $5

	## make
	~/imaging/feat/lib/makeL1design.csh $study $examSub $phase $model $examFeat
	## document
	~/imaging/feat/lib/L1modelParams.csh $study $phase $model $examFeat
	## run
	~/imaging/feat/lib/runL1design.csh $study $phase $model $examFeat

else if ($1 == RAP) then

	# study specific 
	set model = $3
	set examFeat = $4

	## make
	~/imaging/feat/lib/makeL1design.csh $study $examSub $model $examFeat
	## document
	~/imaging/feat/lib/L1modelParams.csh $study $model $examFeat
	## run
	~/imaging/feat/lib/runL1design.csh $study $model $examFeat

endif





# end