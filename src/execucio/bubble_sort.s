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
  subl $104, %esp
  movl $0, %eax
  movl %eax, -12(%ebp)
  jmp _e5
_e5:
  movl $-1, %eax
  movl %eax, -16(%ebp)
  jmp _e7
_e6:
  movl $0, %eax
  movl %eax, -16(%ebp)
_e7:
  movl -16(%ebp), %eax
  movl %eax, -4(%ebp)
_e8:
  movl -4(%ebp), %eax
  movl $-1, %ebx
  cmpl %ebx, %eax
  jne _e48
  jmp _e9
_e48:
  jmp _e10
_e9:
  jmp _e12
_e11:
  movl $-1, %eax
  movl %eax, -20(%ebp)
  jmp _e13
_e12:
  movl $0, %eax
  movl %eax, -20(%ebp)
_e13:
  movl -20(%ebp), %eax
  movl %eax, -4(%ebp)
_e14:
  movl -12(%ebp), %eax
  movl $10, %ebx
  cmp %ebx, %eax
  jge _e49
  jmp _e15
_e49:
  jmp _e16
_e15:
  movl -12(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -24(%ebp)
  movl -24(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -28(%ebp)
  movl -28(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -32(%ebp)
  movl -12(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -36(%ebp)
  movl -36(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -40(%ebp)
  movl -32(%ebp), %eax
  movl 12(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -44(%ebp)
  movl -40(%ebp), %eax
  movl 12(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -48(%ebp)
  movl -44(%ebp), %eax
  movl -48(%ebp), %ebx
  cmp %ebx, %eax
  jge _e50
  jmp _e17
_e50:
  jmp _e18
_e17:
  jmp _e19
_e19:
  movl $-1, %eax
  movl %eax, -52(%ebp)
  jmp _e21
_e20:
  movl $0, %eax
  movl %eax, -52(%ebp)
_e21:
  movl -52(%ebp), %eax
  movl %eax, -4(%ebp)
  movl -12(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -56(%ebp)
  movl -56(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -60(%ebp)
  movl -60(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -64(%ebp)
  movl -64(%ebp), %eax
  movl 12(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -68(%ebp)
  movl -68(%ebp), %eax
  movl %eax, -8(%ebp)
  movl -12(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -72(%ebp)
  movl -72(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -76(%ebp)
  movl -76(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -80(%ebp)
  movl -12(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -84(%ebp)
  movl -84(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -88(%ebp)
  movl -88(%ebp), %eax
  movl 12(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -92(%ebp)
  movl -80(%ebp), %eax
  movl -92(%ebp), %ebx
  movl 12(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
  movl -12(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -96(%ebp)
  movl -96(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -100(%ebp)
  movl -100(%ebp), %eax
  movl -8(%ebp), %ebx
  movl 12(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
_e18:
  movl -12(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -104(%ebp)
  movl -104(%ebp), %eax
  movl %eax, -12(%ebp)
  jmp _e14
_e16:
  movl $0, %eax
  movl %eax, -12(%ebp)
  jmp _e8
_e10:
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
  subl $72, %esp
  movl $0, %eax
  movl %eax, -44(%ebp)
.section .data
 ec51: .asciz  "Introduiu els valors que voleu ordenar: "
.section .text
  movl $ec51, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  call _new_line
  addl $0, %esp
_e34:
  movl -44(%ebp), %eax
  movl $10, %ebx
  cmp %ebx, %eax
  jge _e52
  jmp _e35
_e52:
  jmp _e36
_e35:
  call _new_line
  addl $0, %esp
.section .data
 ec53: .asciz  " Valor : "
.section .text
  movl $ec53, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  leal -48(%ebp), %eax
  pushl %eax
  call _geti
  addl $4, %esp
  movl -44(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -52(%ebp)
  movl -52(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -56(%ebp)
  movl -56(%ebp), %eax
  movl -48(%ebp), %ebx
  leal -40(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
  movl -44(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -60(%ebp)
  movl -60(%ebp), %eax
  movl %eax, -44(%ebp)
  jmp _e34
_e36:
  leal -40(%ebp), %eax
  pushl %eax
  call _e2
  addl $4, %esp
  movl $0, %eax
  movl %eax, -44(%ebp)
.section .data
 ec54: .asciz  "Els valors ordenats son: "
.section .text
  movl $ec54, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  call _new_line
  addl $0, %esp
_e43:
  movl -44(%ebp), %eax
  movl $10, %ebx
  cmp %ebx, %eax
  jge _e55
  jmp _e44
_e55:
  jmp _e45
_e44:
.section .data
 ec56: .asciz  "  "
.section .text
  movl $ec56, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  movl -44(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -64(%ebp)
  movl -64(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -68(%ebp)
  leal -40(%ebp), %eax
  movl -68(%ebp), %ebx
  addl %ebx, %eax
  pushl %eax
  call _puti
  addl $4, %esp
  movl -44(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -72(%ebp)
  movl -72(%ebp), %eax
  movl %eax, -44(%ebp)
  jmp _e43
_e45:
  movl %ebp, %esp
  popl %ebp
  movl $DISP, %eax
  addl $4, %eax
  popl %eax
  ret
