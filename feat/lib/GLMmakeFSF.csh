#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./GLMmakeFSF.csh <study> <example sub> <phase> <model> <example feat> 		#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./GLMmakeFSF.csh MIG MIG-2722 P1 M1 R1_U05  								#
# Ex:	 ./GLMmakeFSF.csh RAP RAP-???? M1 R1_U05 									#
# p.clasen																			#
#####################################################################################

# Requires existing design.fsf for an exemplar subject/run
	# Set up first model version via Feat_gui
# this script then uses the design.fsf file to apply to all runs, all subjects
# use the tag after "P2M2R1_" to designate unique set of design files

# set arguments
set DIR = ~/Documents/$1
set examSub = $2
set file = $DIR/doc/asublist.txt

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
		# set desName = `echo $examFeat | sed -e 's/R1//'`


		# make the design files if the do not exist
		if (-d $DIR/$sub/feat/$phase/$model/glm/designFiles) then
			
			# do nothing

		else
			
			# make the design file folder
			mkdir -p $DIR/$sub/feat/$phase/$model/glm/designFiles

		endif

		# phase 1 create design files
		if ($phase == P1) then

			foreach run (R1 R2)  # phase 1 has 2 runs

				# make unique design file for sub model run & this design, based on exemplar 
				~/imaging/feat/lib/GLMmigP1.csh $DIR $sub $model $run $examSub $examFeat

			end # for all runs

		endif # phase 1

		# phase 2 create design files
		if ($phase == P2) then

			foreach run (R1 R2 R3 R4 R5 R6 R7 R8) # phase 2 has 8 runs

				# make unique design file for sub model run & this design, based on examplar
				~/imaging/feat/lib/GLMmigP2.csh $DIR $sub $model $run $examSub $examFeat

			end # for all runs

		endif # for phase 2

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $3
		set examFeat = $4

		# set name for design file repository & make repository
		# set desName = `echo $examFeat | sed -e 's/R1//'`

		# make the design files if the do not exist
		if (-d $DIR/$sub/feat/$model/glm/designFiles) then
			
			# do nothing

		else
			
			# make the design file folder
			mkdir -p $DIR/$sub/feat/$model/glm/designFiles

		endif

		foreach run (R1 R2 R3 R4)  # 4 runs
			
			# make unique design file for sub model run & this design, based on exemplar 
			~/imaging/feat/lib/GLMrap.csh $DIR $sub $model $run $examSub $examFeat

		end # for each run

	endif # RAP

end # for each subject

## end