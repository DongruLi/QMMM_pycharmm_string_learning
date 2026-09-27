---
layout: default
title: Lesson 1.1. Generate CHARMM psf/pdb (CHARMM-GUI)
rank: 12
parent: "Lesson 1: Prepare the CM system"
---

Here we use 1COM as our research sample and generate CHARMM psf/pdb through CHARMM-GUI.

After download 1COM structure file from the Protein Data Bank (PDB), we input 1COM to CHARMM-GUI websit and generate psf/pdb files.

Specially, to cut the calculation pressure and simple the module process, we only conside one chain as our research bjectives and select protein A, protein B, protein C，HETA，water A, water B, and water C in "Model/Chain Selection Option".

Use CHARMM General Force Field to generate CHARMM top & par files.
Add Ions: NaCl

Force Field Options: CHARMM36

Input Generation Options: NAMD, CHARMM/OpenMM

Temperature: 298.15 K

After download .tgz package, we will use these files to generate initial coordinate files following the code in min.inp and preparation for string QM/MM simulation later.


