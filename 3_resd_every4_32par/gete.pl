#!/usr/bin/perl
open (IN, "resd.out");

$id = 0;
$n = 0;
while(<IN>) {
   #if (/ENER\>\s+\d+\s+([\-|\+]?\d+\.\d+)/) {
   if (/ENER\>\s+\d+\s?([\-|\+]?\d+\.\d+)/) {
     $n ++;
     $ene[$n] = $1;
     $id = 0;
   }
   if (/Current distance=\s+([\-|\+]?\d+\.\d+)/) {
     $id++;
     $d[$id]=$1;
     if ($id == 2) {
        $r1[$n] = $d[1]-$d[2]; 
     }
   }

}
close (IN);

$min = $ene[1];
for $i (2 .. $n) {
   if ($ene[$i] < $min) { $min = $ene[$i] };
}
for $i (1 .. $n) {
   $ene[$i]=$ene[$i]-$min;
   print "$r1[$i]  $ene[$i]\n";
}



