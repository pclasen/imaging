#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./nativeROI.csh <study> <phase> <model> <example feat>	<type> <ROI>		#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./nativeROI.csh MIG P1 M1 R1_FIR anatomical RAMY6 							#
# Ex:	 ./nativeROI.csh RAP M1 R1_FIR ...		 									#
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
		set roiType = $5
		set roi = $6
		set featdir = $DIR/$sub/feat/$phase/$model

		# phase 1 create design files
		if ($phase == P1) then

			foreach run (R1 R2)  # phase 1 has 2 runs

				# set run level directory
				set rundir = $featdir/glm/$run$desStub.feat

				# make rois directory in feat directory
				if (-d $rundir/rois) then
				else
					mkdir $rundir/rois
				endif

				# get anatomical ROIs into native space
				if ($roiType == anatomical) then

					if (-f $rundir/rois/$roi\_ntv) then
					else
					
						# set anatomical ROI directory
						set anROI = $DIR/group/ROIs/$roi.nii.gz

						# convert standard space ROI to native space
						flirt -in $anROI -applyxfm -init $rundir/reg/standard2example_func.mat -out $rundir/rois/$roi\_ntv -paddingsize 0.0 -interp nearestneighbour -ref $rundir/filtered_func_data.nii.gz

					endif

				else

					# error
					echo "No functioanl ROIs have been generated for this phase."
					
				endif # type of ROI

			end # for all runs

		endif # phase 1

		# phase 2 create design files
		if ($phase == P2) then

			foreach run (R1 R2 R3 R4 R5 R6 R7 R8) # phase 2 has 8 runs

				# set run level directory
				set rundir = $featdir/glm/$run$desStub.feat

				# make rois directory in feat directory
				if (-d $rundir/rois) then
				else
					mkdir $rundir/rois
				endif

				# get anatomical ROIs into native space
				if ($roiType == anatomical) then

					if (-f $rundir/rois/$roi\_ntv) then
					else
					
						# set anatomical ROI directory
						set anROI = $DIR/group/ROIs/$roi.nii.gz

						# convert standard space ROI to native space
						flirt -in $anROI -applyxfm -init $rundir/reg/standard2example_func.mat -out $rundir/rois/$roi\_ntv -paddingsize 0.0 -interp nearestneighbour -ref $rundir/filtered_func_data.nii.gz

					endif

				# get functional ROIs into native space
				else if ($roiType == functional) then

					if ($roi == FgS || $roi == FUSI_FgS) then

						if (-f $rundir/rois/FgS_ntv.nii.gz) then
						else

							# set functional ROI
							set funROI = $DIR/$sub/feat/P1/M1/glm/FE_U05_MO.feat/cope1.feat/thresh_zstat1.nii.gz

							# convert functional ROI to native space 
		 					flirt -in $funROI -applyxfm -init $rundir/reg/standard2example_func.mat -out $rundir/rois/FgS_ntv -paddingsize 0.0 -interp nearestneighbour -ref $rundir/filtered_func_data.nii.gz

		 					# binarize it
		 					fslmaths $rundir/rois/FgS_ntv.nii.gz -bin $rundir/rois/FgS_ntv.nii.gz

	 					endif

	 					# masking by fusiform in native space
	 					if ($roi == FUSI_FgS) then

	 						if (-f $rundir/rois/FUSIHO_ntv.nii.gz) then
	 						else

								# set anatomical ROI directory
								set anROI = $DIR/group/ROIs/FUSIHO.nii.gz

								# convert standard space ROI to native space
								flirt -in $anROI -applyxfm -init $rundir/reg/standard2example_func.mat -out $rundir/rois/FUSIHO_ntv -paddingsize 0.0 -interp nearestneighbour -ref $rundir/filtered_func_data.nii.gz

							endif

							# restrict functional mask by fusiform in native space and binarize
	 						fslmaths $rundir/rois/FgS_ntv.nii.gz -mul $rundir/rois/FUSIHO_ntv.nii.gz -bin FUSI_FgS_ntv.nii.gz

 						endif 

					else if ($roi == SgF || $roi == PH_SgF) then

						if (-f $rundir/rois/SgF_ntv.nii.gz) then
						else

							# set functional ROI
							set funROI = $DIR/$sub/feat/P1/M1/glm/FE_U05_MO.feat/cope2.feat/thresh_zstat1.nii.gz

							# convert functional ROI to native space 
		 					flirt -in $funROI -applyxfm -init $rundir/reg/standard2example_func.mat -out $rundir/rois/SgF_ntv -paddingsize 0.0 -interp nearestneighbour -ref $rundir/filtered_func_data.nii.gz

		 					# binarize it
		 					fslmaths $rundir/rois/FgS_ntv.nii.gz -bin $rundir/rois/SgF_ntv.nii.gz

	 					endif

	 					# masking by fusiform in native space
	 					if ($roi == PH_FgS) then

	 						if (-f $rundir/rois/PHHO_ntv.nii.gz) then
	 						else

								# set anatomical ROI directory
								set anROI = $DIR/group/ROIs/PHHO.nii.gz

								# convert standard space ROI to native space
								flirt -in $anROI -applyxfm -init $rundir/reg/standard2example_func.mat -out $rundir/rois/PHHO_ntv -paddingsize 0.0 -interp nearestneighbour -ref $rundir/filtered_func_data.nii.gz

							endif

							# restrict functional mask by fusiform in native space and binarize
	 						fslmaths $rundir/rois/SgF_ntv.nii.gz -mul $rundir/rois/PHHO_ntv.nii.gz -bin PH_SgF_ntv.nii.gz

 						endif 
					
					endif # ROI name

				endif # type of ROI (ana/fun)

			end # for all runs

		endif # for phase 2

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# error
		echo "No ROIs specificed for RAP at this time. Need to alter this script."

end # for each subject

## end