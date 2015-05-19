#! /bin/csh -ef

#########################################
# copy data from drive to local			#
# Usage: ./cpNRSA.csh <study> <sub>		#	
#########################################

set DIR = ~/Documents/$1
set sub = $2
set nrsa = /Volumes/clasenEx/Imaging/nrsa

mkdir $DIR/$sub
mkdir $DIR/$sub/ana
mkdir $DIR/$sub/fun

if (-f $nrsa/$sub/bold/resting1_bold_swap_trim.nii.gz) then
    cp $nrsa/$sub/bold/resting1_bold_swap_trim.nii.gz $DIR/$sub/fun/R1.nii.gz
endif

if (-f $nrsa/$sub/bold/resting2_bold_swap_trim.nii.gz) then
    cp $nrsa/$sub/bold/resting2_bold_swap_trim.nii.gz $DIR/$sub/fun/R2.nii.gz
endif

cp $nrsa/$sub/stru/brainmask.nii.gz $DIR/$sub/ana/brainmask.nii.gz

# end