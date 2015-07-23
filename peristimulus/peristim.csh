#! /bin/csh -ef

#####################################################################################
# wrapper for peristimulus timeseries scripts										#
# Usage: ./peristim.csh <study> <exam sub> <phase> <model> 							#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./peristim.csh MIG MIG-2722 P1 M1 											#
# Ex:	 ./peristim.csh RAP RAP-???? M1			 									#
# p.clasen																			#
#####################################################################################


# set arguments
set study = $1
set examSub = $2

if ($1 == MIG) then

	# study specific 
	set phase = $3
	set model = $4
	set fir = R1_FIR

	## run FIR models
	~/imaging/feat/glm.csh $study $examSub $phase $model $fir

	## merge condition specific PEs from FIR models
	~/imaging/peristimulus/mergeFIR.csh $study $phase $model $fir

	## standard space rois to native space & extract peristimulus timeseries
	foreach anROI (PHHO FUSIHO RAMY6)

		## standard space rois to native space
		~/imaging/peristimulus/nativeROI.csh $study $phase $model $fir anatomical $anROI

		## extract peristimulus ROIs 
		~/imaging/peristimulus/tsROI.csh $study $phase $model $fir $anROI

	end # anatomical rois

	## standard space rois to native space & extract peristimulus timeseries
	foreach funROI (FgS SgF FUSI_FgS PH_SgF)

		## standard space rois to native space
		~/imaging/peristimulus/nativeROI.csh $study $phase $model $fir functional $funROI

		## extract peristimulus ROIs 
		~/imaging/peristimulus/tsROI.csh $study $phase $model $fir $funROI

	end # functional rois



else if ($1 == RAP) then

	echo "Not set up to run peristimulus timesereis extraction for RAP. Edit this script and dependencies."

endif


# end