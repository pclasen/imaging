#! /bin/csh -ef

#################################################################################
# subroutine for PSmakeFSF.csh													#
# Usage: ./PSmigP1.csh <dir> <sub> <model> <run> <examSub> 						#
# p.clasen																		#
#################################################################################

# set arguments locally 
set dir = $1
set sub = $2
set mod = $3
set run = $4
set examSub = $5

# subject level directories
set fun = $dir/$sub/fun
set feat = $dir/$sub/feat
set design = $feat/P1/$mod/prestats/designFiles

# generate name for new copy of example design
set  desRun = $run

#sets your output file:
set ofile = $design/$desRun.fsf		 													

#set temp file:
set tempfile = $design/design-temp.txt													

#sets your 4D feat data:
set FourD = $fun/P1$run\_trim.nii.gz																									

#finds your total volumes
set volumes = (`fslinfo $FourD | grep "dim4 "| awk '{print  $2}'`)
set npts = $volumes[1]

##Make Design File
cp $dir/$examSub/feat/P1/$mod/glm/R1.feat/design.fsf $ofile								

##replace subject ID
sed -e 's/'{$examSub}'/'{$sub}'/g' <$ofile>$tempfile
cp $tempfile $ofile

##replace run
sed -e 's/R1/'{$run}'/g' <$ofile>$tempfile 
cp $tempfile $ofile

##replace design name
sed -e 's/'{$examFeat}'/'{$desRun}'/g' <$ofile>$tempfile
cp $tempfile $ofile

##replace VOLUMES                                        
sed -e 's/fmri(npts) 165/fmri(npts) '{$npts}'/g' <$ofile>$tempfile						##R1 has 165 volumes; make variable because run 2 has 149
cp $tempfile $ofile

##replace Featwatcher
sed -e 's/fmri(featwatcher_yn) 1/fmri(featwatcher_yn) 0/g' <$ofile>$tempfile	
cp $tempfile $ofile

##replace MOTPARS 																		##if running McFlirt to extract MPs and adding temporal derivatives
# # sed 's-MOTPARS-{$design/motpars}-g' <$ofile>$tempfile
# # cp $tempfile $ofile

##remove tempfile
rm $tempfile

# end