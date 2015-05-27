#! /bin/csh -ef

#####################################################################################
# extract model parameters for documentation										#
# Usage: ./L1modelParams.csh <study> <phase> <model> <design>						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./L1modelParams.csh MIG P1 M1 P2M1R1_un005				 					#
# Ex:	 ./L1modelParams.csh RAP M1 M1_un005 										#
# p.clasen																			#
#####################################################################################

# Get a report of model parameters for level 1

# set arguments
set DIR = ~/Documents/$1
set docFile = $DIR/doc/L1Models/$4.txt

# exemplar subjects
if ($1 == MIG) then
	set sub = MIG-2722
	set phase = $2
	set model = $3
	set examFSF = $4
	set desName = `echo $examFSF | sed -e 's/R1//'`
	set desDIR = $DIR/$sub/feat/$phase/$model/$desName/designFiles
	set file = $desDIR/$examFSF.fsf
endif
if ($1 == RAP) then
	set sub == RAP-2680
	set model = $2
	set design = $3
endif

##### REPORT PARAMETERS

##feat version
set version = grep 'set frmi(version)' $file | sed 's/set fmri(version) //g'` 
echo "FEAT Version: $version" >> $docFile

##brain extraction
set bet = `grep 'set fmri(bet_yn)' $file | sed 's/set fmri(bet_yn) //g'`
if ($bet == 1) then
	brain = True
else if ($bet == 0) then
	brain = False
endif
echo "Brain extraction (BET): $brain" >> $docFile

##slice time correction



##motion correction & motion parameters in model

##spatial smoting FWHM (mm)

##intensity normalization

##filtering (high pass/low pass)

##prewhitening

##registration

##statistical thresholding 

## end