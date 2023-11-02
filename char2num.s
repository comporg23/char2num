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
   mov  $1, %rdi               # file handle for stdout
   mov  $not_number, %rsi      # address of string to output
   mov  $44, %rdx              # number of bytes
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

 # first part of your task is:
 # now write a code which checks
 # if what was read from stdin
 # is in the range of 48-57 - i. e. it is a ascii character
 # which represents number
 # otherwise it prints an error
 # for example if you do
 # echo "+" | ./char2num
 # it should print
 # "not a number, pass digit character to stdin\n"
 # look i already defined a string in the beginning of the file.
 # and if you do
 # echo "a" | ./char2num
 # that also should result in the same error.
 # otherwise, in case you read the character which is a number
 # print to the console: "got number!". again, the string is there for you

 # so here should be your code for
 # if ch is in range 48..57 then
 #   writeln "not a number, pass digit character to stdin"
 # else
 #   writeln "got number!"
 # end if
 #
 # go on


 # now, lets try to output what was read from stdin

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

 # now, your second task:
 # see, below 42 is passed to printf.
 # that printf from the libc library.
 # it is a number constant: $42
 # but it will be printed
 # because printf is able to convert the number to string
 # and pass to write() kernel call.

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

