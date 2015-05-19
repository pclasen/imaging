#! /bin/csh -ef

#########################################
# create ventricle mask in stand space	#
# Usage: ./ventMask.csh					#
# p.clasen								#
#########################################

fslroi $FSLDIR/data/atlases/HarvardOxford/HarvardOxford-sub-prob-2mm.nii.gz LVentricle 2 1
fslroi $FSLDIR/data/atlases/HarvardOxford/HarvardOxford-sub-prob-2mm.nii.gz RVentricle 13 1
fslmaths LVentricle.nii.gz -add RVentricle.nii.gz -thr 1.0 -bin LatVentMask

# end