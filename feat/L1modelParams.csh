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
set version = `grep 'set frmi(version)' $file | sed 's/set fmri(version) //g'` 
echo "FEAT Version: $version" >> $docFile

##brain extraction
set bet = `grep 'set fmri(bet_yn)' $file | sed 's/set fmri(bet_yn) //g'`
if ($bet == 0) then
	set brain = False
else if ($bet == 1) then
	set brain = True
endif
echo "Brain extraction (BET): $brain" >> $docFile

##slice time correction
set stc = `grep 'set fmri(st)' $file | sed 's/set fmri(st) //g'`
if ($stc == 0) then
	set slice = None
else if ($stc == 5) then
	set slice = Interleaved
else
	set slice = Other (see .fsf)
endif
echo "Slice timing correction: $slice" >> $docFile

##motion correction & motion parameters in model
set mc `grep 'set fmri(mc)' $file | sed 's/set fmri(mc) //g'`
if ($mc == 0) then
	set motion = False
	echo "Motion correction (McFlirt): $motion" >> $docFile
else if ($mc == 1)
	set motion = True
	set mp = `grep 'set fmri(motionevs)' $file | sed 's/set fmri(motionevs) //g'`
	if ($mp == 0) then
		set mevs = False
	else if ($mp == 1) then
		set mevs = True
	endif
	echo "Motion correction (McFlirt): $motion" >> $docFile
	echo "Motion parameters(6) added as EVs: $mevs" >> $docFile
endif

##spatial smoting FWHM (mm)
set kernel = `grep 'set fmri(smooth)' $file | sed 's/set fmri(smooth) //g'`
echo "Spatial smoothing kernel (FWHM): $kernel (mm)" >> $docFile

##intensity normalization
set intnorm = `grep 'set fmri(norm_yn)' $file | sed 's/set fmri(norm_yn) //g'`
if ($intnorm == 0) then
	set norm == False
else if ($intnorm == 1) then
	set norm == True
endif
echo "Intensity normalization: $norm" >> $docFile

##filtering (high pass/low pass)
# high
set hp = `grep 'set fmri(temphp_yn)' $file | sed 's/set fmri(temphp_yn) //g'`
if ($hp == 0) then
	set high == False
	echo "High pass filtering: $high" >> $docFile
else if ($hp == 1) then
	set high == True
	set hpco = `grep 'set fmri(paradigm_hp)' $file | sed 's/set fmri(paradigm_hp) //g'`
	echo "High pass filtering: $high" >> $docFile
	echo "High pass filter cutoff: $hpco (s)" >> $docFile
endif
# low
set lp = `grep 'set fmri(templp_yn)' $file | sed 's/set fmri(templp_yn) //g'`
if ($lp == 0) then
	set low == False
else if ($hp == 1) then
	set low == True
endif
echo "Low pass filtering: $high" >> $docFile

##prewhitening
set pw = `grep 'set fmri(prewhiten_yn)' $file | sed 's/set fmri(prewhiten_yn) //g'`
if ($pw == 0) then
	set prewhite == False
else if ($pw == 1) then
	set prewhite == True
endif
echo "Prewhitening applied: $prewhite" >> $docFile

##registration
set coreg = `grep 'set frmi(reginitial_hires_yn)' | sed 's/set fmri(reginitial_hires_yn) //g'`
if ($coreg == 0) then
	set coregistration = False
	echo "Images coregistered to T2: $coreg" >> $docFile
else if ($coreg == 1) then
	set coregistration = True
	set coregSS = `grep 'set fmri(reginitial_hires_search)' | sed 's/set fmri(reginitial_hires_search) //g'`
	if ($coregSS == 0) then
		set coSS = No search
	else if ($coregSS == 90) then
		set coSS = Normal search
	else if ($coregSS == 180) then
		set coSS = Full search
	endif
	set coregDF = `grep 'set fmri(reginitial_hires_dof)' | sed 's/set fmri(reginitial_hires_dof) //g'`
	echo "Images coregistered to T2: $coreg" >> $docFile
	echo "Coregistration search space parameter: $coSS" >> $docFile
	echo "Coregistration DOF: $coregDF" >> $docFile
endif

set nativeSS = `grep 'set fmrit(reghires_search)' | sed 's/set fmri(reghires_search) //g'
if ($nativeSS == 0) then
	set naSS = No search
else if ($nativeSS == 90) then
	set naSS = Normal search
else if ($nativeSS == 180) then
	set naSS = Full search
endif


##number of EVs
set evs = `grep 'set fmri(evs_orig)' $file | sed 's/set fmri(evs_orig) //g'`
echo "Number of EVs (non-motion): $evs" >> $docFile
# applied temporal filtering to EVS
set tmpf = `grep 'set fmri(tempfilt_yn3' $file | sed 's/set fmri(tempfilt_yn3) //g'`
if ($tmpf == 0) then
	set tempF = False
else if ($tmpf == 1)
	set tempF = True
endif
echo "Temporal filtering applied to EVs: $tempF" >> $docFile
# applied temporal derivative to EVS
set tmpd = `grep 'set fmri(deriv_yn3)' $file | sed 's/set fmri(deriv_yn3) //g'`
if ($tmpd == 0) then
	set tempD = False
else if ($tmpd == 1)
	set tempD = True
endif
echo "Temporal derivative applied to EVs: $tempD" >> $docFile

# Convolution
set convolve = `grep 'set fmri(convolve1)' $file | sed 's/set fmri(convolve3) //g'`
if ($convolve == 3) then
	set conv = Double gamma
else
	set conv = Other
endif
echo "Convolution function: $conv" >> $docFile

## number of contrasts
set contrasts = `grep 'set fmri(ncon_orig)' | sed 's/set fmri(ncon_orig) //g'`
echo "Number of contrasts: $contrasts" >> $docFile

##statistical thresholding 
set thresh = `grep 'set fmri(thresh)' | sed 's/set fmri(thresh) //g'`
if ($thresh == 1) then
	set threhold = Uncorrected
else if ($threshold == 2) then
	set threshold = Voxel
else if ($threshold == 3) then
	set threshold = Cluster
else
	set threshold = None
endif
echo "Statistical thresholding: $threshold" >> $docFile 

set pthresh = `grep 'set fmri(prob_thresh)' | sed 's/set fmri(prob_thresh) //g'`
echo "Probability threshold: $pthresh"

if ($thresh == 3) then
	set zthresh = `grep 'set fmri(z_thresh)' | sed 's/set fmri(z_thresh) //g'`
	echo "Z threshold: $zthresh" >> $docFile
endif



## end