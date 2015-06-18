#! /bin/csh -ef

#################################################################################
# subroutine for PSmakeFSF.csh													#
# Usage: ./PSmigP2.csh <dir> <sub> <model> <run> <examSub> 						#
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
set design = $feat/P2/$mod/prestats/designFiles

# generate name for new copy of example design
set  desRun = $run

#sets your output file:
set ofile = $design/$desRun.fsf		 													

#set temp file:
set tempfile = $design/design-temp.txt													

#sets your 4D feat data:
set FourD = $fun/P2$run\_trim.nii.gz																									

##Make Design File
cp $dir/$examSub/feat/P2/$mod/prestats/R1.feat/design.fsf $ofile								

##replace subject ID
sed -e 's/'{$examSub}'/'{$sub}'/g' <$ofile>$tempfile
cp $tempfile $ofile

##replace run
sed -e 's/R1/'{$run}'/g' <$ofile>$tempfile 
cp $tempfile $ofile

##replace design name
sed -e 's/R1/'{$desRun}'/g' <$ofile>$tempfile
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