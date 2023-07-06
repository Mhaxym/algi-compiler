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
  jmp _e2
_e2:
  movl $-1, %eax
  movl %eax, -12(%ebp)
  jmp _e4
_e3:
  movl $0, %eax
  movl %eax, -12(%ebp)
_e4:
  movl -12(%ebp), %eax
  movl %eax, -4(%ebp)
  movl $50, %eax
  movl %eax, -8(%ebp)
  movl -4(%ebp), %eax
  movl $-1, %ebx
  cmpl %ebx, %eax
  jne _e11
  jmp _e7
_e11:
  jmp _e9
_e9:
  movl -8(%ebp), %eax
  movl $10, %ebx
  cmp %ebx, %eax
  jge _e12
  jmp _e7
_e12:
  jmp _e8
_e7:
.section .data
 ec13: .asciz  "entram en primer"
.section .text
  movl $ec13, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  jmp _e10
_e8:
.section .data
 ec14: .asciz  "entram en segon"
.section .text
  movl $ec14, %eax
  pushl %eax
  call _puts
  addl $4, %esp
_e10:
  movl %ebp, %esp
  popl %ebp
  movl $DISP, %eax
  addl $4, %eax
  popl %eax
  ret
