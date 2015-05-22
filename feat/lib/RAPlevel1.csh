#! /bin/csh -ef

#############################################
# subroutine for level1Design.csh			#
# Usage: ./RAPlevel1.csh <dir> <sub> <run>	#
# p.clasen									#
#############################################

# arguments
set dir = $2
set sub = $3
set run = $4
# directories
set fun = $dir/$sub/fun
set feat = $dir/$sub/feat
set design = $feat/designFiles/

#sets your feat dir:
set feat_dir = $feat/$phase$model$run.feat

#sets your fmri dir:
set fmri_dir = $fun

#sets your output file:
set ofile = $design/$run.fsf

#set temp file:
set tempfile = $design/design-temp.txt

#sets your 4D feat data:
set FourD = $fmri_dir/$run\_trim.nii.gz

#sets your anatomical
set anat = $dir/$sub/ana/FST1/mri/brainmask.nii.gz

#finds your total volumes
set volumes = (`fslinfo $FourD | grep "dim4 "| awk '{print  $2}'`)
set npts = $volumes[1]

##Make Design File
cp $design/design-template.txt $ofile

##replace output directory
sed s-OUTPUT_DIRECTORY-{$feat_dir}-g <$ofile>$tempfile
cp $tempfile $ofile

##replace VOLUMES
sed s-VOLUMES-{$npts}-g <$ofile>$tempfile
cp $tempfile $ofile

##replace 4D-DATA
sed s-4D_DATA-{$FourD}-g <$ofile>$tempfile
cp $tempfile $ofile

##replace BRAINMASK
sed s-BRAINMASK-{$anat}-g <$ofile>$tempfile
cp $tempfile $ofile

##replace MOTPARS 
# # sed s-MOTPARS-{$design/motpars}-g <$ofile>$tempfile
# # cp $tempfile $ofile

##remove tempfile
rm $tempfile

# end