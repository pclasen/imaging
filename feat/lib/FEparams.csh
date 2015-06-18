#! /bin/csh -ef

#####################################################################################
# extract model parameters for documentation										#
# Usage: ./FEparams.csh <study> <phase> <model> <example gfeat>						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./FEparams.csh MIG P1 MIG-2722 FE_U05		 								#
# Ex:	 ./FEparams.csh RAP M1 RAP-2680 FE_U05										#
# p.clasen																			#
#####################################################################################

##Get a report of model parameters for level 2

# set arguments
set DIR = ~/Documents/$1

# exemplar subjects
if ($1 == MIG) then
	set sub = $2
	set phase = $3
	set model = $4
	set examGfeat = $5
	set desDIR = $DIR/$sub/feat/$phase/$model/glm/designFiles
	set file = $desDIR/$examGfeat.fsf
endif
if ($1 == RAP) then
	set sub = $2
	set model = $3
	set examGfeat = $4
	set desDIR = $DIR/$sub/feat/$model/glm/designFiles
	set file = $desDIR/$examGfeat.fsf
endif

set docFile = $DIR/doc/FEs/$phase$model$examGfeat.txt


#	#	#	Report parameters	#	#	#

##feat version
set version = `grep 'set fmri(version)' $file | sed 's/set fmri(version) //g'` 
echo "FEAT Version: $version" > $docFile

##higher level modeling
set hlm = `grep 'set fmri(mixed_yn)' $file | sed 's/set fmri(mixed_yn) //g'`
if ($hlm == 3) then
	set mL2 = 'Fixed Effects'
else 
	set mL2 = 'Other (see design file)'
endif
echo "Higher-level modelling: $mL2" >> $docFile

##Statistical thresholding 

set thresh = `grep 'set fmri(thresh)' $file | sed 's/set fmri(thresh) //g'`
if ($thresh == 1) then
	set threshold = Uncorrected
else if ($thresh == 2) then
	set threshold = Voxel
else if ($thresh == 3) then
	set threshold = Cluster
else
	set threshold = None
endif
echo "Statistical thresholding: $threshold" >> $docFile 

set pthresh = `grep 'set fmri(prob_thresh)' $file | sed 's/set fmri(prob_thresh) //g'`
echo "Probability threshold: $pthresh" >> $docFile

if ($thresh == 3) then
	set zthresh = `grep 'set fmri(z_thresh)' $file | sed 's/set fmri(z_thresh) //g'`
	echo "Z threshold: $zthresh" >> $docFile
endif


## end