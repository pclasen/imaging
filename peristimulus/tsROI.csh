#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./tsROI.csh <study> <phase> <model> <example feat> <ROI>					#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./tsROI.csh MIG P1 M1 R1_FIR RAMY6		 									#
# Ex:	 ./tsROI.csh RAP M1 R1_FIR ...		 										#
# p.clasen																			#
#####################################################################################

# set arguments
set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt

foreach line ("`cat $file`")
		
	# set subject
	set sub = "$line"

	## RUN MIG level 1				
	if ($1 == MIG) then
		
		# set arguments
		set phase = $2
		set model = $3
		set desStub = `echo $4 | sed -e 's/R1//'`
		set roi = $5
		set featdir = $DIR/$sub/feat/$phase/$model

		# phase 1 create design files
		if ($phase == P1) then

			# error
			echo "Not set up to extract timeseries data from ROIs in phase 1. Alter this script."

		endif # phase 1

		# phase 2 create design files
		if ($phase == P2) then

			# make rois directory in feat directory
			if (-d $featdir/peristimts) then
			else
				mkdir $featdir/peristimts
			endif

			foreach run (R1 R2 R3 R4 R5 R6 R7 R8) # phase 2 has 8 runs

				# set run level directory
				set rundir = $featdir/glm/$run$desStub.feat

				foreach trialCond (TswSF TswNF)

					if (-f $featdir/peristimts/$run\_$trialCond\_$roi.txt) then
					else
						fslmeants -i $rundir/stats/$trialCond.nii.gz -o $featdir/peristimts/$run\_$trialCond\_$roi.txt -m $rundir/rois/$roi\_ntv.nii.gz
					endif

				end # for all trialConds

			end # for all runs

		endif # for phase 2

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# error
		echo "Not set up to extract timeseries data from ROIs in RAP. Alter this script."

end # for each subject

## end