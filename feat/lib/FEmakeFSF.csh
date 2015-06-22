#! /bin/csh -ef

#####################################################################################################
# generate second level design files																#
# Usage: ./FEmakeFSF.csh <study> <example sub> <phase> <model> <L2 design>							#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES													#
# Ex:	 ./FEmakeFSF.csh MIG MIG-2722 P1 M1 FE_U05													#
# Ex:	 ./FEmakeFSF.csh RAP RAP-???? M1 FE_U05 													#
# p.clasen																							#
#####################################################################################################

# Requires existing design.fsf for an exemplar subject
	# Set up second level model version via Feat_gui
# this script then uses the design.fsf file to apply to all subjects
# use the tag after "FE_" to designate unique set of design files

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
		set examGfeat = $5

		# make the design files if the do not exist
		if (-d $DIR/$sub/feat/$phase/$model/glm/designFiles/$examGfeat.fsf) then
			
			# do nothing

		else

			# phase 1 create design files
			if ($phase == P1) then

				# make unique design file for sub model run & this design, based on exemplar 
				~/imaging/feat/lib/FEmigP1.csh $DIR $sub $model $examSub $examGfeat

			endif # phase 1

			# phase 2 create design files
			if ($phase == P2) then

				# make unique design file for sub model run & this design, based on examplar
				~/imaging/feat/lib/FEmigP2.csh $DIR $sub $model $examSub $examGfeat 

			endif # for phase 2

		endif # if the design exists

	endif # MIG

	## RUN RAP level 1
	if ($1 == RAP) then

		# set arguments
		set model = $3
		set examGfeat = $4

		# make the design files if the do not exist
		if (-d $DIR/$sub/feat/$model/glm/designFiles/$examGfeat.fsf) then
			
			# do nothing

		else

			# make unique design file for sub model run & this design, based on exemplar 
			~/imaging/feat/lib/FErap.csh $DIR $sub $model $examSub $examGfeat 
		
		endif # if the design exists

	endif # RAP

end # for each subject

## end