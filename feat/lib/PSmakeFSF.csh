#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./PSmakeFSF.csh <study> <example sub> <phase> <model>				 		#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./PSmakeFSF.csh MIG MIG-2722 P1 M1   										#
# Ex:	 ./PSmakeFSF.csh RAP RAP-???? M1 		 									#
# p.clasen																			#
#####################################################################################

# Requires existing design.fsf for an exemplar subject/run
	# Set up first model version via Feat_gui
# this script then uses the design.fsf file to apply to all runs, all subjects
# output is R?.fsf - does not create variable versions

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

		# make the design files if the do not exist
		if (-d $DIR/$sub/feat/$phase/$model/prestats/designFiles) then
			
			# do nothing

		else
			
			# make the design file folder
			mkdir -p $DIR/$sub/feat/$phase/$model/prestats/designFiles

		endif

		# phase 1 create design files
		if ($phase == P1) then

			foreach run (R1 R2)  # phase 1 has 2 runs

				# make unique design file for sub model run & this design, based on exemplar 
				~/imaging/feat/lib/PSmigP1.csh $DIR $sub $model $run $examSub

			end # for all runs

		endif # phase 1

		# phase 2 create design files
		if ($phase == P2) then

			foreach run (R1 R2 R3 R4 R5 R6 R7 R8) # phase 2 has 8 runs

				# make unique design file for sub model run & this design, based on examplar
				~/imaging/feat/lib/PSmigP2.csh $DIR $sub $model $run $examSub

			end # for all runs

		endif # for phase 2

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $3

		# make the design files if the do not exist
		if (-d $DIR/$sub/feat/$model/prestats/designFiles) then

			# do nothing

		else
			
			# make the design file folder
			mkdir -p $DIR/$sub/feat/$model/prestats/designFiles

		endif

		foreach run (R1 R2 R3 R4)  # 4 runs

			# make unique design file for sub model run & this design, based on exemplar 
			~/imaging/feat/lib/PSrap.csh $DIR $sub $model $run $examSub

		end # for each run

	endif # RAP

end # for each subject

## end