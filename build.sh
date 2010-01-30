cd tests
gcc -O3 -m32 -c -o minimal.x86.32bit minimal.c
gcc -O3 -m64 -c -o minimal.x86.64bit minimal.c
gcc -O3 -m32 -arch ppc -c -o minimal.ppc.32bit minimal.c
gcc -O3 -m64 -arch ppc -c -o minimal.ppc.64bit minimal.c

cd ..
gcc -O3 -m32 -o run.x86.32bit run.c
gcc -O3 -m64 -o run.x86.64bit run.c
gcc -O3 -m32 -arch ppc -o run.ppc.32bit run.c
gcc -O3 -m64 -arch ppc -o run.ppc.64bit run.c
