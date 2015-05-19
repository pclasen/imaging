#! /bin/csh -ef

#########################################
# Get onset times						#
# Usage: getOSTs.csh <study> <trim(s)>	#
# Ex: getOSTs.csh RAP 8					#
# p.clasen								#
#########################################

# define
set DIR = ~/Documents/$1
set trim = $2 
set file = $DIR/doc/SNI_files_copied.txt
set behave = $DIR/behavior

foreach line ("`cat $file`")

	set $sub = "$line"
	set be = $DIR/$sub/be
	set on = $be/onsets

	# phase 1
	if (-d $on/P1/M1) then
	else
		matlab -r -nodisplay -nojvm '$behave/MIG_P1_onsets_M1.m($sub,$trim)'
	endif

