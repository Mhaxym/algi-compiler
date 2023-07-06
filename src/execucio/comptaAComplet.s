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
  subl $24, %esp
  movl $120, %eax
  movl $0, %ebx
  movl 12(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
 movl $DISP, %esi
 movl 4(%esi), %esi
 leal -4(%esi), %eax
  pushl %eax
  call _getc
  addl $4, %esp
_e5:
  movl $DISP, %esi
  movl 4(%esi), %esi
  movl -4(%esi), %eax
  movl $32, %ebx
  cmpl %ebx, %eax
  je _e31
  jmp _e8
_e31:
  jmp _e7
_e8:
  movl $DISP, %esi
  movl 4(%esi), %esi
  movl -4(%esi), %eax
  movl $59, %ebx
  cmpl %ebx, %eax
  je _e32
  jmp _e6
_e32:
  jmp _e7
_e6:
  movl $120, %eax
  movl 12(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -4(%ebp)
  movl -4(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -8(%ebp)
  movl -8(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -12(%ebp)
  movl -12(%ebp), %eax
  movl $20, %ebx
  addl  %ebx, %eax
  movl %eax, -16(%ebp)
  movl -16(%ebp), %eax
  movl $DISP, %esi
  movl 4(%esi), %esi
  movl -4(%esi), %ebx
  movl 12(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
  movl $120, %eax
  movl 12(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -20(%ebp)
  movl -20(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -24(%ebp)
  movl $120, %eax
  movl -24(%ebp), %ebx
  movl 12(%ebp), %edi
  addl %eax, %edi
  movl %ebx, (%edi)
 movl $DISP, %esi
 movl 4(%esi), %esi
 leal -4(%esi), %eax
  pushl %eax
  call _getc
  addl $4, %esp
  jmp _e5
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
  subl $164, %esp
  movl $0, %eax
  movl %eax, -132(%ebp)
  movl $32, %eax
  movl %eax, -4(%ebp)
.section .data
 ec33: .asciz  "Introduiu una frase acabada en ';': "
.section .text
  movl $ec33, %eax
  pushl %eax
  call _puts
  addl $4, %esp
_e17:
  movl -4(%ebp), %eax
  movl $59, %ebx
  cmpl %ebx, %eax
  je _e34
  jmp _e18
_e34:
  jmp _e19
_e18:
  leal -128(%ebp), %eax
  pushl %eax
  call _e2
  addl $4, %esp
  movl $0, %eax
  movl %eax, -136(%ebp)
_e22:
  movl $120, %eax
  leal -128(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -140(%ebp)
  movl -136(%ebp), %eax
  movl -140(%ebp), %ebx
  cmp %ebx, %eax
  jge _e35
  jmp _e23
_e35:
  jmp _e24
_e23:
  movl -136(%ebp), %eax
  movl $0, %ebx
  subl %ebx, %eax
  movl %eax, -144(%ebp)
  movl -144(%ebp), %eax
  movl $4, %ebx
  imull %ebx, %eax
  movl %eax, -148(%ebp)
  movl -148(%ebp), %eax
  movl $20, %ebx
  addl  %ebx, %eax
  movl %eax, -152(%ebp)
  movl -152(%ebp), %eax
  leal -128(%ebp), %esi
  addl %eax, %esi
  movl (%esi), %eax
  movl %eax, -156(%ebp)
  movl -156(%ebp), %eax
  movl $97, %ebx
  cmpl %ebx, %eax
  jne _e36
  jmp _e25
_e36:
  jmp _e26
_e25:
  movl -132(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -160(%ebp)
  movl -160(%ebp), %eax
  movl %eax, -132(%ebp)
_e26:
  movl -136(%ebp), %eax
  movl $1, %ebx
  addl  %ebx, %eax
  movl %eax, -164(%ebp)
  movl -164(%ebp), %eax
  movl %eax, -136(%ebp)
  jmp _e22
_e24:
  jmp _e17
_e19:
.section .data
 ec37: .asciz  "El nombre de As a la frase es: "
.section .text
  movl $ec37, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  leal -132(%ebp), %eax
  pushl %eax
  call _puti
  addl $4, %esp
  call _new_line
  addl $0, %esp
.section .data
 ec38: .asciz  "Final del programa."
.section .text
  movl $ec38, %eax
  pushl %eax
  call _puts
  addl $4, %esp
  call _new_line
  addl $0, %esp
  movl %ebp, %esp
  popl %ebp
  movl $DISP, %eax
  addl $4, %eax
  popl %eax
  ret
