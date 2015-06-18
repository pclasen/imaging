#! /bin/csh -ef

#####################################################################################
# extract model parameters for documentation										#
# Usage: ./GLMparams.csh <study> <phase> <model> <example feat>						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./GLMparams.csh MIG MIG-2722 P1 M1 R1_U05						 			#
# Ex:	 ./GLMparams.csh RAP RAP-2680 M1 R1_U05 									#
# p.clasen																			#
#####################################################################################

##Get a report of model parameters for GLM

# set arguments
set DIR = ~/Documents/$1

# exemplar subjects
if ($1 == MIG) then
	set sub = $2
	set phase = $3
	set model = $4
	set examFeat = $5
	set desStub = `echo $examFeat | sed -e 's/R1//'`
	set desName = $phase$model$desStub
	set desDIR = $DIR/$sub/feat/$phase/$model/glm/designFiles
	set file = $desDIR/$examFeat.fsf
endif
if ($1 == RAP) then
	set sub = $2
	set model = $3
	set examFeat = $4
	set desStub = `echo $examFeat | sed -e 's/R1//'`
	set desName = $model$desStub
	set desDIR = $DIR/$sub/feat/$model/glm/designFiles
	set file = $desDIR/$examFeat.fsf
endif

set docFile = $DIR/doc/GLMs/$desName.txt


#	#	#	Report parameters	#	#	#

##feat version
set version = `grep 'set fmri(version)' $file | sed 's/set fmri(version) //g'` 
echo "FEAT Version: $version" > $docFile

##number of EVs
set evs = `grep 'set fmri(evs_orig)' $file | sed 's/set fmri(evs_orig) //g'`
echo "Number of EVs (non-motion): $evs" >> $docFile

# applied temporal filtering to EVS
set tmpf = `grep 'set fmri(tempfilt_yn1)' $file | sed 's/set fmri(tempfilt_yn1) //g'`
if ($tmpf == 0) then
	set tempF = False
else if ($tmpf == 1) then
	set tempF = True
endif
echo "Temporal filtering applied to EVs: $tempF" >> $docFile

# applied temporal derivative to EVS
set tmpd = `grep 'set fmri(deriv_yn1)' $file | sed 's/set fmri(deriv_yn1) //g'`
if ($tmpd == 0) then
	set tempD = False
else if ($tmpd == 1) then
	set tempD = True
endif
echo "Temporal derivative applied to EVs: $tempD" >> $docFile


##Convolution
set convolve = `grep 'set fmri(convolve1)' $file | sed 's/set fmri(convolve1) //g'`
if ($convolve == 3) then
	set conv = 'Double gamma'
else
	set conv = Other
endif
echo "Convolution function: $conv" >> $docFile

##Number of contrasts
set contrasts = `grep 'set fmri(ncon_orig)' $file | sed 's/set fmri(ncon_orig) //g'`
echo "Number of contrasts: $contrasts" >> $docFile

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