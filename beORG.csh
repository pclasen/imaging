#! /bin/csh -ef

#########################################
# organize behavioral data              #
#										#
# Usage: ./beORG.csh					#
#########################################

set DIR = $STUDY_DIR # set this in environment (e.g., ~/Documents/MIG)
set file = $DIR/doc/SNI_files_copied.txt

foreach line ("`cat $file`")
	
	set sub = "$line"
	set be = $DIR/$sub/be

	if (-d $be/raw) then
	else
		mkdir $be/raw
		mv $be/*.mat $be/raw
		mv $be/*.txt $be/raw
	endif 

	if (-d $be/clean) then
	else
		mkdir $be/clean
		mkdir $be/clean/P1
		mkdir $be/clean/P2
		mkdir $be/clean/P3
	endif

	if (-d $be/onsets) then
	else 
		mkdir $be/onsets
		mkdir $be/onsets/P1
		mkdir $be/onsets/P2
	endif

end


# end