#!/bin/csh

#############################################
# create WM and LatVent masks from FS		#
# Usage:	./fsMASK.csh <study> <sub>		#
# Ex:		./fsMASK.csh MIG MIG-2722		#
# p.clasen									#
#############################################

set DIR = ~/Documents/$1
set sub = $2

mri_convert $DIR/$sub/ana/FST1/mri/aseg.mgz $DIR/$sub/ana/FST1/mri/aseg.nii.gz

# white matter
fslmaths $DIR/$sub/ana/FST1/mri/aseg.nii.gz -uthr 41 -thr 41 $DIR/$sub/ana/FST1/mri/rwm.nii.gz
fslmaths $DIR/$sub/ana/FST1/mri/aseg.nii.gz -uthr 2 -thr 2 $DIR/$sub/ana/FST1/mri/lwm.nii.gz
fslmaths $DIR/$sub/ana/FST1/mri/rwm.nii.gz -add $DIR/$sub/ana/FST1/mri/lwm.nii.gz -bin $DIR/$sub/ana/FST1/mri/bin_WM_mask.nii.gz

# ventricles
fslmaths $DIR/$sub/ana/FST1/mri/aseg.nii.gz -uthr 43 -thr 43 $DIR/$sub/ana/FST1/mri/rvent.nii.gz
fslmaths $DIR/$sub/ana/FST1/mri/aseg.nii.gz -uthr 4 -thr 4 $DIR/$sub/ana/FST1/mri/lvent.nii.gz
fslmaths $DIR/$sub/ana/FST1/mri/rvent.nii.gz -add $DIR/$sub/ana/FST1/mri/lvent.nii.gz -bin $DIR/$sub/ana/FST1/mri/bin_LatVent_mask.nii.gz

# clean up
foreach del (rwm lwm rvent lvent)
	rm $DIR/$sub/ana/FST1/mri/$del.nii.gz
end

# end