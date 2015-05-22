#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./level1Design.csh <study> <example sub> <phase> <model> <example feat> 	#
# Ex:	 ./level1Design.csh MIG MIG-2722 P1 M2 P2M2R1_un005 						#
# p.clasen																			#
#####################################################################################

# Requires existing design.fsf for an exemplar subject/run
# Set up first model version via Feat_gui & d
# this script then uses the design.fsf file to apply to all runs, all subjects
# use the tag after "P2M2R1_" to designate uniqe set of design files

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

		# phase one copy and update 
		if ($phase == P1)

			foreach run (R1 R2)  # phase 1 has 2 runs

				# make unique design file for sub model run & this design 
				~/imaging/feat/lib/MIGlevel1.csh $DIR $sub $model $run $desName $examSub $examFeat

			end # for phase 1 


		else if ($phase == P2)
		endif 



	end
end


# end