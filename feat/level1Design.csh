#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./level1Design.csh <study> <example sub> <phase> <model> <example feat> 	#
# Ex:	 ./level1Design.csh MIG MIG-2722 P1 M2 P2M2R1_un005 						#
# p.clasen																			#
#####################################################################################

# Requires existing design.fsf for an exemplar subject/run
	# Set up first model version via Feat_gui
# this script then uses the design.fsf file to apply to all runs, all subjects
# use the tag after "P2M2R1_" to designate unique set of design files

# set arguments
set DIR = ~/Documents/$1
set examSub = $2
set phase = $3
set model = $4
set examFeat = $5
set file = $DIR/doc/asublist.txt

## RUN MIG level 1
if ($1 == MIG)

	foreach line ("`cat $file`")
		
		# set subject
		set sub = "$line"

		# set name for design file repository & make repository
		set desName = echo $examFeat | sed -e 's/^R1//'
		if (-d $DIR/$sub/feat/designFiles/$desName)
		else
			mkdir $DIR/$sub/feat/designFiles/$desName
		endif

		# phase 1 create design files
		if ($phase == P1)

			foreach run (R1 R2)  # phase 1 has 2 runs

				# make unique design file for sub model run & this design, based on exemplar 
				~/imaging/feat/lib/MIGP1level1.csh $DIR $sub $model $run $desName $examSub $examFeat

			end # for runs
		end # phase 1

		# phase 2 create design files
		if ($phase == P2)

			forech run (R1 R2 R3 R4 R5 R6 R7 R8) # phase 2 has 8 runs

			# make unique design file for sub model run & this design, based on examplar
			~/imaging/feat/lib/MIGP2level1.csh $DIR $sub $model $run $desName $examSub $examFeat

		endif # for phase 2

	end # for each subject in MIG

else if ($1 == RAP)

	foreach line ("`cat $file`")
		
		# set subject
		set sub = "$line"

		# set name for design file repository & make repository
		set desName = echo $examFeat | sed -e 's/^R1//'
		if (-d $DIR/$sub/feat/designFiles/$desName)
		else
			mkdir $DIR/$sub/feat/designFiles/$desName
		endif

		foreach run (R1 R2 R3 R4)  # 4 runs

			# make unique design file for sub model run & this design, based on exemplar 
			~/imaging/feat/lib/RAPlevel1.csh $DIR $sub $model $run $desName $examSub $examFeat

		end # for each run

	end # for each subject in RAP

end # if MIG/RAP

# end