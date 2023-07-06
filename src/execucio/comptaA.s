.section .bss
.comm DISP, 100
.section .text
.global _e1
_e1:
  movl $DISP, %eax
  addl $4, %eax
  pushl (%eax)
  pushl %ebp
  movl %esp, %ebp
  movl %ebp, (%eax)
  subl $12, %esp
  movl $0, %eax
  movl %eax, -8(%ebp)
  leal -4(%ebp), %eax
  pushl %eax
  call _getc
  addl $4, %esp
  leal -4(%ebp), %eax
  pushl %eax
  call _putc
  addl $4, %esp
_e4:
  movl -4(%ebp), %eax
  movl $59, %ebx
  cmpl %ebx, %eax
  je _e11
  jmp _e5
_e11:
  jmp _e6
_e5:
  movl -4(%ebp), %eax
  movl $97, %ebx
  cmpl %ebx, %eax
  jne _e12
  jmp _e7
_e12:
  jmp _e8
_e7:
  movl -8(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -12(%ebp)
  movl -12(%ebp), %eax
  movl %eax, -8(%ebp)
_e8:
  leal -4(%ebp), %eax
  pushl %eax
  call _getc
  addl $4, %esp
  jmp _e4
_e6:
.section .data
 ec13: .asciz  "El nombre de A introduides es : "
.section .text
  movl $ec13, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  leal -8(%ebp), %eax
  pushl %eax
  call _puti
  addl $4, %esp
  call _new_line
  addl $0, %esp
  movl %ebp, %esp
  popl %ebp
  movl $DISP, %eax
  addl $4, %eax
  popl %eax
  ret
