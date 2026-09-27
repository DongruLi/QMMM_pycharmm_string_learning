---
layout: default
title: Table of Contents
rank: 2
---

## The toctree structure we use to organize our CM xTB/MM Tutorial

```
.
├── Introduction/
│   ├── CM background/
│   │   ├── What is chorismate mutase (CM)?
|   |   ├── Reaction mechanism: Claisen rearrangement
│   │   └── Importance of conformational gating (NRC → RC)
│   ├── QM/MM background/
│   │   ├── What is QM/MM?
│   │   ├── Why use xTB instead of DFT?
│   │   └── PyCHARMM workflow overview
├── Package installations/
│   ├── install pyCHARMM/
│   │   ├── with mndo97
│   │   └── with Gaussian
│   ├── install GPyTorch
│   └── install GPflow  
├── Examples/
│   ├── Lesson 1: Prepare the CM system/
│   │   ├── 1.1 Generate CHARMM files with CHARMM-GUI
│   │   ├── 1.2 Energy minimization
│   │   └── 1.3 Define reaction coordinates
│   │
├── Lesson 2: QM/MM methods/
│   │
│   ├── 2.1 GFN2-xTB/MM/
│   │   ├── 2.1.1 Choose the QM region
│   │   ├── 2.1.2 Connect PyCHARMM and xTB
│   │   └── 2.1.3 Run xTB/MM molecular dynamics
│   │
│   └── 2.2 AM1-GPRwDO/MM/
│       ├── 2.2.1 Introduction to AM1-GPRwDO/MM
│       ├── 2.2.2 Prepare training data
│       ├── 2.2.3 Train the GPRwDO model
│       └── 2.2.4 Run AM1-GPRwDO/MM molecular dynamics
│   │
├──  Lesson 3: Sampling Methods/
│   │
│   ├── 3.1 String Method/
│   │   ├── 3.1.1 Understand the string method
│   │   ├── 3.1.2 Build the initial reaction path
│   │   ├── 3.1.3 Run and update the string
│   │   └── 3.1.4 Obtain the chemical free-energy profile
│   │
│   └── 3.2 Umbrella Sampling and WHAM/
│       ├── 3.2.1 Define the conformational coordinate
│       ├── 3.2.2 Set up umbrella sampling windows
│       ├── 3.2.3 Run umbrella sampling
│       └── 3.2.4 Calculate the free-energy profile with WHAM
│
├── References/
├── Links/
└── Glossary/




```
