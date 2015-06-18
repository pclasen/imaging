#! /bin/csh -ef

#################################################################################
# subroutine for level2Design.csh												#
# Usage: ./MIGP2L2.csh <dir> <sub> <model> <L1design> <examSub> <L2 design>		#
# p.clasen																		#
#################################################################################

# set arguments locally 
set dir = $1
set sub = $2
set mod = $3
set examFeat = $4
set examSub = $5
set examGfeat = $6

# subject level directories
set fun = $dir/$sub/fun
set feat = $dir/$sub/feat
set design = $feat/$mod/$examFeat/designFiles

#sets your output file:
set ofile = $design/$examGfeat.fsf		 													

#set temp file:
set tempfile = $design/design-temp.txt																																						

##Make Design File
cp $dir/$examSub/feat/$mod/$examFeat/$examGfeat.gfeat/design.fsf $ofile								

##replace subject ID
sed -e 's/'{$examSub}'/'{$sub}'/g' <$ofile>$tempfile
cp $tempfile $ofile

##replace Featwatcher
sed -e 's/fmri(featwatcher_yn) 1/fmri(featwatcher_yn) 0/g' <$ofile>$tempfile	
cp $tempfile $ofile

##remove tempfile
rm $tempfile

# end