#! /bin/csh -ef

#############################################
# Get onset times							#
# Usage: MIG_fix_P2_onsets_shell.csh <study>#
# Ex: getOSTs.csh MIG	 					#
# p.clasen									#
#############################################

# define
set DIR = ~/Documents/MIG
set file = $DIR/doc/asublist_fixonsets.txt
set log = $DIR/doc/junk.txt


foreach line ("`cat $file`")

	set sub = "$line"
	set be = $DIR/$sub/be
	set clean = $be/clean

	cd $clean
	matlab -nodisplay -nojvm -nosplash -r "MIG_fix_P2_onsets('$sub');exit;" > $log

end # for loop

cd ~



# end