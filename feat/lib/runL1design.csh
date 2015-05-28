#! /bin/csh -ef

#####################################################################################
# run first level design files														#
# Usage: ./runL1design.csh <study> <phase> <model> <example feat>					#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./runL1design.csh MIG P1 M1 P2M1_un005			 							#
# Ex:	 ./runL1design.csh RAP M1 M1_un005 											#
# p.clasen																			#
#####################################################################################

# Run level 1 feat for a particular model for each run of each suject

# set arguments
set DIR = ~/Documents/$1
set file = $DIR/doc/asublist_test.txt

foreach line ("`cat $file`")
		
	# set subject
	set sub = "$line"

	## RUN MIG level 1				
	if ($1 == MIG) then

		# set arguments
		set phase = $2
		set model = $3
		set design = `echo $4 | sed -e 's/R1//'`

		# read designRun name off design file
		foreach desRun ($DIR/$sub/feat/$phase/$model/$design/designFiles/*.fsf)
			
			# grab name
			set desName = `echo $desRun | sed -e 's|'{$DIR/$sub/feat/$phase/$model/$design/designFiles/}'||' | sed -e 's/.fsf//g'`

			# check if .feat already esists; if not - run the model
			if (-d $DIR/$sub/feat/$phase/$model/$design/$desName.feat) then
			else
				feat $desRun
			endif

		end

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $2
		set design = `echo $3 | sed -e 's/R1//'`

		# read designRun name off design file
		foreach desRun ($DIR/$sub/feat/$model/$design/designFiles/*.fsf)
			
			# grab name
			set desName = `echo $desRun | sed -e 's|'{$DIR/$sub/feat/$model/$design/designFiles/}'||' | sed -e 's/.fsf//g'`

			# check if .feat already esists; if not - run the model
			if (-d $DIR/$sub/feat/$model/$design/$desName.feat) then
			else
				feat $desRun
			endif

		end

	endif # RAP

end # for each subject

## end