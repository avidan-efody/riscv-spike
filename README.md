# Intro

This repository bundles the RISC-V toolchain together with spike ISS into a docker image, and allows quick compilation/running of RISC-V C/assembley

# Examples

## Bare metal (i.e. no kernel or stdlib)

```
docker run -v $(pwd)/samples:/samples -ti avidane/riscv-spike "riscv64-unknown-elf-gcc -mabi=lp64 -march=rv64imc -nostdlib -o samples/test.exe samples/test.c samples/crt0.S -T samples/default.lds -mcmodel=medany"
docker run -v $(pwd)/samples:/samples -ti avidane/riscv-spike "/riscv-isa-sim/build/spike -l --isa=RV64IMC /samples/test.exe"
```

## Kernel + stdlib

```
docker run -v $(pwd)/samples:/samples -ti avidane/riscv-spike "riscv64-unknown-elf-gcc -B /usr/local/riscv64-unknown-elf/lib/rv64imafdc/lp64d/ -I/usr/local/riscv64-unknown-elf/include/ -o /samples/test-pk.exe samples/test-pk.c"
docker run -v $(pwd)/samples:/samples -ti avidane/riscv-spike "/riscv-isa-sim/build/spike /riscv-pk/build/pk /samples/test-pk.exe"
```

