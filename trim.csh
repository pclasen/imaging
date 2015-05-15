#! /bin/csh -ef

#########################################
# trim functionals	                #
#					#
# Usage: ./trim.csh <sub> <leadin>      #
# Note:  specify leadin in seconds      #
#########################################


set DIR = $STUDY_DIR # set this in environment (e.g., ~/Documents/MIG)
set sub = $1
set leadin = `expr $2 / 2`

foreach i ($DIR/$sub/fun/*.nii.gz)
    # grab file name
    set run = `echo $i | awk -F'[.]' '{print $(NF-2)}'`

    # trim the leadin from time series
    set rawTRs = `fslinfo $i | awk '{if($1 == "dim4") print $2}'`
    set begin = $leadin
    set end = `expr $rawTRs - $leadin`
    fslroi $i $run\_trim.nii.gz $begin $end
end
    
