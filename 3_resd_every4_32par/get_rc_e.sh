#!/bin/bash

#----the ith resd
i=5

#-----------energy
grep "ENER>" resd_${i}.out > e_${i}.out
awk '{print $3}' e_${i}.out > e_${i}.out2
mv e_${i}.out2 e_${i}.out

#----------rcc and rco
grep "Current dis" resd_${i}.out > r_${i}.out
awk '{print $16}' r_${i}.out > r_${i}.out2
mv r_${i}.out2 r_${i}.out
awk 'NR%2 == 0' r_${i}.out > rcc_${i}.out
echo " "|cat - r_${i}.out > r_${i}.out2
awk 'NR%2 == 0' r_${i}.out2 > rco_${i}.out
rm r_${i}.out2


#------------rc 
paste rco_${i}.out rcc_${i}.out | awk '{print $1-$2}' > rc_${i}.out

paste rc_${i}.out e_${i}.out > rc_e_${i}.out
