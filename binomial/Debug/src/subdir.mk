################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../src/binomial_asm.s 

C_SRCS += \
../src/binomial.c 

OBJS += \
./src/binomial.o \
./src/binomial_asm.o 

C_DEPS += \
./src/binomial.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: Arm C Compiler for Embedded 6'
	armclang.exe --target=aarch64-arm-none-eabi -mcpu=cortex-a53+nocrypto -O0 -g -MD -MP -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.s src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: Arm Assembler 6'
	armclang.exe --target=aarch64-arm-none-eabi -mcpu=cortex-a53+nocrypto -g -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


