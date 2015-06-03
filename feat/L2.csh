#! /bin/csh -ef

#########################################################################################
# Wrapper to make, run, and document 2nd level FEAT designs								#
# Usage: ./L2.csh <study> <example sub> <phase> <model> <L1 design> <L2 design>			#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES										#
# Ex:	 ./L1.csh MIG MIG-2722 P1 M1 P1M1_STC_U005_NCR P1M1FE_C05						#
# Ex:	 ./L1.csh RAP RAP-???? M1 M1_STC_U005_NCR M1FE_C05								#
# p.clasen																				#
#########################################################################################

# set arguments
set study = $1
set examSub = $2

if ($1 == MIG) then

	# study specific 
	set phase = $3
	set model = $4
	set examFeat = $5
	set examGfeat = $6

	## check (method for overwriting a design OR running same design on sub-set of subjects)
	~/imaging/feat/lib/checkL2.csh $study $phase $model $examFeat $examGfeat

	## make
	~/imaging/feat/lib/makeL2design.csh $study $examSub $phase $model $examFeat $examGfeat
	## document
	~/imaging/feat/lib/L2modelParams.csh $study $phase $model $examFeat $examGfeat
	## run
	~/imaging/feat/lib/runL2design.csh $study $phase $model $examFeat $examGfeat

else if ($1 == RAP) then

	# study specific 
	set model = $3
	set examGfeat = $4
	set examFeat = $5

	## check (method for overwriting a design OR running same design on sub-set of subjects)
	~/imgaing/feat/lib/checkL2.csh $study $model $examFeat $examGfeat

	## make
	~/imaging/feat/lib/makeL2design.csh $study $examSub $model $examFeat $examGfeat 
	## document
	~/imaging/feat/lib/L2modelParams.csh $study $model $examFeat $examGfeat
	## run
	~/imaging/feat/lib/runL2design.csh $study $model $examFeat $examGfeat

endif





# end