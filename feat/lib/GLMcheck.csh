#! /bin/csh -ef

#####################################################################################
# overwrite or subset run level 1 design making scripts (e.g., L1.csh)				#
# Usage: ./GLMcheck.csh <study> <phase> <model> <example feat> 						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./GLMcheck.csh MIG P1 M1 R1_U05 						 					#
# Ex:	 ./GLMcheck.csh RAP M1 R1_U05 												#
# p.clasen																			#
#####################################################################################

# set arguments
set DIR = ~/Documents/$1
set study = $1
set file = $DIR/doc/asublist.txt

if ($1 == MIG) then

	# study specific 
	set phase = $2
	set model = $3
	set examFeat = $4

	# design name and documentation file
	set desStub = `echo $examFeat | sed -e 's/R1//'`
	set desName = $phase$model$desStub
	set docFile = $DIR/doc/GLMs/$desName.txt
		
	if (-f $docFile) then
		set ans = ""
			
			while ($ans != "1" || $ans != "2")

				echo "WARNING: This model ($desName) has been run on some or all subjects."
				echo "WARNING: Do you want to run the same model on a sub-set of subjects? (press 1)"
				echo "WARNING: Or, do you want to overwrite design files are re-run this model on the full list (press 2)?"
				
				set ans = $<

				if ($ans == "1") then

					set ready = ""

						while ($ready != "y")
							
							echo "NOTE: $desName must be manually deleted from the feat directory of subjects in the sub-set."
							echo "Ready to continue? (y)"

							set ready = $<

							if ($ready == "y") then

								echo "Running $desName on sub-set of subjects."
								break

							else
							endif

						end # while
						break

				else if ($ans == "2") then

					set ready = ""

						while ($ready != "y")
							
							echo "WARNING: All $desName models will be deleted."
							echo "WARNING: Are you sure? (y/n)"

							set ready = $<

							if ($ready == "y") then

								# clear docFile
								echo "" > $docFile
								echo "NOTE: $desName model parameters are removed from documentation folder."

								foreach line ("`cat $file`")

									set sub = "$line"

									# delete all model files
									echo "NOTE: You are deleting $examFeat from every subject's $phase $model glm directory."
									#if (-f $DIR/$sub/feat/$phase/model/glm/designFiles/$examFeat.fsf) then
									#	rm $DIR/$sub/feat/$phase/model/glm/designFiles/$examFeat.fsf
									#endif
									rm -rf $DIR/$sub/feat/$phase/$model/glm/$examFeat

								end # for each subject

								echo "Finished removing previous iteration of $desName."
								echo "Running new $desName on all subjects."
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
	set desStub = `echo $examFeat | sed -e 's/R1//'`
	set desName = $model$desStub
	set docFile = $DIR/doc/GLMs/$desName.txt
	
	if (-f $docFile) then
		set ans = ""
			
			while ($ans != "1" || $ans != "2")

				echo "WARNING: This model ($desName) has been run on some or all subjects."
				echo "WARNING: Do you want to run the same model on a sub-set of subjects? (press 1)"
				echo "WARNING: Or, do you want to overwrite design files are re-run this model on the full list (press 2)?"
				
				set ans = $<

				if ($ans == "1") then

					set ready = ""

						while ($ready != "y")
							
							echo "NOTE: $desName must be manually deleted from the feat directory of subjects in the sub-set."
							echo "Ready to continue? (y)"

							set ready = $<

							if ($ready == "y") then

								echo "Running $desName on sub-set of subjects."
								break

							else
							endif

						end # while
						break

				else if ($ans == "2") then

					set ready = ""

						while ($ready != "y")
							
							echo "WARNING: All $desName models will be deleted."
							echo "WARNING: Are you sure? (y/n)"

							set ready = $<

							if ($ready == "y") then

								# clear docFile
								echo "" > $docFile
								echo "NOTE: $desName model parameters are removed from documentation folder."

								foreach line ("`cat $file`")

									set $sub = "$line"

									# delete all model files
									echo "NOTE: You are deleting $examFeat from every subject's $model glm directory."
									rm -rf $DIR/$sub/feat/$model/glm/$examFeat

								end # for each subject
								
								echo "Finished removing previous iteration of $desName."
								echo "Running new $desName on all subjects."
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