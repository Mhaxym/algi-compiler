@echo off
del %1.c3a >nul
del %1.txt >nul
del missatges_error.log >nul
del %1.s >nul
del %1.exe >nul
algi.exe %1.algi >&2
gcc -c stdio.s >nul
gcc -c %1.s >nul
ld -o %1.exe -e _e1 %1.o  stdio.o C:\GNAT\2015\lib\gcc\i686-pc-mingw32\4.9.3\*.a >nul
