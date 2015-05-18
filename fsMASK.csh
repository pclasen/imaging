#!/bin/csh

#########################################
# copy subjects from SNI to local		#
#										#
# Usage: ./fsMASK.csh	<sub>			#
#########################################

set DIR = $STUDY_DIR
set sub = $1

mri_convert $STUDY_DIR/$sub/ana/FST1/mri/aseg.mgz $STUDY_DIR/$sub/ana/FST1/mri/aseg.nii.gz

# white matter
fslmaths $STUDY_DIR/$sub/ana/FST1/mri/aseg.nii.gz -uthr 41 -thr 41 $STUDY_DIR/$sub/ana/FST1/mri/rwm.nii.gz
fslmaths $STUDY_DIR/$sub/ana/FST1/mri/aseg.nii.gz -uthr 2 -thr 2 $STUDY_DIR/$sub/ana/FST1/mri/lwm.nii.gz
fslmaths $STUDY_DIR/$sub/ana/FST1/mri/rwm.nii.gz -add $STUDY_DIR/$sub/ana/FST1/mri/lwm.nii.gz -bin $STUDY_DIR/$sub/ana/FST1/mri/bin_WM_mask.nii.gz

# ventricles
fslmaths $STUDY_DIR/$sub/ana/FST1/mri/aseg.nii.gz -uthr 43 -thr 43 $STUDY_DIR/$sub/ana/FST1/mri/rvent.nii.gz
fslmaths $STUDY_DIR/$sub/ana/FST1/mri/aseg.nii.gz -uthr 4 -thr 4 $STUDY_DIR/$sub/ana/FST1/mri/lvent.nii.gz
fslmaths $STUDY_DIR/$sub/ana/FST1/mri/rvent.nii.gz -add $STUDY_DIR/$sub/ana/FST1/mri/lvent.nii.gz -bin $STUDY_DIR/$sub/ana/FST1/mri/bin_LatVent_mask.nii.gz

# clean up
foreach del (rwm lwm rvent lvent)
	rm $STUDY_DIR/$sub/ana/FST1/mri/$del.nii.gz
end



# end