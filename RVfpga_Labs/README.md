# About
This course teaches you C and RISC-V assembly and I/O programming using the SweRVolf SoC, (actually renamed as [VeeRwolf](https://github.com/chipsalliance/VeeRwolf)). This SoC is implemented inside the [Nexys A7](https://digilent.com/reference/programmable-logic/nexys-a7/start) FPGA but it provide an emulator to work if the board isn't an option. The complete board solution is known as RVfpga

# Tools needed
Using Ubuntu22.04 you will need to download the [SoC source files and tools of RVfpga](https://cm.lf.training/LFD119x/) this folder is protected so try to use Username:LFtraining Password:Penguin2014. The bundle includes many tools with diferent propouses
## ViDBo
This tool permit to simulate the behaviour at real time of the board, in order to use it you will need to install the nex package
`sudo apt install lib-websockets-dev`
## Pipeline
This tool permit to visualize all the internal process of the CPU and look the values of inside the pipelines
`sudo apt install libcairo2-dev libgtk-3-dev`
## Trace
This tool give a waveform of the internal signal of the SoC
`sudo apt install gtkwave verilator`
## Whisper
No configuration is needed. This tool provides a debug enviroment.
## VS Code PlatformIO
First you need to install the following packages:
`sudo apt install python3-distutils python3-venv`
Then install VS Code (no need to explain) and then install the PlatformIO extension. Once the extension is ready go to Platforms>Embedded and dwonload CHIPSALLIANCE platform. This feature the firmware and compiler configuration so you wont need to worry about that.

# Workflow
Create a project in PlatformIO. then you will need to proportionate a script inside platformio.ini, usually this template works for any project:
>; PlatformIO Project Configuration File
>;
>;   Build options: build flags, source filter
>;   Upload options: custom upload port, speed and extra flags
>;   Library options: dependencies, extra library storages
>;   Advanced options: extra scripting
>;
>; Please visit documentation for the other options and examples
>; https://docs.platformio.org/page/projectconf.html
>
>[env:swervolf_nexys]
>platform = chipsalliance
>board = swervolf_nexys
>framework = wd-riscv-sdk
>
>monitor_speed = 115200
>
>debug_tool = whisper
>
>#RVfpga-Nexys
>#board_build.bitstream_file = /home/rvfpga/RVfpga/src/rvfpganexys.bit
>
>#RVfpga-ViDBo
>board_debug.verilator.binary = /home/rvfpga/RVfpga/Simulators/verilatorSIM_ViDBo/OriginalBinaries/RVfpga-ViDBo_Ubuntu22
>
>#RVfpga-Pipeline
>#board_debug.verilator.binary = /home/rvfpga/RVfpga/Simulators/verilatorSIM_Pipeline/OriginalBinaries/RVfpga-Pipeline_Ubuntu
>
>#RVfpga-Trace
>#board_debug.verilator.binary = /home/rvfpga/RVfpga/Simulators/verilatorSIM_Trace/OriginalBinaries/RVfpga-Trace_Ubuntu

# Chapters summary
## 01
This is the setup of tools and the enviroment previously mentioned
## 02
Teaches you use C language to interact with GPIO, UART and create basic programs to develop logic
## 03
Teaches you assembly language in RISC-V developing the same programs in chapter 02 but in assembly
## 04
Teaches you to use procedures, in C and assembly and what is the calling convention to perserve ABI
## 05
Teaches you to combine C and assembly to develop more complex solutions
## 06
Teaches you to I/O programming using GPIO, also you learn to use the same interface (GPIO) driver to add a new device (push buttons) to the board
## 07
Teaches	you to I/O programming using Seven Segment display, also you learn no change the device driver to avoid the decode phase and give total control to the developer
## 08
Teaches you to I/O programming using PTC timer, also you learn to add 3 new timers using the same interface to be able to use PWM to control a RGB LED colors
## 09
Teaches you Interrupt programming using the IRQ queue of the board
## 10
In process

*Note: The RVfpga_src folder have its own git with the tracking of every I/O modification. One branch for every driver
