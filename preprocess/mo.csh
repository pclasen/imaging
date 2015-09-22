#!/bin/csh

#########################################
# run fsl_motion_outliers on all subs	#
# Usage:	./mo.csh <study>			#
# Ex:		./mo.csh MIG				#
# p.clasen								#
#########################################

set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt
set metric = dvars
set threshold = threshold_box_plot_cutoff


foreach line ("`cat $file`")	    

    # assign sub from file 
    set sub = "$line"

    if ($1 == MIG) then

	    foreach phase (P1 P2)

	    	if ($phase == P1) then

	    		if (-d $DIR/$sub/feat) then
	    		else
	    			mkdir $DIR/$sub/feat
    			endif
	    			
	    		if (-d $DIR/$sub/feat/$phase/motion_outliers) then
	    		else
	    			mkdir $DIR/$sub/feat/$phase/motion_outliers
				endif

	    		foreach run (R1 R2)

	    			if (-f $DIR/$sub/feat/$phase/motion_outliers/$run.png) then
	    			else

					    # run fsl_motion_outliers
						fsl_motion_outliers -i $DIR/$sub/fun/$phase$run\_trim.nii.gz -o $DIR/$sub/feat/$phase/motion_outliers/$run.txt --$metric -p $DIR/$sub/feat/$phase/motion_outliers/$run

					endif

				end # phase 1 run loop

				echo "$metric $threshold" > $DIR/$sub/feat/$phase/motion_outliers/metric.txt

	    	else if ($phase == P2) then

	    		if (-d $DIR/$sub/feat/$phase/motion_outliers) then
	    		else
	    			mkdir $DIR/$sub/feat/$phase/motion_outliers
				endif

	    		foreach run (R1 R2 R3 R4 R5 R6 R7 R8)

	    			if (-f $DIR/$sub/feat/$phase/motion_outliers/$run.png) then
	    			else

					    # run fsl_motion_outliers
						fsl_motion_outliers -i $DIR/$sub/fun/$phase$run\_trim.nii.gz -o $DIR/$sub/feat/$phase/motion_outliers/$run.txt --$metric -p $DIR/$sub/feat/$phase/motion_outliers/$run

					endif

				end # phase 1 run loop

				echo "$metric $threshold" > $DIR/$sub/feat/$phase/motion_outliers/metric.txt

			endif #if phase 1 or 2


		end # phase loop

	endif # MIG

    if ($1 == RAP) then

    	if (-d $DIR/$sub/feat) then
    	else
    		mkdir $DIR/$sub/feat
		endif


		if (-d $DIR/$sub/feat/motion_outliers) then
		else
			mkdir $DIR/$sub/feat/motion_outliers
		endif

		foreach run (R1 R2 R3 R4)

			if (-f $DIR/$sub/feat/motion_outliers/$run.png) then
			else

			    # run fsl_motion_outliers
				fsl_motion_outliers -i $DIR/$sub/fun/$run\_trim.nii.gz -o $DIR/$sub/feat/motion_outliers/$run.txt --$metric -p $DIR/$sub/feat/motion_outliers/$run

			endif

		end # run loop

		echo "$metric $threshold" > $DIR/$sub/feat/motion_outliers/metric.txt

	endif # if RAP

end # sub loop

# end