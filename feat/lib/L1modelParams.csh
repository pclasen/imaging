#! /bin/csh -ef

#####################################################################################
# extract model parameters for documentation										#
# Usage: ./L1modelParams.csh <study> <phase> <model> <example feat>					#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./L1modelParams.csh MIG P1 M1 P2M1R1_un005				 					#
# Ex:	 ./L1modelParams.csh RAP M1 M1_un005 										#
# p.clasen																			#
#####################################################################################

##Get a report of model parameters for level 1

# set arguments
set DIR = ~/Documents/$1
set desName = `echo $4 | sed -e 's/R1//'`
set docFile = $DIR/doc/L1Models/$desName.txt

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
	set examFSF = $3
	set desName = `echo $examFSF | sed -e 's/R1//'`
	set desDIR = $DIR/$sub/feat/$phase/$model/$desName/designFiles
	set file = $desDIR/$examFSF.fsf
endif

# check before overwriting
if (-f $docFile) then

	set ans = ""
	while ($ans != "y" || $ans != "n")

		echo "WARNING: Documentation file exists for $desName"
		echo "WARNING: Do you want to overwrite? (y/n)"
		set ans = $<

		if ($ans == "y") then
			# clear docFile
			echo "" > $docFile
			break
		else if ($ans == "n") then
			exit
		endif
	end

else
endif

#	#	#	Report parameters	#	#	#

##feat version
set version = `grep 'set fmri(version)' $file | sed 's/set fmri(version) //g'` 
echo "FEAT Version: $version" > $docFile

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
	set slice = 'Other (see .fsf)'
endif
echo "Slice timing correction: $slice" >> $docFile

##motion correction & motion parameters in model
set mc = `grep 'set fmri(mc)' $file | sed 's/set fmri(mc) //g'`
if ($mc == 0) then
	set motion = False
	echo "Motion correction (McFlirt): $motion" >> $docFile
else if ($mc == 1) then
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
	set norm = False
else if ($intnorm == 1) then
	set norm = True
endif
echo "Intensity normalization: $norm" >> $docFile

##filtering (high pass/low pass)

# high pass
set hp = `grep 'set fmri(temphp_yn)' $file | sed 's/set fmri(temphp_yn) //g'`
if ($hp == 0) then
	set high = False
	echo "High pass filtering: $high" >> $docFile
else if ($hp == 1) then
	set high = True
	set hpco = `grep 'set fmri(paradigm_hp)' $file | sed 's/set fmri(paradigm_hp) //g'`
	echo "High pass filtering: $high" >> $docFile
	echo "High pass filter cutoff: $hpco (s)" >> $docFile
endif

# low pass
set lp = `grep 'set fmri(templp_yn)' $file | sed 's/set fmri(templp_yn) //g'`
if ($lp == 0) then
	set low = False
else if ($lp == 1) then
	set low = True
endif
echo "Low pass filtering: $low" >> $docFile


##prewhitening
set pw = `grep 'set fmri(prewhiten_yn)' $file | sed 's/set fmri(prewhiten_yn) //g'`
if ($pw == 0) then
	set prewhite = False
else if ($pw == 1) then
	set prewhite = True
endif
echo "Prewhitening applied: $prewhite" >> $docFile

##registration

# coregistration
set coreg = `grep 'set fmri(reginitial_highres_yn)' $file | sed 's/set fmri(reginitial_highres_yn) //g'`
if ($coreg == 0) then
	set coregistration = False
	echo "Bold images coregistered to T2: $coregistration" >> $docFile
else if ($coreg == 1) then
	set coregistration = True
	set coregSS = `grep 'set fmri(reginitial_highres_search)' $file | sed 's/set fmri(reginitial_highres_search) //g'`
	if ($coregSS == 0) then
		set coSS = 'No search'
	else if ($coregSS == 90) then
		set coSS = 'Normal search'
	else if ($coregSS == 180) then
		set coSS = 'Full search'
	endif
	set coregDF = `grep 'set fmri(reginitial_highres_dof)' $file | sed 's/set fmri(reginitial_highres_dof) //g'`
	echo "Images coregistered to T2: $coregistration" >> $docFile
	echo "Coregistration search space: $coSS" >> $docFile
	echo "Coregistration DOF: $coregDF" >> $docFile
endif

# native space registration
set nativeSS = `grep 'set fmri(reghighres_search)' $file | sed 's/set fmri(reghighres_search) //g'`
if ($nativeSS == 0) then
	set naSS = 'No search'
else if ($nativeSS == 90) then
	set naSS = 'Normal search'
else if ($nativeSS == 180) then
	set naSS = 'Full search'
endif
echo "Registration to native space search space: $naSS" >> $docFile
set nativeDF = `grep 'set fmri(reghighres_dof)' $file | sed 's/set fmri(reghighres_dof) //g'`
echo "Registration to native space DOF: $nativeDF" >> $docFile

# standard space registration
set standSS = `grep 'set fmri(regstandard_search)' $file | sed 's/set fmri(regstandard_search) //g'`
if ($standSS == 0) then
	set stSS = 'No search'
else if ($standSS == 90) then
	set stSS = 'Normal search'
else if ($standSS == 180) then
	set stSS = 'Full search'
endif
echo "Registration to standard space search space: $stSS" >> $docFile
set standDF = `grep 'set fmri(regstandard_dof)' $file | sed 's/set fmri(regstandard_dof) //g'`
echo "Registration to standard space DOF: $standDF" >> $docFile


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