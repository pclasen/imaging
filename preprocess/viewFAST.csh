#! /bin/csh -ef

#########################################
# view segmentations from FAST_review	#
# Usage:	./viewFAST.csh <study>		#
# Ex:		./viewFAST.csh MIG 			#
#########################################

## REQUIRES accurate "asublist.txt"

set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt
set doc = $DIR/doc/FASTreview.txt

echo `Date` "FILE: $1 ##############" >> $doc

foreach line ("`cat $file`")

    # assign sub from file 
    set sub = "$line"

    #################################################################################
    # examine segmentation and registration

    if (-f $DIR/$sub/ana/brainmask_pve_0.nii.gz && -f $DIR/$sub/ana/brainmask_pve_1.nii.gz && -f $DIR/$sub/ana/brainmask_pve_2.nii.gz) then

	set ans1 = ""

	while ($ans1 != "a" || $ans1 != "p")
	    
	    # Open in fslview to examine
	    echo "$sub : CSF is Yellow, White Matter is Red, Grey Matter is Blue."
	    echo "'a' key - no errors; 'p' key - errors."
	    fslview $DIR/$sub/ana/brainmask.nii.gz $DIR/$sub/ana/brainmask_pve_0.nii.gz $DIR/$sub/ana/brainmask_pve_1.nii.gz $DIR/$sub/ana/brainmask_pve_2.nii.gz &

	    # assign as no errors or errors
	    set ans1 = $< # "a" no errors; "p" errors 
	    
	    if ($ans1 == "a") then
		
	        kill %
		
		if (-f $DIR/$sub/ana/bin_WM_mask.nii.gz) then
		else

		    echo "$sub : Generating binary masks for you to review..."

		    # binarize masks
		    fslmaths $DIR/$sub/ana/brainmask_seg.nii.gz -thr 1 -uthr 1 $DIR/$sub/ana/bin_CSF_mask.nii.gz
		    fslmaths $DIR/$sub/ana/brainmask_seg.nii.gz -thr 2 -uthr 2 $DIR/$sub/ana/bin_GM_mask.nii.gz
		    fslmaths $DIR/$sub/ana/brainmask_seg.nii.gz -thr 3 -uthr 3 $DIR/$sub/ana/bin_WM_mask.nii.gz
	      
		endif

		if (-f $DIR/$sub/ana/bin_LatVent_mask.nii.gz) then
		else

		    # register MNI to T1
		    echo "$sub : Getting transform for ventricle mask, this takes time..."
		    flirt -in $FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz -ref $DIR/$sub/ana/brainmask.nii.gz -out $DIR/$sub/ana/flirtMNI2T1 \
			-omat $DIR/$sub/ana/flirtMNI2T1.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12 -interp trilinear
		
		    # register lateral ventricle mask to native space
		    flirt -in $DIR/standMasks/LatVentMask.nii.gz -applyxfm -init $DIR/$sub/ana/flirtMNI2T1.mat -out $DIR/$sub/ana/native_LatVentMask.nii.gz \
			-paddingsize 0.0 -interp  nearestneighbour -ref $DIR/$sub/ana/brainmask.nii.gz 

		    # restrict ventricl mask to CSF from FAST
		    fslmaths $DIR/$sub/ana/bin_CSF_mask.nii.gz -mul $DIR/$sub/ana/native_LatVentMask.nii.gz -bin $DIR/$sub/ana/bin_LatVent_mask.nii.gz
		    
		endif

		# view binarized masks WM, GM, & Ventricle Masks
		
		set ans2 = ""
		
		while ($ans2 != "a" || $ans2 != "p")

		    # review the binary WM mask and ventricle mask
		    echo "$sub : Lateral Ventricle CSF is Yellow, White Matter is Red."
		    echo "'a' - no errors; 'p' key - errors."
		    fslview $DIR/$sub/ana/brainmask.nii.gz $DIR/$sub/ana/bin_LatVent_mask.nii.gz $DIR/$sub/ana/bin_WM_mask.nii.gz &
		    
		    # assign as no errors or errors
		    set ans2 = $< # "a" no errors; "p" errors 
		    
		    if ($ans2 == "a") then
		    
			# close fslview
			kill %

		    else if ($ans2 == "p") then 
			
			# clear input, close fslview, note errors to review file, and remove thresholded file
			kill %
			echo "$sub binary mask errors" >> $doc
			rm $DIR/$sub/ana/bin_CSF_mask.nii.gz $DIR/$sub/ana/bin_LatVent_mask.nii.gz $DIR/$sub/ana/bin_GM_mask.nii.gz $DIR/$sub/ana/bin_WM_mask.nii.gz

		    endif

		    break # while loop

		end # while binary WM/ventricle mask review

	    else if ($ans1 == "p") then
		
		# clear input and note errors to review file
		kill %
		echo "$sub segmentation errors" >> $doc

	    endif
	    
	    break # while loop

       end # while segmentation/registration review

    else

	# note that the segmenation file is missing
	echo "$sub missing segmentation files" >> $doc

    endif  # if segmentation files exist  

end # for sublist loop

echo "FAST review done for $1" `date`

# end