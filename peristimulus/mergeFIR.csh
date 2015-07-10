#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./mergeFIR.csh <study> <phase> <model> <example feat>						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./mergeFIR.csh MIG P1 M1 R1_FIR 			 								#
# Ex:	 ./mergeFIR.csh RAP M1 R1_FIR ...		 									#
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
		set featdir = $DIR/$sub/feat/$phase/$model

		# phase 1 create design files
		if ($phase == P1) then

			# error
			echo "Not set up to merge FIR model parameter estimates in phase 1. Alter this script."

		endif # phase 1

		# phase 2 create design files
		if ($phase == P2) then

			foreach run (R1 R2 R3 R4 R5 R6 R7 R8) # phase 2 has 8 runs

				# set run level directory
				set rundir = $featdir/glm/$run$desStub.feat

				foreach trialCond (TswSF TswNF)

					if (-f $featdir/stats/$trialCond.nii.gz) then
					else
						if ($trialCond == TswSF) then

							# concatenate the FIR parameter estimates for this condition in time
							cd $featdir/stats/
							fslmerge -t TswSF pe15.nii.gz pe16.nii.gz pe17.nii.gz pe18.nii.gz pe19.nii.gz pe20.nii.gz pe21.nii.gz pe22.nii.gz pe23.nii.gz pe24.nii.gz pe25.nii.gz
							cd ~

						else if ($trialCond == TswNF) then

							# concatenate the FIR parameter estimates for this condition in time
							cd $featdir/stats/
							fslmerge -t TswNF pe26.nii.gz pe27.nii.gz pe28.nii.gz pe29.nii.gz pe30.nii.gz pe31.nii.gz pe32.nii.gz pe33.nii.gz pe34.nii.gz pe35.nii.gz pe36.nii.gz
							cd ~

						endif # trialCond

					endif # concatenated file exists

				end # for all trialConds

			end # for all runs

		endif # for phase 2

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# error
		echo "Not set up to merge FIR model parameter estimates in RAP. Alter this script."

end # for each subject

## end