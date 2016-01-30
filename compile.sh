#!/bin/bash
#######################################################
# Mass Cross-Compile Shell Script, Darkerego 2016     #
# GPL. Do whatever, just be kind and give the credit! #
#######################################################
#
## Path of C file
cpath=coolProgram
## Target program name
program=coolProgram
## Path to toolchains - build your own or get them from somewhere like aboriginal or ulibc
toolchainPath="/home/$USER/cross/ulibc"
## Name of toolchains
toolchains="cross-compiler-armv4l cross-compiler-m68k cross-compiler-powerpc-440fp cross-compiler-armv5l cross-compiler-mips cross-compiler-sh4 cross-compiler-i586 cross-compiler-mipsel cross-compiler-sparc cross-compiler-i686 cross-compiler-powerpc cross-compiler-x86_64"
## A more exhaustive example toolchain list:
#toolchains="cross-compiler-armv4l cross-compiler-armv4tl cross-compiler-armv5l cross-compiler-armv6l cross-compiler-i486 cross-compiler-i586 cross-compiler-i686 cross-compiler-m68k cross-compiler-mips cross-compiler-mips64 cross-compiler-mipsel cross-compiler-powerpc cross-compiler-powerpc-440fp cross-compiler-sh2eb cross-compiler-sh2elf cross-compiler-sh4 cross-compiler-sparc cross-compiler-x86_64"
read -p "I will now remove the old binaries and compile the new, ok (y/n) ?" cleanupYN
if [ $cleanupYN == "y" ];
then
    rm bin/*
else
    echo "Abort." && exit 1
fi

for i in $toolchains
do

  target=$(echo $i | sed 's#.*-##')
  cfile=$cpath/"$program"-$target.c
  out="$(pwd)/bin"
  echo "C file location is $cfile, binary output is $out/$program-$target, Compiling $program for $target...!"
  sleep 0.25  

  export PATH=/usr/local/bin:/usr/bin:/bin:$toolchainPath/$i/bin
  "$target"-gcc $cfile -o $out/$program-$target && echo "$target compiled!" && file $out/$program-$target

done

exit 0
