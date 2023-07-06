.section .bss
.comm DISP, 100
.section .text
.global _e1
_e2:
  movl $DISP, %eax
  addl $8, %eax
  pushl (%eax)
  pushl %ebp
  movl %esp, %ebp
  movl %ebp, (%eax)
  subl $12, %esp
  movl 12(%ebp), %esi
  movl (%esi), %eax
  movl $1, %ebx
  cmpl %ebx, %eax
  jg _e10
  jmp _e3
_e10:
  jmp _e4
_e3:
  movl $1, %eax
  movl 16(%ebp), %edi
  movl %eax, (%edi)
  jmp _e7
_e4:
  movl 12(%ebp), %esi
  movl (%esi), %eax
  movl $1, %ebx
  subl %ebx, %eax
  movl %eax, -8(%ebp)
  leal -4(%ebp), %eax
  pushl %eax
  leal -8(%ebp), %eax
  pushl %eax
  call _e2
  addl $8, %esp
  movl 12(%ebp), %esi
  movl (%esi), %eax
  movl -4(%ebp), %ebx
  imull %ebx, %eax
  movl %eax, -12(%ebp)
  movl -12(%ebp), %eax
  movl 16(%ebp), %edi
  movl %eax, (%edi)
_e7:
  movl %ebp, %esp
  popl %ebp
  movl $DISP, %eax
  addl $8, %eax
  popl %eax
  ret
_e1:
  movl $DISP, %eax
  addl $4, %eax
  pushl (%eax)
  pushl %ebp
  movl %esp, %ebp
  movl %ebp, (%eax)
  subl $8, %esp
  call _new_line
  addl $0, %esp
.section .data
 ec11: .asciz  "Introdueix un nombre:"
.section .text
  movl $ec11, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  leal -8(%ebp), %eax
  pushl %eax
  call _geti
  addl $4, %esp
  leal -4(%ebp), %eax
  pushl %eax
  leal -8(%ebp), %eax
  pushl %eax
  call _e2
  addl $8, %esp
  call _new_line
  addl $0, %esp
.section .data
 ec12: .asciz  "Resultat :"
.section .text
  movl $ec12, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  leal -8(%ebp), %eax
  pushl %eax
  call _puti
  addl $4, %esp
.section .data
 ec13: .asciz  "! = "
.section .text
  movl $ec13, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  leal -4(%ebp), %eax
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
