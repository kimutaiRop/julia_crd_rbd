# rbd and crd

this is a program made in julia which I already made in python
to get the python copy of the program check my github for the python program

this is a high performance program compared to the python

this program solves both the crd and rbd and draws the ANOVA table a the only ouput

## anova table example

                                    ANOVA TABLE
    ____________________________________________________________________________________________
    SOURCE OF V             SS                  d.f                 MSS                 F
    ______________________________________________________________________________________________
    Treatment               1878.125                 3                626.042             23.192
    Blocks                  619.875                 7                88.554             3.28
    Error                   566.875                21                26.994
    total                   3064.875                31                98.867


this table is copied from `atom hydrogen` execution of the program

## get and run program

you need to install julia v1.4 and above first from https://julialang.org I used v1.4 during development

to run the program clone the copy and navigate to the folder of the project in `terminal` or `cmd`

the run

    `julia rdb_crd.jl`

This program allows you to change btwn solving crd and rbd by simply changing the `prob` variable in
`main()`  function

for rbd `prob = 1` and for crd `prob = 1`
