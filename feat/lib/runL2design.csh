#! /bin/csh -ef

#####################################################################################
# run second level design files														#
# Usage: ./runL2design.csh <study> <phase> <model> <level1 design> <level2 design>	#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./runL2design.csh MIG P1 M1 P1M1_STC_U005_NCR P1M1FE_C05					#
# Ex:	 ./runL2design.csh RAP M1 M1_STC_U005_NCF P1M1FE_C05 						#
# p.clasen																			#
#####################################################################################

# Run level 2 feat for a particular model for each suject

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
		set examFeat = $4
		set examGfeat = $5

		# read designRun name off design file
		set desRun = $DIR/$sub/feat/$phase/$model/$examFeat/designFiles/$examGfeat.fsf
			
		# grab name
		set desName = `echo $desRun | sed -e 's|'{$DIR/$sub/feat/$phase/$model/$examFeat/designFiles/}'||' | sed -e 's/.fsf//g'`

		# check if .feat already esists; if not - run the model
		if (-d $DIR/$sub/feat/$phase/$model/$examFeat/$desName.gfeat) then
		else
			feat $desRun
		endif

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $2
		set examFeat = $3
		set examGfeat = $4

		# read designRun name off design file
		set desRun = $DIR/$sub/feat/$model/$examFeat/designFiles/$examGfeat.fsf
			
		# grab name
		set desName = `echo $desRun | sed -e 's|'{$DIR/$sub/feat/$model/$examFeat/designFiles/}'||' | sed -e 's/.fsf//g'`

		# check if .feat already esists; if not - run the model
		if (-d $DIR/$sub/feat/$model/$examFeat/$desName.gfeat) then
		else
			feat $desRun
		endif

	endif # RAP

end # for each subject

## end