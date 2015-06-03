#! /bin/csh -ef

#####################################################################################################
# generate second level design files																#
# Usage: ./makeL2design.csh <study> <example sub> <phase> <model> <L1 design> <L2 design>			#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES													#
# Ex:	 ./makeL2design.csh MIG MIG-2722 P1 M1 P1M1_STC_U005_NCR P1M1FE_C05							#
# Ex:	 ./makeL2design.csh RAP RAP-???? M1 M1_STC_U005_NCR M1FE_C05 								#
# p.clasen																							#
#####################################################################################################

# Requires existing design.fsf for an exemplar subject/run
	# Set up first model version via Feat_gui
# this script then uses the design.fsf file to apply to all runs, all subjects
# use the tag after "P2M2R1_" to designate unique set of design files

# set arguments
set DIR = ~/Documents/$1
set examSub = $2
set file = $DIR/doc/asublist_test.txt

foreach line ("`cat $file`")
		
	# set subject
	set sub = "$line"

	## RUN MIG level 1				
	if ($1 == MIG) then
		
		# set arguments
		set phase = $3
		set model = $4
		set examFeat = $5
		set examGfeat = $6

		# make the design files if the do not exist
		if (-d $DIR/$sub/feat/$phase/$model/$examFeat/designFiles/$examGfeat.fsf) then
			
			# do nothing

		else

			# phase 1 create design files
			if ($phase == P1) then

				# make unique design file for sub model run & this design, based on exemplar 
				~/imaging/feat/lib/MIGP1L1.csh $DIR $sub $model $examFeat $examSub $examGfeat

			endif # phase 1

			# phase 2 create design files
			if ($phase == P2) then

				# make unique design file for sub model run & this design, based on examplar
				~/imaging/feat/lib/MIGP2L1.csh $DIR $sub $model $examFeat $examSub $examGfeat 

			endif # for phase 2

		endif # if the design exists

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $3
		set examFeat = $4
		set examGfeat = $5

		# set name for design file repository & make repository
		set desName = `echo $examGfeat | sed -e 's/FE//'`

		# make the design files if the do not exist
		if (-d $DIR/$sub/feat/$model/$examFeat/designFiles/$examGfeat.fsf) then
			
			# do nothing

		else

			# make unique design file for sub model run & this design, based on exemplar 
			~/imaging/feat/lib/RAPL1.csh $DIR $sub $model $examFeat $examSub $examGfeat 
		
		endif # if the design exists

	endif # RAP

end # for each subject

## end