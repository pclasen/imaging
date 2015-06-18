#! /bin/csh -ef

#####################################################################################
# Wrapper to make, run, and document 1st level FEAT designs							#
# Usage: ./prestats.csh <study> <example sub> <phase> <model>  						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./prestats.csh MIG MIG-2722 P1 M1 											#
# Ex:	 ./prestats.csh RAP RAP-???? M1 			 								#
# p.clasen																			#
#####################################################################################

# set arguments
set study = $1
set examSub = $2

if ($1 == MIG) then

	# study specific 
	set phase = $3
	set model = $4

	## check (method for overwriting a design OR running same design on sub-set of subjects)
	~/imaging/feat/lib/PScheck.csh $study $phase $model 

	## make
	~/imaging/feat/lib/PSmakeFSF.csh $study $examSub $phase $model 
	## document
	~/imaging/feat/lib/PSparams.csh $study $examSub $phase $model 
	## run
	~/imaging/feat/lib/PSrunFSF.csh $study $phase $model 

else if ($1 == RAP) then

	# study specific 
	set model = $3
	
	## check (method for overwriting a design OR running same design on sub-set of subjects)
	~/imaging/feat/lib/PScheck.csh $study $model 

	## make
	~/imaging/feat/lib/PSmakeFSF.csh $study $examSub $model 
	## document
	~/imaging/feat/lib/PSarams.csh $study $examSub $model 
	## run
	~/imaging/feat/lib/PSrunFSF.csh $study $model 

endif





# end