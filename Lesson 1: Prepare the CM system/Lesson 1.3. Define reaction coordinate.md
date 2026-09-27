---
layout: default
title: "Lesson 1.3. Define reaction coordinate"
rank: 16
parent: "Lesson 1: Prepare the CM system"
---
Here, we use RESDISTANCE definated a reaction coordinate. 

**Code
```
bomblev -2
stream datadir.def
stream toppar.str
```

> Input files (from CHARMM-GUI and previous minimization)
```
set psf_file ../../charmm-gui-3767440248/step3_pbcsetup.psf
set crd_file ../../charmm-gui-3767440248/min.crd
```

> PBC box size (must match CHARMM-GUI)
```
set box_x 83.0
set box_y 83.0
set box_z 83.0
```
> Define reaction coordinate scan range
```
set rc_start -2.0
set rc_end    2.0
set rc_step   0.1
```

> Restraint strength
```
set k_rc 2000.0
```

> Minimization settings
```
set min_nstep 2000
set min_tolgrd 0.2
set min_nprint 2000
```

> Freeze region settings. Only allow residues within this radius (A) around a chosen atom to move.
```
set freeze_radius 10.0
```

> Output trajectory
```
set dcd_out resd_scan.dcd
```

> Read system topology (PSF) and coordinates (CRD)
```
open read form unit 1 name @psf_file
read psf card unit 1
close unit 1

open read form unit 1 name @crd_file
read coor card unit 1
close unit 1
```

> Periodic boundary conditions (PBC) and imaging
```
set 6 @box_x
set 7 @box_y
set 8 @box_z
```
> Define the crystal lattice type and geometry and build the crystal along with the images within the cutoff.
```
crystal define cubi @6 @7 @8 90.0 90.0 90.0
crystal build noper 0 cutoff 20.0
```

> Keep protein and ligand imaged by segment (stays together).
> Keep solvent and ions imaged by residue.
```
image byseg xcen 0.0 ycen 0.0 zcen 0.0 select segid PROA .or. segid PROB .or. segid PROC .or. segid HETA end
image byres xcen 0.0 ycen 0.0 zcen 0.0 select segid SOLV .or. segid WATA .or. segid WATB .or. segid WATC .or. segid IONS end
```
> Nonbonded interactions (PME + group-based cutoff)
```
update -
    elec group switch cdie eps 1.0 -
    ewald kappa 0.34 spline pmewald order 6 -
    fftx 90 ffty 90 fftz 90 -
    vdw vgroup vswitch -
    cutnb 14.0 ctofnb 13.0 ctonnb 12.0 -
    inbfrq 25 cutim 14.0 imgfrq 25 wmin 0.5
```

> Define QM region (ligand) and QM/MM method (AM1 here).
```
define qm sele segid HETA end
define solv sele segid SOLV .or. segid WATA .or. segid WATB .or. segid WATC .or. segid IONS end
```

> Use AM1 QM/MM here to generate an initial path.
```
mndo remo sele qm end glnk sele none end sele none end am1 char -2 switch
```

> Constrain X–H bonds outside the QM region (SHAKE)
```
shake bonh para tol 1.0e-6 sele all end  sele  (.not. qm .and. hydrogen) end
```

> Freeze most atoms, and only allow a local region near the ligand to relax.
> Here we keep residues within @freeze_radius Angstrom of the atom (HETA 223 O4) flexible, and freeze the rest.
```
cons fix sele .not. ( .byres. ( (segid HETA .and. resid 223 .and. type O4) .around. @freeze_radius ) ) end
```
> Reaction coordinate definition for RESDISTANCE
> rc = d(C1-C8) - d(C3-O4)
```
open write unform unit 31 name resd_0.dcd
trajectory iwrite 31 nwrite 1 nfile 65
set atom1 HETA 223 C1
set atom2 HETA 223 C8
set atom3 HETA 223 C3
set atom4 HETA 223 O4
```

> Run scan: for each rc value, perform constrained minimization.
```
set rc -2.0
set n 1
label loop
   skip none
   resdistance reset
   resdistance kval 2000.0 rval @rc -
   1.0 @atom1 @atom2 -1.0 @atom3 @atom4
   mini abnr nstep 2000 tolitr 2000 tolgrd 0.2 nprint 2000
   skip resd
   energy
   print resdistance
   trajectory write
   increase n by 1
   increase rc by 0.1
if rc le 2.0 goto loop

stop
```
After this scan, resd_scan.dcd contains a sequence of relaxed structures along the reaction coordinate.
In the next lesson, we will extract 21 frames from this trajectory and use them as the initial images for the string method.
