.global _start
_start:
  li a1,5
  li a4,5
  li a0,6
  add a2,a1,a0
  addi    sp,sp,-16
  add a2,a2,5
  addi    s0,sp,16
