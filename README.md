# arm_01
Learn ARM assembly language (with cross compiler).

* [ARM assembly language](https://youtu.be/FV6P5eRmMh8)
* [Emulating ARM with QEMU on Debian/Ubuntu](https://gist.github.com/luk6xff/9f8d2520530a823944355e59343eadc1)
* [ARM System Call Table](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#arm-32_bit_EABI)

> Google 'arm 32 system call table', then select 'arm (32-bit/EABI)'.
## 1. Installation

```sh
$ uname -p
x86_64
$ uname -a
Linux GEO-WCND1383YRS 5.10.102.1-microsoft-standard-WSL2 #1 SMP Wed Mar 2 00:30:59 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

$ sudo apt-get -y install gcc-arm*
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Note, selecting 'gcc-arm-none-eabi-source' for glob 'gcc-arm*'
Note, selecting 'gcc-arm-linux-gnueabihf' for glob 'gcc-arm*'
Note, selecting 'gcc-arm-none-eabi' for glob 'gcc-arm*'
Note, selecting 'gcc-arm-linux-gnueabi' for glob 'gcc-arm*'
The following packages were automatically installed and are no longer required:
  bridge-utils python3-cliapp python3-markdown python3-packaging python3-pyparsing python3-ttystatus ubuntu-fan
Use 'sudo apt autoremove' to remove them.
The following additional packages will be installed:
  binutils-arm-linux-gnueabi binutils-arm-linux-gnueabihf binutils-arm-none-eabi cpp-9-arm-linux-gnueabi
  cpp-9-arm-linux-gnueabihf cpp-arm-linux-gnueabi cpp-arm-linux-gnueabihf gcc-10-cross-base
  ...


```

## 2. Compilation
```sh
# Compile to object codes
$ arm-linux-gnueabi-as 001.asm -o 001.o
$ file 001.o
001.o: ELF 32-bit LSB relocatable, ARM, EABI5 version 1 (SYSV), not stripped

# Linker
$ arm-linux-gnueabi-gcc-9 001.o -o 001.elf
/usr/lib/gcc-cross/arm-linux-gnueabi/9/../../../../arm-linux-gnueabi/bin/ld: 001.o: in function `_start':
(.text+0x0): multiple definition of `_start'; /usr/lib/gcc-cross/arm-linux-gnueabi/9/../../../../arm-linux-gnueabi/lib/../lib/crt1.o:(.text+0x0): first defined here
/usr/lib/gcc-cross/arm-linux-gnueabi/9/../../../../arm-linux-gnueabi/bin/ld: /usr/lib/gcc-cross/arm-linux-gnueabi/9/../../../../arm-linux-gnueabi/lib/../lib/crt1.o: in function `_start':
(.text+0x34): undefined reference to `main'
collect2: error: ld returned 1 exit status'

# Issue: automatically linked with libc and the _start was redefined
$ arm-linux-gnueabi-gcc-9 001.o -o 001.elf -nostdlib
$ file 001.elf
001.elf: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, BuildID[sha1]=f87b884f2a0392e29aa93715cd8981bb304866e1, not stripped
```

### Execution
```sh
$ sudo apt-get -y install qemu
$ sudo apt-get install qemu-system-arm
$ sudo apt install qemu-user-static
$ ./001.elf 
qemu: uncaught target signal 4 (Illegal instruction) - core dumped
Illegal instruction

$ arm-linux-gnueabi-as 002.asm -o 002.o
$ arm-linux-gnueabi-gcc-9 002.o -o 002.elf -nostdlib
$ ./002.elf
$ echo $?
13

$ arm-linux-gnueabi-as 003.asm -o 003.o
$ arm-linux-gnueabi-gcc-9 003.o -o 003.elf -nostdlib
$ ./003.elf 
Hello, World

$ arm-linux-gnueabi-as 004.asm -o 004.o
$ arm-linux-gnueabi-gcc-9 004.o -o 004.elf -nostdlib
$ ./004.elf 
Hello, World
$ echo $?
65
```

## Linux System Call Table
arm (32-bit/EABI)
Compiled from Linux 4.14.0 headers.

|NR	|syscall |name	|references	|%r7	|arg0 (%r0)	|arg1 (%r1)	|arg2 (%r2)	|arg3 (%r3)	|arg4 (%r4)	|arg5 (%r5)|
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
|0	|restart_syscall	|man/ cs/	|0x00|	-|	-|	-|	-|	-|	-|
|1	|exit	|man/ cs/	|0x01|	int error_code|	-|	-|	-|	-|	-|
|2	|fork	|man/ cs/	|0x02|	-|	-|	-|	-|	-|	-|
|3	|read	|man/ cs/	|0x03|	unsigned int fd	|char *buf	|size_t count|	-|	-|	-|
|4	|write	|man/ cs/	|0x04|	unsigned int fd	|const char *buf	|size_t count|