#! /bin/csh -ef

#########################################
# SPGR processing (autorecon-all)	#
#					#
# Usage: ./fsSPRG.csh            	#
#########################################

# requires up to date SNI_files_copied log

set DIR = $STUDY_DIR # set this in the environment (e.g., ~/Documents/MIG)
set file = $DIR/doc/SNI_files_copied.txt

foreach line ("`cat $file`")	    

    # assign sub from file 
    set sub = "$line"
    set freesurf = $DIR/$sub/ana/FST1

    # copy files if not already done
    if (-d $freesurf) then
    else

	# autorecon all (freesurfer)
	echo RECON $sub START: `date` >> $DIR/fsSPRG_log.txt
	recon-all -i $DIR/$sub/ana/spgr.nii.gz -s FST1 -sd /$DIR/$sub/ana/ -all
	echo RECON $sub END: `date` >> $DIR/fsSPRG_log.txt 

	# convert .mgz to .nii
	mri_convert --in_type mgz --out_type nii --out_orientation RAS $DIR/$sub/ana/FST1/mri/brainmask.mgz $DIR/$sub/ana/FST1/mri/brainmask.nii.gz

    endif

end # for loop


    
