#! /bin/csh -ef

#################################################################################
# subroutine for GLMmakeFSF.csh													#
# Usage: ./GLMmigP1.csh <dir> <sub> <model> <run> <examSub> <examFeat>			#
# p.clasen																		#
#################################################################################

# set arguments locally 
set dir = $1
set sub = $2
set mod = $3
set run = $4
set examSub = $5
set examFeat = $6

# subject level directories
set fun = $dir/$sub/fun
set feat = $dir/$sub/feat
set design = $feat/P1/$mod/glm/designFiles

# generate name for new copy of example design
set  desRun = `echo $examFeat | sed -e 's/R1/'{$run}'/g'`

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
cp $dir/$examSub/feat/P1/$mod/glm/$examFeat.feat/design.fsf $ofile								

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

##replace motion outlier confound
set moFile = `grep -ci '# Confound EVs text file for analysis 1' $ofile`

if (-f $dir/$sub/feat/P1/motion_outliers/$run.txt) then
	sed -e 's/fmri(confoundevs) 0/fmri(confoundevs) 1/g' <$ofile>$tempfile

	if ($moFile == 1) then
	else
		sed -i -e '275i# Confound EVs text file for analysis 1\' <$ofile>$tempfile
		sed -i -e '276iset confoundev_files(1) "/Users/petercclasen/Documents/MIG/'{$sub}'/feat/P1/motion_outliers/'{$run}'.txt"\\' <$ofile>$tempfile
	endif
else
	sed -e 's/fmri(confoundevs) 1/fmri(confoundevs) 0/g' <$ofile>$tempfile
endif
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