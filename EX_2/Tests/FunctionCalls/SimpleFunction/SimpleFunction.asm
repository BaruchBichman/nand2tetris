
//File: ../Tests/FunctionCalls/SimpleFunction/SimpleFunction.vm


//vm command: function SimpleFunction.test 2

(SimpleFunction.test)

// push local-1

@0		// A = 0
D = A		// D = A = 0
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

// push local-2

@0		// A = 0
D = A		// D = A = 0
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

//vm command: push local 1

@1		//A = 1
D = A		// D = A = 1
@LCL
A = M + D		// A = RAM[LCL] + 1
D = M		// D = RAM[RAM[LCL]+1]
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

//vm command: not

@SP		//A = 0
A = M - 1		// A = RAM[SP] - 1
M = !M		// RAM[RAM[SP]-1] = ! y

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

//vm command: add

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M+D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] + D = x + y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer

//vm command: push argument 1

@1		//A = 1
D = A		// D = A = 1
@ARG
A = M + D		// A = RAM[ARG] + 1
D = M		// D = RAM[RAM[ARG]+1]
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

//vm command: return

		//FRAME = LCL
@LCL
D = M
@R13		// FRAME store in R13
M = D
		//RET = *(FRAME - 5)
		//RAM[14] = (LOCAL - 5)
@5		// A = 5 
A = D - A		// A = LCL - 5 
D = M		// D = RAM[RAM[LCL]-5]
@R14		// RET store in R14
M = D
		// *ARG = pop()
@SP		// A = 0
M = M -1
A = M		// pointer to top the stack
D = M		// D = value of top the stack
@ARG
A = M		// pointer to argument segment
M = D		// *ARG = pop
		// SP = ARG -1
@ARG
D = M		// D = M[ARG]
@SP
M = D + 1		// M[SP] = M[ARG] + 1
		//THAT = *(FRAME-1)
@R13		// R13 = FRAME
M = M - 1		// FRAME = FRAME - 1
A = M
D = M
@THAT
M = D
		//THIS = *(FRAME-2)
@R13		// R13 = FRAME
M = M - 1		// FRAME = FRAME - 1
A = M
D = M
@THIS
M = D
		//ARG = *(FRAME-3)
@R13		// R13 = FRAME
M = M - 1		// FRAME = FRAME - 1
A = M
D = M
@ARG
M = D
		//LCL = *(FRAME-4)
@R13		// R13 = FRAME
M = M - 1		// FRAME = FRAME - 1
A = M
D = M
@LCL
M = D
@R14		// RET store in R14
A = M		// A = M[R14]
0;JMP