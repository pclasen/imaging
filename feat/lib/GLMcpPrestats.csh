#! /bin/csh -ef

#####################################################################################
# copy over pre-stats data for use in glm											#
# Usage: ./GLMcpPrestats.csh <study> <phase> <model> <example feat>				 	#
# NOTE:  VARIABLE ARGUMENTS FOR DIFFERENT STUDIES									#
# Ex:	 ./GLMcpPrestats.csh MIG P1 M1 R1_U05 		  								#
# Ex:	 ./GLMcpPrestats.csh RAP M1 R1_U05  										#
# p.clasen																			#
#####################################################################################

# requires that pre-stats models are in prestats directory and current
# hard coded to move R?.feat as current prestats folder

# set arguments
set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt

foreach line ("`cat $file`")
		
	# set subject
	set sub = "$line"

	## RUN MIG level 1				
	if ($1 == MIG) then
		
		# set arguments
		set phase = $2
		set model = $3
		set desStub = `echo $4 | sed -e 's/R1//'`
		set prestats = $DIR/$sub/feat/$phase/$model/prestats
		set glm = $DIR/$sub/feat/$phase/$model/glm

		# phase 1 copy
		if ($phase == P1) then

			foreach run (R1 R2)

				# copy prestats data to glm folder and rename
				if (-f $glm/$run$desStub.feat/design.fsf) then
				else
					cp -r $prestats/$run.feat $glm/$run$desStub.feat
					
					# remove prestats design data and html output from glm location copy
					rm $glm/$run$desStub.feat/design*
					rm $glm/$run$desStub.feat/*.html
				endif

			end # run
		
		endif # phase 1

		if ($phase == P2) then

			foreach run (R1 R2 R3 R4 R5 R6 R7 R8)

				# copy prestats data to glm folder and rename
				if (-f $glm/$run$desStub.feat/design.fsf) then
				else
					cp -r $prestats/$run.feat $glm/$run$desStub.feat
					
					# remove prestats design data and html output from glm location copy
					rm $glm/$run$desStub.feat/design*
					rm $glm/$run$desStub.feat/*.html
				endif

			end # run

		endif # phase 2

	endif # MIG

	## RUN RAP level 1				
	if ($1 == RAP) then
		
		# set arguments
		set model = $2
		set desStub = `echo $3 | sed -e 's/R1//'`
		set prestats = $DIR/$sub/feat/$model/prestats
		set glm = $DIR/$sub/feat/$model/glm

		foreach run (R1 R2 R3 R4)

			# copy prestats data to glm folder and rename
			if (-f $glm/$run$desStub.feat/design.fsf) then
			else
				cp -r $prestats/$run.feat $glm/$run$desStub.feat
				
				# remove prestats design data and html output from glm location copy
				rm $glm/$run$desStub.feat/design*
				rm $glm/$run$desStub.feat/*.html
			endif

		end # run
		

	endif # RAP

end # for each subject

## end