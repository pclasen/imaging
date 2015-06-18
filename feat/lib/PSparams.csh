#! /bin/csh -ef

#####################################################################################
# extract model parameters for documentation										#
# Usage: ./PSparams.csh <study> <phase> <model> 									#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./PSparams.csh MIG MIG-2722 P1 M1 								 			#
# Ex:	 ./PSparams.csh RAP RAP-2680 M1  											#
# p.clasen																			#
#####################################################################################

##Get a report of model parameters for prestats

# set arguments
set DIR = ~/Documents/$1

# exemplar subjects
if ($1 == MIG) then
	set sub = $2
	set phase = $3
	set model = $4
	set desName = $phase$model
	set desDIR = $DIR/$sub/feat/$phase/$model/prestats/designFiles
	set file = $desDIR/R1.fsf
endif
if ($1 == RAP) then
	set sub = $2
	set model = $3
	set desName = $model
	set desDIR = $DIR/$sub/feat/$model/prestats/designFiles
	set file = $desDIR/R1.fsf
endif

set docFile = $DIR/doc/PS/$desName.txt


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


## end