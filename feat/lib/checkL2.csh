#! /bin/csh -ef

#####################################################################################
# overwrite or subset run level 2 design making scripts (e.g., L2.csh)				#
# Usage: ./L2.csh <study> <phase> <model> <L1 design> <L2 design> 					#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./L1.csh MIG P1 M1 P1M1_STC_U005_NCR P1M1FE_C05 							#
# Ex:	 ./L1.csh RAP M1 M1_STC_U005_NCR P1M1FE_C05									#
# p.clasen																			#
#####################################################################################

# set arguments
set DIR = ~/Documents/$1
set study = $1
set file = $DIR/doc/asublist_test.txt

if ($1 == MIG) then

	# study specific 
	set phase = $2
	set model = $3
	set examFeat = $4
	set examGfeat = $5

	# design name and documentation file
	set docFile = $DIR/doc/L2Models/$examGfeat.txt
		
	if (-f $docFile) then
		set ans = ""
			
			while ($ans != "1" || $ans != "2")

				echo "WARNING: This model ($examGfeat) has been run on some or all subjects."
				echo "WARNING: Do you want to run the same model on a sub-set of subjects? (press 1)"
				echo "WARNING: Or, do you want to overwrite design files are re-run this model on the full list (press 2)?"
				
				set ans = $<

				if ($ans == "1") then

					set ready = ""

						while ($ready != "y")
							
							echo "NOTE: $examGfeat.gfeat must be manually deleted from the feat directory of subjects in the sub-set."
							echo "Ready to continue? (y)"

							set ready = $<

							if ($ready == "y") then

								echo "Running $examGfeat on sub-set of subjects."
								break

							else
							endif

						end # while
						break

				else if ($ans == "2") then

					set ready = ""

						while ($ready != "y")
							
							echo "WARNING: All $examGfeat models will be deleted."
							echo "WARNING: Are you sure? (y/n)"

							set ready = %<

							if ($ready == "y") then

								# clear docFile
								echo "" > $docFile
								echo "NOTE: $examGfeat model parameters are removed from documentation folder."

								foreach line ("`cat $file`")

									set $sub = "$line"

									# delete all model files
									echo "NOTE: You are deleting $examGfeat.gfeat from every subject's feat directory."
									rm -rf $DIR/$sub/feat/$phase/$model/$examFeat/$examGfeat.gfeat

								end # for each subject

								echo "Finished removing previous iteration of $examGfeat."
								echo "Running new $examGfeat on all subjects."
								break

							else if ($ready == "n")

								echo "No files deleted."
								break

							endif
							
						end # while

				endif
				break
	
			end # while
	endif

else if ($1 == RAP) then

	# study specific 
	set model = $2
	set examFeat = $3

	# design name and documentation file
	set docFile = $DIR/doc/L2Models/$examGfeat.txt

	if (-f $docFile) then
		set ans = ""
			
			while ($ans != "1" || $ans != "2")

				echo "WARNING: This model ($examGfeat) has been run on some or all subjects."
				echo "WARNING: Do you want to run the same model on a sub-set of subjects? (press 1)"
				echo "WARNING: Or, do you want to overwrite design files are re-run this model on the full list (press 2)?"
				
				set ans = $<

				if ($ans == "1") then

					set ready = ""

						while ($ready != "y")
							
							echo "NOTE: $examGfeat must be manually deleted from the feat directory of subjects in the sub-set."
							echo "Ready to continue? (y)"

							set ready = $<

							if ($ready == "y") then

								echo "Running $examGfeat on sub-set of subjects."
								break

							else
							endif

						end # while
						break

				else if ($ans == "2") then

					set ready = ""

						while ($ready != "y")
							
							echo "WARNING: All $examGfeat models will be deleted."
							echo "WARNING: Are you sure? (y/n)"

							set ready = %<

							if ($ready == "y") then

								# clear docFile
								echo "" > $docFile
								echo "NOTE: $examGfeat model parameters are removed from documentation folder."

								foreach line ("`cat $file`")

									set $sub = "$line"

									# delete all model files
									echo "NOTE: You are deleting $examGfeat.gfeat from every subject's feat directory."
									rm -rf $DIR/$sub/feat/$model/$examFeat/$examGfeat.gfeat

								end # for each subject
								
								echo "Finished removing previous iteration of $examGfeat."
								echo "Running new $examGfeat on all subjects."
								break

							else if ($ready == "n")

								echo "No files deleted."
								break

							endif
							
						end # while

				endif
				break
	
			end # while
	endif

endif


#end