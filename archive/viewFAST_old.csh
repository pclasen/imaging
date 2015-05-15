#! /bin/csh -ef

#########################################
# view segmentations from FAST   	#
#					#
# Usage: ./viewFAST.csh <file>		#
#########################################

## REQUIRES accurate "sublist.txt"

set DIR = $STUDY_DIR
set file = $DIR/$1
set doc = $DIR/documentation/FAST_review.txt

echo "Order: 1. CSF, 2. White Matter, 3. Grey Matter"
echo "Use the 'a' key to note no errors & the 'p' key to note errors."
echo "If no errors for CSF and White Matter images, you will be asked to review thresholded (=1) images."
echo ""
echo `Date` "FILE:" $file >> $doc

foreach line ("`cat $file`")

    # assign sub from file 
    set sub = "$line"

    #################################################################################
    # examine CSF mask

    if (-f $DIR/$sub/ana/thresh_CSF_mask.nii.gz) then
    else

    if (-f $DIR/$sub/ana/brainmask_pve_0.nii.gz) then

	set ans1 = ""

	while ($ans1 != "a" || $ans1 != "p")
	    
	    # Open in fslview to examine
	    echo "$sub CSF segmentation..."
	    fslview $DIR/$sub/ana/brainmask_pve_0.nii.gz &
	    
	    # assign as no errors or errors
	    set ans1 = $< # "a" no errors; "p" errors 
	    
	    if ($ans1 == "a") then
		
		# close fslview
		kill %

		# generate thresholded CSF mask & view it
		fslmaths $DIR/$sub/ana/brainmask_pve_0.nii.gz -thr 1 $DIR/$sub/ana/thresh_CSF_mask.nii.gz
		
		set ans2 = ""
		
		while ($ans2 != "a" || $ans2 != "p")

		    # review thresholded mask
		    echo "$sub Thresholded CSF segmentation..."
		    fslview $DIR/$sub/ana/thresh_CSF_mask.nii.gz &
		    
		    # assign as no errors or errors
		    set ans2 = $< # "a" no errors; "p" errors 
		    
		    if ($ans2 == "a") then
		    
			# close fslview
			kill %

		    else if ($ans2 == "p") then 
			
			# clear input, close fslview, note errors to review file, and remove thresholded file
			unset ans2
			kill %
			echo "$sub thresh_CSF_mask errors" >> $doc
			rm $DIR/$sub/ana/thresh_CSF_mask.nii.gz

		    endif

		    break # while loop

		end # while thresh_CSF_mask review

	    else if ($ans1 == "p") then
		
		# clear input and note errors to review file
		unset ans1
		kill %
		echo "$sub brainmask_pve_0 errors" >> $doc

	    endif
	    
	    break # while loop

       end # while brainmask_pve_0 review

    else

	# note that the segmenation file is missing
	echo "$sub brainmask_pve_0 missing" >> $doc

    endif  # if brainmasl_pve_0 exists  

    endif # check for existing CSF mask


    #################################################################################
    # examine White Matter mask
    if (-f $DIR/$sub/ana/thresh_WM_mask.nii.gz) then
    else

    if (-f $DIR/$sub/ana/brainmask_pve_2.nii.gz) then

	set ans1 = ""

	while ($ans1 != "a" || $ans1 != "p")
	    
	    # Open in fslview to examine
	    echo "$sub White matter segmentation..."
	    fslview $DIR/$sub/ana/brainmask_pve_2.nii.gz &
	    
	    # assign as no errors or errors
	    set ans1 = $< # "a" no errors; "p" errors 
	    
	    if ($ans1 == "a") then
		
		# close fslview
		kill %

		# generate thresholded WM mask & view it
		echo "$sub Thresholded white matter segmentation..."
		fslmaths $DIR/$sub/ana/brainmask_pve_2.nii.gz -thr 1 $DIR/$sub/ana/thresh_WM_mask.nii.gz
		
		set ans2 = ""
		
		while ($ans2 != "a" || $ans2 != "p")

		    # review thresholded mask
		    fslview $DIR/$sub/ana/thresh_WM_mask.nii.gz &
		    
		    # assign as no errors or errors
		    set ans2 = $< # "a" no errors; "p" errors 
		    
		    if ($ans2 == "a") then
		    
			# close fslview
			kill %

		    else if ($ans2 == "p") then 
			
			# clear input, close fslview, note errors to review file, and remove thresholded file
			unset ans2
			kill %
			echo "$sub thresh_WM_mask errors" >> $doc
			rm $DIR/$sub/ana/thresh_WM_mask.nii.gz
			    
		    endif

		    break # while loop

		end # while thresh_WM_mask review
		
		
	    else if ($ans1 == "p") then
		
		# clear input and note errors to review file
		unset ans1
		kill %
		echo "$sub brainmask_pve_2 errors" >> $doc

	    endif
	    
	    break # while loop

       end # while brainmask_pve_2 review

    else
	
	# note that the segmenation file is missing
	echo "$sub brainmask_pve_2 missing" >> $doc

    endif  # if brainmasl_pve_2 exists 

    endif # check for exsiting thresh_WM_mask

    #################################################################################
    # examine Grey Matter mask
    if (-f $DIR/$sub/ana/GM_mask.nii.gz) then
    else

	if (-f $DIR/$sub/ana/brainmask_pve_1.nii.gz) then

	set ans1 = ""

	while ($ans1 != "a" || $ans1 != "p")
	    
	    # Open in fslview to examine
	    echo "$sub Grey matter segmentation..."
	    fslview $DIR/$sub/ana/brainmask_pve_1.nii.gz &
	    
	    # assign as no errors or errors
	    set ans1 = $< # "a" no errors; "p" errors 
	    
	    if ($ans1 == "a") then
		
		# close fslview
		kill %

		# rename GM mask (not thresholded)
		fslmaths $DIR/$sub/ana/brainmask_pve_1.nii.gz $DIR/$sub/ana/GM_mask.nii.gz
		
	    else if ($ans1 == "p") then
		
		# clear input and note errors to review file
		unset ans1
		kill %
		echo "$sub brainmask_pve_1 errors" >> $doc

	    endif

	    break # while loop

       end # while brainmask_pve_1 review

    else

	# note that the segmenation file is missing
	echo "$sub brainmask_pve_1 missing" >> $doc

    endif  # if brainmasl_pve_1 exists 
    
    endif # check for existing GM_mask

end # for sublist loop

echo "FAST review done" `date`
