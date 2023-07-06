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
  subl $40, %esp
  movl $1, %eax
  movl %eax, -4(%ebp)
.section .data
 ec54: .asciz  "Valor resultat matriu: "
.section .text
  movl $ec54, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  call _new_line
  addl $0, %esp
_e5:
  movl -4(%ebp), %eax
  movl $2, %ebx
  cmpl %ebx, %eax
  jg _e55
  jmp _e6
_e55:
  jmp _e7
_e6:
  movl $1, %eax
  movl %eax, -8(%ebp)
_e10:
  movl -8(%ebp), %eax
  movl $2, %ebx
  cmpl %ebx, %eax
  jg _e56
  jmp _e11
_e56:
  jmp _e12
_e11:
  movl -4(%ebp), %eax
  movl $2, %ebx
  imull %ebx, %eax
  movl %eax, -16(%ebp)
  movl -16(%ebp), %eax
  movl -8(%ebp), %ebx
  addl  %ebx, %eax
  movl %eax, -20(%ebp)
  movl -20(%ebp), %eax
  movl $3, %ebx
  subl %ebx, %eax
  movl %eax, -24(%ebp)
  movl -24(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -28(%ebp)
  movl -28(%ebp), %eax
  movl 12(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -32(%ebp)
  movl -32(%ebp), %eax
  movl %eax, -12(%ebp)
  leal -12(%ebp), %eax
  pushl %eax
  call _puti
  addl $4, %esp
.section .data
 ec57: .ascii  " "
.section .text
  movl $ec57, %eax
  pushl %eax
  call _putc
  addl $4, %esp
  movl -8(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -36(%ebp)
  movl -36(%ebp), %eax
  movl %eax, -8(%ebp)
  jmp _e10
_e12:
  call _new_line
  addl $0, %esp
  movl -4(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -40(%ebp)
  movl -40(%ebp), %eax
  movl %eax, -4(%ebp)
  jmp _e5
_e7:
  movl %ebp, %esp
  popl %ebp
  movl $DISP, %eax
  addl $8, %eax
  popl %eax
  ret
_e19:
  movl $DISP, %eax
  addl $8, %eax
  pushl (%eax)
  pushl %ebp
  movl %esp, %ebp
  movl %ebp, (%eax)
  subl $76, %esp
  movl $1, %eax
  movl %eax, -4(%ebp)
_e22:
  movl -4(%ebp), %eax
  movl $2, %ebx
  cmpl %ebx, %eax
  jg _e58
  jmp _e23
_e58:
  jmp _e24
_e23:
  movl $1, %eax
  movl %eax, -8(%ebp)
_e27:
  movl -8(%ebp), %eax
  movl $2, %ebx
  cmpl %ebx, %eax
  jg _e59
  jmp _e28
_e59:
  jmp _e29
_e28:
  movl -4(%ebp), %eax
  movl $2, %ebx
  imull %ebx, %eax
  movl %eax, -12(%ebp)
  movl -12(%ebp), %eax
  movl -8(%ebp), %ebx
  addl  %ebx, %eax
  movl %eax, -16(%ebp)
  movl -16(%ebp), %eax
  movl $3, %ebx
  subl %ebx, %eax
  movl %eax, -20(%ebp)
  movl -20(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -24(%ebp)
  movl -4(%ebp), %eax
  movl $2, %ebx
  imull %ebx, %eax
  movl %eax, -28(%ebp)
  movl -28(%ebp), %eax
  movl -8(%ebp), %ebx
  addl  %ebx, %eax
  movl %eax, -32(%ebp)
  movl -32(%ebp), %eax
  movl $3, %ebx
  subl %ebx, %eax
  movl %eax, -36(%ebp)
  movl -36(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -40(%ebp)
  movl -4(%ebp), %eax
  movl $2, %ebx
  imull %ebx, %eax
  movl %eax, -44(%ebp)
  movl -44(%ebp), %eax
  movl -8(%ebp), %ebx
  addl  %ebx, %eax
  movl %eax, -48(%ebp)
  movl -48(%ebp), %eax
  movl $3, %ebx
  subl %ebx, %eax
  movl %eax, -52(%ebp)
  movl -52(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -56(%ebp)
  movl -40(%ebp), %eax
  movl 12(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -60(%ebp)
  movl -56(%ebp), %eax
  movl 16(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -64(%ebp)
  movl -60(%ebp), %eax
  movl -64(%ebp), %ebx
  addl  %ebx, %eax
  movl %eax, -68(%ebp)
  movl -24(%ebp), %eax
  movl -68(%ebp), %ebx
  movl 12(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
  movl -8(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -72(%ebp)
  movl -72(%ebp), %eax
  movl %eax, -8(%ebp)
  jmp _e27
_e29:
  movl -4(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -76(%ebp)
  movl -76(%ebp), %eax
  movl %eax, -4(%ebp)
  jmp _e22
_e24:
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
  subl $84, %esp
  movl $1, %eax
  movl %eax, -36(%ebp)
_e38:
  movl -36(%ebp), %eax
  movl $2, %ebx
  cmpl %ebx, %eax
  jg _e60
  jmp _e39
_e60:
  jmp _e40
_e39:
  movl $1, %eax
  movl %eax, -40(%ebp)
_e43:
  movl -40(%ebp), %eax
  movl $2, %ebx
  cmpl %ebx, %eax
  jg _e61
  jmp _e44
_e61:
  jmp _e45
_e44:
.section .data
 ec62: .asciz  "Valor primera matriu: "
.section .text
  movl $ec62, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  leal -44(%ebp), %eax
  pushl %eax
  call _geti
  addl $4, %esp
  movl -36(%ebp), %eax
  movl $2, %ebx
  imull %ebx, %eax
  movl %eax, -48(%ebp)
  movl -48(%ebp), %eax
  movl -40(%ebp), %ebx
  addl  %ebx, %eax
  movl %eax, -52(%ebp)
  movl -52(%ebp), %eax
  movl $3, %ebx
  subl %ebx, %eax
  movl %eax, -56(%ebp)
  movl -56(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -60(%ebp)
  movl -60(%ebp), %eax
  movl -44(%ebp), %ebx
  leal -16(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
.section .data
 ec63: .asciz  "Valor de la segona matriu: "
.section .text
  movl $ec63, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  leal -44(%ebp), %eax
  pushl %eax
  call _geti
  addl $4, %esp
  movl -36(%ebp), %eax
  movl $2, %ebx
  imull %ebx, %eax
  movl %eax, -64(%ebp)
  movl -64(%ebp), %eax
  movl -40(%ebp), %ebx
  addl  %ebx, %eax
  movl %eax, -68(%ebp)
  movl -68(%ebp), %eax
  movl $3, %ebx
  subl %ebx, %eax
  movl %eax, -72(%ebp)
  movl -72(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -76(%ebp)
  movl -76(%ebp), %eax
  movl -44(%ebp), %ebx
  leal -32(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
  movl -40(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -80(%ebp)
  movl -80(%ebp), %eax
  movl %eax, -40(%ebp)
  jmp _e43
_e45:
  movl -36(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -84(%ebp)
  movl -84(%ebp), %eax
  movl %eax, -36(%ebp)
  jmp _e38
_e40:
  leal -32(%ebp), %eax
  pushl %eax
  leal -16(%ebp), %eax
  pushl %eax
  call _e19
  addl $8, %esp
  leal -16(%ebp), %eax
  pushl %eax
  call _e2
  addl $4, %esp
  movl %ebp, %esp
  popl %ebp
  movl $DISP, %eax
  addl $4, %eax
  popl %eax
  ret
