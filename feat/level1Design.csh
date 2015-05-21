#! /bin/csh -ef

#####################################################################################
# generate first level design files													#
# Usage: ./level1Design.csh <study> <example sub> <phase> <model> <example.feat> 	#
# Ex:	 ./level1Design.csh MIG MIG-2722 P1 M2 P2M2R1_un005 						#
# p.clasen																			#
#####################################################################################

# Requires existing design.fsf for an exemplar subject/run
# Set up first model version via Feat_gui & d
# this script then uses the design.fsf file to apply to all runs, all subjects

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

		# copy and rename design.fsf from example subject 
		cp $DIR/$examSub/feat/$phase/$model/$examFeat/design.fsf $DIR/$sub/feat/designFiles/
		mv $DIR/$sub/feat/designFiles/design.fsf $DIR/$sub/feat/designFiles/$examFeat.fsf

		# phase one copy and update 
		if ($phase == P1)
			foreach i (1 2)  # phase 1 has 2 runs

				# name for new file
				set oldName = $DIR/$sub/feat/designFiles/$examFeat.fsf
				set newName = echo $DIR/$sub/feat/designFiles/$examFeat.fsf | sed -e 's/^R1/R$i/'

				# make it if it does not exist
				if (-f $newName) then
				else
					cp $oldName $newName

					# update contents of the new file 


				endif




		else if ($phase == P2)
		endif 



		foreach phase (P1 P2)
			
			foreach model (M1 M2)

				if ($phase == P1)

					foreach run (1 2)
						~/imaging/feat/lib/.MIGlevel1.csh $DIR $sub $phase $model $ver $run
					end

				else if ($phase == P2)

					foreach run (1 2 3 4 5 6 7 8)
						~/imaging/feat/lib/.MIGlevel1.csh $DIR $sub $phase $model $ver $run
					end

				endif
			end
		end
	end

## RUN RAP level 1
else if ($1 == RAP)
	foreach line ("`cat $file`")
		
		set sub = "$line"

		foreach run (1 2)
			~/imaging/feat/lib/.RAPlevel1.csh $DIR $sub $ver $run					
		end
	end
end	

# end