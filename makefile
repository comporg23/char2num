

all:
		as -o char2num.o char2num.s
		ld -o char2num char2num.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2
