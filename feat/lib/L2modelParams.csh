#! /bin/csh -ef

#####################################################################################
# extract model parameters for documentation										#
# Usage: ./L2modelParams.csh <study> <phase> <model> <example gfeat>				#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./L2modelParams.csh MIG P1 MIG-2722 M1 P1M1_STC_U005_NCR P1M1FE_C05	 	#
# Ex:	 ./L2modelParams.csh RAP M1 RAP-2680 M1_STC_U005_NCR P1M1FE_C05				#
# p.clasen																			#
#####################################################################################

##Get a report of model parameters for level 1

# set arguments
set DIR = ~/Documents/$1

# exemplar subjects
if ($1 == MIG) then
	set sub = $2
	set phase = $3
	set model = $4
	set examFeat = $5
	set examFSF = $6
	set desDIR = $DIR/$sub/feat/$phase/$model/$examFeat/designFiles
	set file = $desDIR/$examFSF.fsf
endif
if ($1 == RAP) then
	set sub = $2
	set model = $3
	set examFeat = $4
	set examFSF = $5
	set desDIR = $DIR/$sub/feat/$model/$examFeat/designFiles
	set file = $desDIR/$examFSF.fsf
endif

set docFile = $DIR/doc/L2Models/$examFSF.txt


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