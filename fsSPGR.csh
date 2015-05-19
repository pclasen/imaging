#! /bin/csh -ef

#########################################
# SPGR processing (autorecon-all)       #
# Usage:    ./fsSPGR.csh <study>        #
# Ex:       ./fsSPGR.csh MIG            #
# p.clasen                              #
#########################################

# requires up to date asublist.txt

set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt
set doc = $DIR/doc/fsSPGRlog.txt

foreach line ("`cat $file`")	    

    # assign sub from file 
    set sub = "$line"
    set freesurf = $DIR/$sub/ana/FST1

    # copy files if not already done
    if (-d $freesurf) then
    else

    	# autorecon all (freesurfer)
    	echo RECON $sub START: `date` >> $doc
    	recon-all -i $DIR/$sub/ana/spgr.nii.gz -s FST1 -sd /$DIR/$sub/ana/ -all
    	echo RECON $sub END: `date` >> $doc   

    	# convert .mgz to .nii
        mri_convert --in_type mgz --out_type nii --out_orientation RAS $DIR/$sub/ana/FST1/mri/brainmask.mgz $DIR/$sub/ana/FST1/mri/brainmask.nii.gz

    endif

end # for loop
# end