#! /bin/csh -ef

#####################################################################################
# overwrite or subset run prestats design making scripts 							#
# Usage: ./PScheck.csh <study> <phase> <model> <example feat> 						#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./PScheck.csh MIG P1 M1 								 					#
# Ex:	 ./PScheck.csh RAP M1 														#
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

	# design name and documentation file
	set desName = $phase$model
	set docFile = $DIR/doc/PS/$desName.txt
		
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

							set ready = %<

							if ($ready == "y") then

								# clear docFile
								echo "" > $docFile
								echo "NOTE: $desName model parameters are removed from documentation folder."

								foreach line ("`cat $file`")

									set $sub = "$line"

									# delete all model files
									echo "NOTE: You are deleting all prestats .feat directories from every subject's $phase $model prestats directory."
									rm -rf $DIR/$sub/feat/$phase/$model/prestats/*.feat

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
	
	# design name and documentation file
	set desName = $phase$model
	set docFile = $DIR/doc/PS/$desName.txt

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

							set ready = %<

							if ($ready == "y") then

								# clear docFile
								echo "" > $docFile
								echo "NOTE: $desName model parameters are removed from documentation folder."

								foreach line ("`cat $file`")

									set $sub = "$line"

									# delete all model files
									echo "NOTE: You are deleting all prestats .feat directories from every subject's $model prestats directory."
									rm -rf $DIR/$sub/feat/$model/prestats/*.feat

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