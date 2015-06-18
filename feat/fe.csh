#! /bin/csh -ef

#########################################################################################
# Wrapper to make, run, and document 2nd level FEAT designs								#
# Usage: ./fe.csh <study> <example sub> <phase> <model> <L2 design>						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES										#
# Ex:	 ./fe.csh MIG MIG-2722 P1 M1 FE_U05												#
# Ex:	 ./fe.csh RAP RAP-???? M1 FE_U05												#
# p.clasen																				#
#########################################################################################

# set arguments
set study = $1
set examSub = $2

if ($1 == MIG) then

	# study specific 
	set phase = $3
	set model = $4
	set examGfeat = $5

	## check (method for overwriting a design OR running same design on sub-set of subjects)
	~/imaging/feat/lib/FEcheck.csh $study $phase $model $examGfeat

	## make
	~/imaging/feat/lib/FEmakeFSF.csh $study $examSub $phase $model $examGfeat
	## document
	~/imaging/feat/lib/FEparams.csh $study $examSub $phase $model $examGfeat
	## run
	~/imaging/feat/lib/FErunFSF.csh $study $phase $model $examGfeat

else if ($1 == RAP) then

	# study specific 
	set model = $3
	set examGfeat = $4

	## check (method for overwriting a design OR running same design on sub-set of subjects)
	~/imaging/feat/lib/FEcheck.csh $study $model $examGfeat

	## make
	~/imaging/feat/lib/FEmakeFSF.csh $study $examSub $model $examGfeat 
	## document
	~/imaging/feat/lib/FEparams.csh $study $examSub $model $examGfeat
	## run
	~/imaging/feat/lib/FErunFSF.csh $study $model $examGfeat

endif





# end