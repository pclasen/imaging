#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./makeL1design.csh <study> <example sub> <phase> <model> <example feat> 	#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./makeL1design.csh MIG MIG-2722 P1 M1 P2M1R1_un005 						#
# Ex:	 ./makeL1design.csh RAP RAP-???? M1 M1R1_un005 								#
# p.clasen																			#
#####################################################################################

# Requires existing design.fsf for an exemplar subject/run
	# Set up first model version via Feat_gui
# this script then uses the design.fsf file to apply to all runs, all subjects
# use the tag after "P2M2R1_" to designate unique set of design files

# set arguments
set DIR = ~/Documents/$1
set examSub = $2
set file = $DIR/doc/asublist_test.txt ###### CHANGE BACK AFTER DEBUGGING

foreach line ("`cat $file`")
		
	# set subject
	set sub = "$line"

	## RUN MIG level 1				
	if ($1 == MIG) then
		
		# set arguments
		set phase = $3
		set model = $4
		set examFeat = $5

		# set name for design file repository & make repository
		set desName = `echo $examFeat | sed -e 's/R1//'`

		## MIG design files: 	../MIG/$sub/feat/$phase/$model/designFiles/$design/$designRun.fsf
		## MIG feat: 			../MIG/$sub/feat/$phase/$model/$design/$designRun.feat

		# write ./feat/$phase/$modle/designFiles/designName (if not already exist)
		if (-d $DIR/$sub/feat/$phase/$model/$desName/designFiles) then
			echo "ERROR: Design already exists, choses a different name or see existing output."
			exit 1
		else
			mkdir -p $DIR/$sub/feat/$phase/$model/$desName/designFiles
		endif

		# phase 1 create design files
		if ($phase == P1) then

			foreach run (R1 R2)  # phase 1 has 2 runs

				# make unique design file for sub model run & this design, based on exemplar 
				~/imaging/feat/lib/MIGP1L1.csh $DIR $sub $model $run $desName $examSub $examFeat

			end # for all runs

		endif # phase 1

		# phase 2 create design files
		if ($phase == P2) then

			foreach run (R1 R2 R3 R4 R5 R6 R7 R8) # phase 2 has 8 runs

			# make unique design file for sub model run & this design, based on examplar
			~/imaging/feat/lib/MIGP2L1.csh $DIR $sub $model $run $desName $examSub $examFeat

			end # for all runs

		endif # for phase 2

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $3
		set examFeat = $4

		# set name for design file repository & make repository
		set desName = `echo $examFeat | sed -e 's/R1//'`

		## MIG design files: 	../MIG/$sub/feat/$model/designFiles/$design/$designRun.fsf
		## MIG feat: 			../MIG/$sub/feat/$model/$design/$designRun.feat

		# write ./feat/$phase/$modle/designFiles/designName (if not already exist)
		if (-d $DIR/$sub/feat/$model/designFiles/$desName) then
		else
			mkdir -p $DIR/$sub/feat/$model/designFiles/$desName
		endif

		foreach run (R1 R2 R3 R4)  # 4 runs

			# make unique design file for sub model run & this design, based on exemplar 
			~/imaging/feat/lib/RAPL1.csh $DIR $sub $model $run $desName $examSub $examFeat

		end # for each run

	endif # RAP

end # for each subject

## end