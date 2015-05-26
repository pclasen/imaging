#! /bin/csh -ef

#################################################################################
# subroutine for level1Design.csh												#
# Usage: ./MIGP1L1.csh <dir> <sub> <model> <run> <desName> <examSub> <examFeat>	#
# p.clasen																		#
#################################################################################

# set arguments locally 
set dir = $1
set sub = $2
set mod = $3
set run = $4
set desName = $5
set examSub = $6
set examFeat = $7

# subject level directories
set fun = $dir/$sub/fun
set feat = $dir/$sub/feat
set design = $feat/designFiles/$desName

# generate name for new copy of example design
set  desRun = echo $examFeat.fsf | sed -e 's/^R1/$run/'

#sets your feat dir:
set feat_dir = $feat/P1/$mod/$desName/$desRun.feat 								#../../P1/M1/P1M1_un005/P1M1R1_un005.feat

#sets your fmri dir:
set fmri_dir = $fun

#sets your output file:
set ofile = $design/$desRun.fsf 												#../../designFiles/P1M1_un005/P1M1R1_un005.fsf

#set temp file:
set tempfile = $design/design-temp.txt											#../../designFiles/P1M1_un005/design-temp.txt

#sets your 4D feat data:
set FourD = $fmri_dir/P1$run\_trim.nii.gz										

#sets your anatomical
set anat = $dir/$sub/ana/FST1/mri/brainmask.nii.gz

#sets your behavioral onsets directory	
set onDir = $dir/$sub/be/onsets													#../../be/onsets

#finds your total volumes
set volumes = (`fslinfo $FourD | grep "dim4 "| awk '{print  $2}'`)
set npts = $volumes[1]

##Make Design File
cp $dir/$examSub/feat/$examFeat.feat/design.fsf $ofile							##MIG/MIG-2722/feat/P1M1R1_un005.feat/design.fsf

##replace output directory
sed s-$dir/$examSub/feat/$examFeat-{$feat_dir}-g <$ofile>$tempfile				##MIG/MIG-2722/feat/P1M1R1_un005
cp $tempfile $ofile

##replace VOLUMES                                        
sed s-fmri(npts) 165-{fmri(npts) $npts}-g <$ofile>$tempfile						##R1 has 165 volumes; make variable because run 2 has 149
cp $tempfile $ofile

##replace 4D-DATA
sed s-$dir/$examSub/fun/P1$run\_trim-{$FourD}-g <$ofile>$tempfile				##MIG/MIG-2722/fun/P1R1_trim
cp $tempfile $ofile

##replace BRAINMASK
sed s-$dir/$examSub/ana/FST1/mri/brainmask-{$anat}-g <$ofile>$tempfile			##MIG/MIG-2722/ana/FST1/mri/brainmask
cp $tempfile $ofile

##replace EV directories
sed s-$dir/$examSub/be/onsets-{$onDir}-g <$ofile>$tempfile

##replace MOTPARS 																##if running McFlirt to extract MPs and adding temporal derivatives
# # sed s-MOTPARS-{$design/motpars}-g <$ofile>$tempfile
# # cp $tempfile $ofile

##remove tempfile
rm $tempfile

# end