#! /bin/csh -ef

#################################################
# trim functionals								#
# Usage:	./trim.csh <study> <sub> <leadin>	#
# Note:  	specify leadin in seconds      		#
# Ex:		./trim.csh MIG MIG-2722 8			#
# p.clasen										#
#################################################


set DIR = ~/Documents/$1
set sub = $2
set leadin = `expr $3 / 2`

foreach i ($DIR/$sub/fun/*.nii.gz)
    # grab file name
    set run = `echo $i | awk -F'[.]' '{print $(NF-2)}'`

    # trim the leadin from time series
    set rawTRs = `fslinfo $i | awk '{if($1 == "dim4") print $2}'`
    set begin = $leadin
    set end = `expr $rawTRs - $leadin`
    fslroi $i $run\_trim.nii.gz $begin $end
end
    
# end