#!/bin/bash

#gsc -:debug,search=../../../../../ -link main.scm 

gsc -c nq1.scm 

gsc -link nq1.c 

gcc     -Wno-unused -Wno-write-strings -Wdisabled-optimization -fwrapv -fno-strict-aliasing -fno-trapping-math -fno-math-errno -fschedule-insns2 -fomit-frame-pointer -fipa-ra -fmove-loop-invariants -march=x86-64 -fPIC -fno-common -mpc64    -Wno-unused -Wno-write-strings -Wdisabled-optimization -fwrapv -fno-strict-aliasing -fno-trapping-math -fno-math-errno -fschedule-insns2 -fomit-frame-pointer -fipa-ra -fmove-loop-invariants -march=x86-64 -fPIC -fno-common -mpc64   -rdynamic  -D___SINGLE_HOST -D___CAN_IMPORT_CLIB_DYNAMICALLY -D___CAN_IMPORT_SETJMP_DYNAMICALLY  -I"/usr/local/Gambit/include"  -o './nq1' 'nq1.c' 'nq1_.c' "/usr/local/Gambit/lib/libgambit.a" -lm libWSPlus2.a
