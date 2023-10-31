.section .bss
.comm arr, 1
.section .rodata
fmt:
   .asciz "%d\n"
eol:
   .asciz "\n"
not_number:
   .asciz "not a number, pass digit character to stdin\n"
number:
   .asciz "got number!\n"

.section .text

err0:
   mov $1, %rax                # system call for write
   mov  $1, %rdi                # file handle for stdout
   mov  $not_number, %rsi                # address of string to output
   mov  $44, %rdx                # number of bytes
   syscall
   jmp exit


.globl _start
_start:
# read one byte
  mov $0, %rax   # number of read syscall
  mov $0, %rdi   # where to read from (stdin)
  mov $arr, %rsi # string address to write to
  mov $1, %rdx   # how many bytes to read
  syscall

  xor %rax, %rax
  movb (arr), %al  # %al is 8bit part of %rax
  cmpb $48, %al    # this code checks if what was read from stdin
  jl err0          # is in the range of 48-57 - i. e. it is a ascii character
  cmpb $57, %al    # which represents number
  jg err0          # otherwise it prints an error
                   # do echo "+" | ./char2num
                   # or
                   # echo "a" | ./char2num
                   # to see
# write what have been read
   mov $1, %rax                # system call for write
   mov  $1, %rdi                # file handle for stdout
   mov  $arr, %rsi                # address of string to output
   mov  $1, %rdx                # number of bytes
   syscall

# write eol
   mov $1, %rax                # system call for write
   mov  $1, %rdi                # file handle for stdout
   mov  $eol, %rsi                # address of string to output
   mov  $1, %rdx                # number of bytes
   syscall

 # now, 42 is passed to printf. and will be printed
 # you need to convert the character you have got from the standard input
 # to number: to integer value.
 # move that number to %rsi instead of $42 and
 # it'll be picked up by printf function
 # and written to standard output.
 mov  $42, %rsi
 mov $fmt, %rdi
 xor %rax, %rax
 call printf

exit:
 mov $60, %rax
 xor %rdi, %rdi
 syscall

