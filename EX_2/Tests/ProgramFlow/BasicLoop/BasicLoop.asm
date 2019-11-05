
//File: ../Tests/ProgramFlow/BasicLoop/BasicLoop.vm


//vm command: push constant 0    

@0		// A = 0
D = A		// D = A = 0
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop local 0        // initialize sum = 0

@0		// A = 0
D = A		// D = A = 0
@LCL
A = M		// A = M[LCL]
D = A + D		// D = M[LCL] + 0
@R13		//A = 13
M = D		// RAM[13] = D
@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@R13		// A = 13
A = M		// A = RAM[13]
M = D		// M[RAM[13]] = D

//vm command: label LOOP_START

(LOOP_START)

//vm command: push argument 0    

@0		//A = 0
D = A		// D = A = 0
@ARG
A = M + D		// A = RAM[ARG] + 0
D = M		// D = RAM[RAM[ARG]+0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push local 0

@0		//A = 0
D = A		// D = A = 0
@LCL
A = M + D		// A = RAM[LCL] + 0
D = M		// D = RAM[RAM[LCL]+0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: add

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M+D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] + D = x + y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer

//vm command: pop local 0	   // sum = sum + counter

@0		// A = 0
D = A		// D = A = 0
@LCL
A = M		// A = M[LCL]
D = A + D		// D = M[LCL] + 0
@R13		//A = 13
M = D		// RAM[13] = D
@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@R13		// A = 13
A = M		// A = RAM[13]
M = D		// M[RAM[13]] = D

//vm command: push argument 0

@0		//A = 0
D = A		// D = A = 0
@ARG
A = M + D		// A = RAM[ARG] + 0
D = M		// D = RAM[RAM[ARG]+0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 1

@1		// A = 1
D = A		// D = A = 1
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: sub

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M-D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] - D = x - y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer

//vm command: pop argument 0     // counter--

@0		// A = 0
D = A		// D = A = 0
@ARG
A = M		// A = M[ARG]
D = A + D		// D = M[ARG] + 0
@R13		//A = 13
M = D		// RAM[13] = D
@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@R13		// A = 13
A = M		// A = RAM[13]
M = D		// M[RAM[13]] = D

//vm command: push argument 0

@0		//A = 0
D = A		// D = A = 0
@ARG
A = M + D		// A = RAM[ARG] + 0
D = M		// D = RAM[RAM[ARG]+0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: if-goto LOOP_START // If counter > 0, goto LOOP_START

@SP		// A = 0
M = M - 1		// M[SP] = M[SP] - 1 , decrement the stack pointer 
A = M		// A = M[SP]
D = M		// M = M[M[SP]]
@LOOP_START
D;JNE		// If the stack head is different than zero, jump to Label C

//vm command: push local 0

@0		//A = 0
D = A		// D = A = 0
@LCL
A = M + D		// A = RAM[LCL] + 0
D = M		// D = RAM[RAM[LCL]+0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
