#! /bin/csh -ef

#####################################################################################
# reorganize feat directories														#
# Usage: ./reORG.csh <study> <phase> <model> 									 	#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./GLMcpPrestats.csh MIG P1 M1 				  								#
# Ex:	 ./GLMcpPrestats.csh RAP M1 		  										#
# p.clasen																			#
#####################################################################################

# requires that pre-stats models are in prestats directory and current
# hard coded to move R?.feat as current prestats folder

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
		set prestats = $DIR/$sub/feat/$phase/$model/prestats
		set glm = $DIR/$sub/feat/$phase/$model/glm
		if (-d $DIR/$sub/feat/archive) then
		else
			mkdir $DIR/$sub/feat/archive
		endif

		if (-d $prestats) then
		else
			mkdir $prestats
		endif

		# phase 1 copy
		if ($phase == P1) then

			foreach run (R1 R2)

				set cpDir = $DIR/$sub/feat/$phase/$model/P1M1_STC_U05_NCR_ACC/P1M1$run\_STC_U05_NCR_ACC.feat

				if (-f $glm/designFiles/$run\_test.fsf) then
					rm $glm/designFiles/$run\_test.fsf
				endif

				# copy data - PRESTATS
				if (-d $prestats/$run.feat) then
				else
					mkdir $prestats/$run.feat
					cp -r $cpDir/mc $prestats/$run.feat/
					cp -r $cpDir/logs $prestats/$run.feat/
					cp -r $cpDir/reg $prestats/$run.feat/
					cp $cpDir/absbrainthresh.txt $prestats/$run.feat/
					cp $cpDir/example_func.nii.gz $prestats/$run.feat/
					cp $cpDir/filtered_func_data.nii.gz $prestats/$run.feat/
					cp $cpDir/absbrainthresh.txt $prestats/$run.feat/
					cp $cpDir/mask.nii.gz $prestats/$run.feat/
					cp $cpDir/mean_func.nii.gz $prestats/$run.feat/
					cp $cpDir/report_prestats.html $prestats/$run.feat/
					cp $cpDir/report_reg.html $prestats/$run.feat/

				endif

			end # run
			if (-d $DIR/$sub/feat/$phase/$model/P1M1_STC_U05_NCR_ACC) then
				mv $DIR/$sub/feat/$phase/$model/P1M1_STC_U05_NCR_ACC $DIR/$sub/feat/archive/
			endif

			if (-d $DIR/$sub/feat/$phase/$model/P1M1_STC_U005_NCR) then
				mv $DIR/$sub/feat/$phase/$model/P1M1_STC_U005_NCR $DIR/$sub/feat/archive/
			endif
			
			if (-d $DIR/$sub/feat/$phase/M2/P1M2_STC_U005_NCR) then
				mv $DIR/$sub/feat/$phase/M2/* $DIR/$sub/feat/archive/
			endif

			if (-d $DIR/$sub/feat/$phase/M2) then			
				rm -r $DIR/$sub/feat/$phase/M2
			endif

		
		endif # phase 1

		if ($phase == P2) then

			foreach run (R1 R2 R3 R4 R5 R6 R7 R8)

				set cpDir = $DIR/$sub/feat/$phase/$model/P2M2_STC_U005_NCR/P2M2$run\_STC_U005_NCR.feat

				# copy data
				if (-d $prestats/$run.feat) then
				else
					mkdir $prestats/$run.feat
					cp -r $cpDir/mc $prestats/$run.feat/
					cp -r $cpDir/logs $prestats/$run.feat/
					cp -r $cpDir/reg $prestats/$run.feat/
					cp $cpDir/absbrainthresh.txt $prestats/$run.feat/
					cp $cpDir/example_func.nii.gz $prestats/$run.feat/
					cp $cpDir/filtered_func_data.nii.gz $prestats/$run.feat/
					cp $cpDir/absbrainthresh.txt $prestats/$run.feat/
					cp $cpDir/mask.nii.gz $prestats/$run.feat/
					cp $cpDir/mean_func.nii.gz $prestats/$run.feat/
					cp $cpDir/report_prestats.html $prestats/$run.feat/
					cp $cpDir/report_reg.html $prestats/$run.feat/
				endif

			end # run
			if (-d $DIR/$sub/feat/$phase/$model/P2M2_STC_U005_NCR) then
				mv $DIR/$sub/feat/$phase/$model/P2M2_STC_U005_NCR $DIR/$sub/feat/archive/
			endif

		endif # phase 2

	endif # MIG

	## RUN RAP level 1				
	if ($1 == RAP) then
		
		# set arguments
		set model = $2
		set desStub = `echo $3 | sed -e 's/R1//'`
		set prestats = $DIR/$sub/feat/$model/prestats
		set glm = $DIR/$sub/feat/$model/glm
		if (-d $DIR/$sub/feat/archive) then
		else
			mkdir $DIR/$sub/feat/archive
		endif

		if (-d $prestats) then
		else
			mkdir $prestats
		endif

		foreach run (R1 R2 R3 R4)

				set cpDir = $DIR/$sub/feat/$model/M2_U05/M2$run\_U05.feat

				# copy data
				if (-d $prestats/$run.feat) then
				else
					mkdir $prestats/$run.feat
					cp -r $cpDir/mc $prestats/$run.feat/
					cp -r $cpDir/logs $prestats/$run.feat/
					cp -r $cpDir/reg $prestats/$run.feat/
					cp $cpDir/absbrainthresh.txt $prestats/$run.feat/
					cp $cpDir/example_func.nii.gz $prestats/$run.feat/
					cp $cpDir/filtered_func_data.nii.gz $prestats/$run.feat/
					cp $cpDir/absbrainthresh.txt $prestats/$run.feat/
					cp $cpDir/mask.nii.gz $prestats/$run.feat/
					cp $cpDir/mean_func.nii.gz $prestats/$run.feat/
					cp $cpDir/report_prestats.html $prestats/$run.feat/
					cp $cpDir/report_reg.html $prestats/$run.feat/
				endif

				if (-d $DIR/$sub/feat/$model/M2_U05) then
					mv $DIR/$sub/feat/$model/M2_U05 $DIR/$sub/feat/archive/
				endif

		end # run
		

	endif # RAP

end # for each subject

## end