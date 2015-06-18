#! /bin/csh -ef

#####################################################################################
# run second level design files														#
# Usage: ./FErunFSF.csh <study> <phase> <model> <level2 design>						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./FErunFSF.csh MIG P1 M1 FE_U05											#
# Ex:	 ./FErunFSF.csh RAP M1 FE_U05 												#
# p.clasen																			#
#####################################################################################

# Run level 2 feat for a particular model for each suject

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
		set examGfeat = $4

		# read designRun name off design file
		set desRun = $DIR/$sub/feat/$phase/$model/glm/designFiles/$examGfeat.fsf
			
		# grab name
		set desName = `echo $desRun | sed -e 's|'{$DIR/$sub/feat/$phase/$model/glm/designFiles/}'||' | sed -e 's/.fsf//g'`

		# check if .feat already esists; if not - run the model
		if (-d $DIR/$sub/feat/$phase/$model/glm/$desName.gfeat) then
		else
			feat $desRun
		endif

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $2
		set examGfeat = $3

		# read designRun name off design file
		set desRun = $DIR/$sub/feat/$model/glm/designFiles/$examGfeat.fsf
			
		# grab name
		set desName = `echo $desRun | sed -e 's|'{$DIR/$sub/feat/$model/glm/designFiles/}'||' | sed -e 's/.fsf//g'`

		# check if .feat already esists; if not - run the model
		if (-d $DIR/$sub/feat/$model/glm/$desName.gfeat) then
		else
			feat $desRun
		endif

	endif # RAP

end # for each subject

## end