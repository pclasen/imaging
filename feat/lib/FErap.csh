#! /bin/csh -ef

#################################################################################
# subroutine for FEmakeFSF.csh													#
# Usage: ./FErap.csh <dir> <sub> <model> <examSub> <L2 design>					#
# p.clasen																		#
#################################################################################

# set arguments locally 
set dir = $1
set sub = $2
set mod = $3
set examSub = $4
set examGfeat = $5

# subject level directories
set fun = $dir/$sub/fun
set feat = $dir/$sub/feat
set design = $feat/$mod/glm/designFiles

#sets your output file:
set ofile = $design/$examGfeat.fsf		 													

#set temp file:
set tempfile = $design/design-temp.txt																																						

##Make Design File
cp $dir/$examSub/feat/$mod/glm/$examGfeat.gfeat/design.fsf $ofile								

##replace subject ID
sed -e 's/'{$examSub}'/'{$sub}'/g' <$ofile>$tempfile
cp $tempfile $ofile

##replace Featwatcher
sed -e 's/fmri(featwatcher_yn) 1/fmri(featwatcher_yn) 0/g' <$ofile>$tempfile	
cp $tempfile $ofile

##remove tempfile
rm $tempfile

# end