#! /bin/csh -ef

#########################################################
# subroutine for level1Design.csh												#
# Usage: ./MIGP1L1.csh <dir> <sub> <model> <run> <desName> <examSub> <examFeat>	#
# p.clasen																		#
#########################################################

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
set feat_dir = $feat/P1/$mod/$desName/$desRun.feat

#sets your fmri dir:
set fmri_dir = $fun

#sets your output file:
set ofile = $design/$desRun.fsf

#set temp file:
set tempfile = $design/design-temp.txt

#sets your 4D feat data:
set FourD = $fmri_dir/P1$run\_trim.nii.gz

#sets your anatomical
set anat = $dir/$sub/ana/FST1/mri/brainmask.nii.gz

#finds your total volumes
set volumes = (`fslinfo $FourD | grep "dim4 "| awk '{print  $2}'`)
set npts = $volumes[1]

##Make Design File
cp $dir/$examSub/feat/$examFeat.feat/design.fsf $ofile

##replace output directory
sed s-$dir/$examSub/feat/$examSub-{$feat_dir}-g <$ofile>$tempfile
cp $tempfile $ofile

##replace VOLUMES                                        
sed s-fmri(npts) 165-{fmri(npts) $npts}-g <$ofile>$tempfile
cp $tempfile $ofile

##replace 4D-DATA
sed s-$dir/$examSub/fun/P1$run\_trim-{$FourD}-g <$ofile>$tempfile
cp $tempfile $ofile

##replace BRAINMASK
sed s-$dir/$examSub/fun/ana/FST1/mri/brainmask-{$anat}-g <$ofile>$tempfile
cp $tempfile $ofile

##replace subid for all EV timing files


##replace MOTPARS 
# # sed s-MOTPARS-{$design/motpars}-g <$ofile>$tempfile
# # cp $tempfile $ofile

##remove tempfile
rm $tempfile

# end