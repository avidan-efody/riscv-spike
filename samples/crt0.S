.global _start
_start:
    .cfi_startproc
    .cfi_undefined ra

    la sp, _memory_end

    call main

    /* Spin after main() returns. */
1:
    j 1b
    .cfi_endproc
