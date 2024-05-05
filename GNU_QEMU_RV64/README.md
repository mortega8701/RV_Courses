# About

This course teaches you about using GNU toolchain and QEMU enviroment to develop assembly RV64 programs.

# Tools needed
Using Ubuntu you need to install the following packages 
`sudo apt install qemu-system-misc qemu-user-static binfmt-support opensbi u-boot-qemu gcc-riscv64-linux-gnu gdb-multiarch`
Finally is neccesary to link a library to the global path, so you need to run
`sudo ln -s /usr/riscv64-linux-gnu/lib/ld-linux-riscv64-lp64d.so.1 /lib`

# Workflow
You access all the tools with the prefix "riscv64-linux-gnu-" for example to use the compiler you type "riscv64-linux-gnu-gcc". Works with all the related tools (as, ld, objdump, etc). When you compile (or more likely assembly your files) the executable is ran inside qemu using "qemu-riscv64-static".

For debugging you use qemu with flag -g and setting a port, for example 1234. Then with gdb try to connect using "target remote localhost:1234". Only global symbols are visibles for normal executables if you need more information pass -g flag to the compiler to turn visible inside objects and instructions

# Envirmoment
QEMU provides a whole Linux enviroment which includes the ability of run syscalls. When you want to use C functions like printf you need to name your global start point as "main", then when you assembly your code (as) you need to run the compiler (gcc) which has all the C libraries, it wont compile but link this functions and replace the symbols. Example:
`riscv64-linux-gnu-as djb2.s -o djb2.o`
`riscv64-linux-gnu-gcc djb2.o -o djb2`
`export QEMU_LD_PREFIX=/usr/riscv64-linux-gnu/`
`qemu-riscv64-static djb2`
