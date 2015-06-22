#! /bin/csh -ef

#####################################################################################
# Wrapper to make, run, and document 1st level FEAT designs							#
# Usage: ./glm.csh <study> <example sub> <phase> <model> <example feat> 			#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./glm.csh MIG MIG-2722 P1 M1 R1_U05 										#
# Ex:	 ./glm.csh RAP RAP-???? M1 R1_U05	 										#
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

	## check (method for overwriting a design OR running same design on sub-set of subjects)
	~/imaging/feat/lib/GLMcheck.csh $study $phase $model $examFeat

	## make
	~/imaging/feat/lib/GLMmakeFSF.csh $study $examSub $phase $model $examFeat
	## document
	~/imaging/feat/lib/GLMparams.csh $study $examSub $phase $model $examFeat
	
	## port over pre-stats data
	~/imaging/feat/lib/GLMcpPrestats.csh $study $phase $model $examFeat

	## run
	~/imaging/feat/lib/GLMrunFSF.csh $study $phase $model 

else if ($1 == RAP) then

	# study specific 
	set model = $3
	set examFeat = $4
	
	## check (method for overwriting a design OR running same design on sub-set of subjects)
	~/imaging/feat/lib/GLMcheck.csh $study $model $examFeat

	## make
	~/imaging/feat/lib/GLMmakeFSF.csh $study $examSub $model $examFeat
	## document
	~/imaging/feat/lib/GLMparams.csh $study $examSub $model $examFeat

	## port over pre-stats data
	~/imaging/feat/lib/GLMcpPrestats.csh $study $model $examFeat

	## run
	~/imaging/feat/lib/GLMrunFSF.csh $study $model

endif





# end