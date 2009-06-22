gcc -O3 -m32 -o run.x86.32bit run.c
gcc -O3 -m64 -o run.x86.64bit run.c
gcc -O3 -m32 -arch ppc -o run.ppc.32bit run.c
gcc -O3 -m64 -arch ppc -o run.ppc.64bit run.c
