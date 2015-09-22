#! /bin/csh -ef

#####################################################################################
# run first level design files														#
# Usage: ./GLMrunFSF.csh <study> <phase> <model> <example feat>						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./GLMrunFSF.csh MIG P1 M1 						 							#
# Ex:	 ./GLMrunFSF.csh RAP M1 	 												#
# p.clasen																			#
#####################################################################################

# Run level 1 feat for a particular model for each run of each suject

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

		# read designRun name off design file
		foreach desRun ($DIR/$sub/feat/$phase/$model/glm/designFiles/*.fsf)
			
			# grab name
			set desName = `echo $desRun | sed -e 's|'{$DIR/$sub/feat/$phase/$model/glm/designFiles/}'||' | sed -e 's/.fsf//g'`

			# check if .feat already esists; if not - run the model
			if (-f $DIR/$sub/feat/$phase/$model/glm/$desName.feat/design.fsf) then
			else
				if (-f $DIR/$sub/feat/$phase/$model/glm/$desName.gfeat/design.fsf) then
				else
					feat $desRun
				endif
			endif

		end

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $2

		# read designRun name off design file
		foreach desRun ($DIR/$sub/feat/$model/glm/designFiles/*.fsf)
			
			# grab name
			set desName = `echo $desRun | sed -e 's|'{$DIR/$sub/feat/$model/glm/designFiles/}'||' | sed -e 's/.fsf//g'`
			
			# check if .feat already esists; if not - run the model
			if (-f $DIR/$sub/feat/$model/glm/$desName.feat/design.fsf) then
			else
				if (-f $DIR/$sub/feat/$model/glm/$desName.gfeat/design.fsf) then
				else
					feat $desRun
				endif
			endif


		end

	endif # RAP

end # for each subject

## end