#!/bin/csh

#########################################
# create subject list				#
# Usage:	./vec_all.sch <run> 	#
# Ex:		./vec_all.csh R1		#
# p.clasen							#
#########################################

set DIR = ~/Documents/NRSA/gimme/data/1d_Timecourses_csv/$1\_out/betas
set file = $DIR/asublist.txt
set log = ~/Documents/NRSA/doc/junk.txt

# create master sublist for run, listing all .csv files
if (-f $file) then
else
	
	cd $DIR

	find . -type f -name "*.csv" | awk -F'/' '{print $2}' | awk -F'.' '{print $1}' > $file

endif


# vectorize each run for each participant

foreach line ("`cat $file`")

	set sub = "$line"
	set roi_num = 17
	set run = $1


	cd $DIR

	matlab -nodisplay -nojvm -nosplash -r "vector_gimmeContemp('$sub',$roi_num,'$run');exit;" > $log

end # for line

#end