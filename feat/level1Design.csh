#! /bin/csh -ef

#####################################
# generate first level design files	#
# Usage: ./level1Design.csh <study> #
# Ex:	 ./level1Design.csh MIG 	#
# p.clasen							#
#####################################


set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt

if ($1 == MIG)
	foreach line ("`cat $file`")
		
		set sub = "$line"

		foreach phase (P1 P2)
			foreach model (M1 M2)

				if ($phase == P1)

					foreach run (1 2)
						~/imaging/feat/lib/.MIGlevel1.csh $DIR $sub $phase $model $run
					end

				else if ($phase == P2)

					foreach run (1 2 3 4 5 6 7 8)
						~/imaging/feat/lib/.MIGlevel1.csh $DIR $sub $phase $model $run
					end

				endif
			end
		end
	end

else if ($1 == RAP)
	foreach line ("`cat $file`")
		
		set sub = "$line"

		foreach run (1 2)
			~/imaging/feat/lib/.RAPlevel1.csh $DIR $sub $run					
		end
	end
end	

# end