# MIPS Processor Implementation

## Introduction

This project presents the implementation of a 32-bit single-cycle MIPS processor, designed using Verilog HDL. The MIPS (Microprocessor without Interlocked Pipeline Stages) architecture is a widely-used RISC (Reduced Instruction Set Computer) architecture known for its simplicity and efficiency. Our implementation focuses on a single-cycle design, where each instruction is executed in a single clock cycle.

The processor supports a subset of MIPS instructions, including arithmetic operations, logical operations, memory access instructions, and control flow instructions. It is a fundamental project for understanding how processors work at the microarchitecture level and serves as a basis for more advanced concepts in computer architecture.

## Features

- **Single-Cycle Design**: Executes each instruction in a single clock cycle.
- **Instruction Set**: Supports key MIPS instructions like `add`, `sub`, `and`, `or`, `slt`, `lw`, `sw`, `beq`, `j`, and others.
- **Modular Design**: The processor is designed in a modular fashion with distinct components like the ALU, register file, and control unit.
- **Verilog Implementation**: The processor is described using Verilog HDL, making it synthesizable for FPGA implementation.

## Architecture Overview

The MIPS processor is composed of several key components:

1. **Program Counter (PC)**: Holds the address of the current instruction.
2. **Instruction Memory**: Stores the instructions to be executed.
3. **Register File**: A set of registers used to store operands and results.
4. **ALU (Arithmetic Logic Unit)**: Performs arithmetic and logical operations.
5. **Data Memory**: Stores data that can be loaded and stored by the processor.
6. **Control Unit**: Generates control signals based on the opcode of the instruction.

The diagram below provides a high-level view of the MIPS processor architecture:

![MIPS Processor Architecture](mips_architecture.png)

*Note: Replace `mips_architecture.png` with the actual file name of your diagram image.*

## Project Structure

- **/src**: Contains the Verilog source files for each module of the processor.
- **/testbench**: Includes the testbenches used for simulation and verification of the processor.
- **/docs**: Documentation and diagrams related to the project.
- **README.md**: This file, providing an overview of the project.

## Simulation and Testing

The project includes a comprehensive testbench that simulates the execution of various MIPS instructions. The testbench covers different scenarios, ensuring the correct operation of arithmetic, logical, memory, and control flow instructions.

To run the simulation, use the following command in your Verilog simulation environment (e.g., ModelSim, Vivado):


