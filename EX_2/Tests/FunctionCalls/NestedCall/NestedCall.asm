
//File: Init

		//SP = 256
@256		// A = 256
D = A		// D = A = 256
@SP		// A = 0
M = D		// M[SP] = D = 256
		// call Sys.init
@ReturnAddress0
D = A		// D = return address
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save LCL
@LCL
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save ARG
@ARG
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save THIS
@THIS
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save THAT
@THAT
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// ARG = SP-n-5 
@SP
D = M		// D = RAM[SP]
@5		// numArgs + 5 
D = D - A
@ARG
M = D		// RAM[ARG] = D = SP - (numArgs + 5)
		// LCL = SP
@SP
D = M
@LCL
M = D
@Sys.init
0;JMP
(ReturnAddress0)

//File: ../Tests/FunctionCalls/NestedCall/Sys.vm


//vm command: function Sys.init 0

(Sys.init)

//vm command: push constant 4000	// test THIS and THAT context save

@4000		// A = 4000
D = A		// D = A = 4000
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop pointer 0

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@THIS
M = D		// M[3+0] = D

//vm command: push constant 5000

@5000		// A = 5000
D = A		// D = A = 5000
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop pointer 1

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@THAT
M = D		// M[3+1] = D

//vm command: call Sys.main 0

@ReturnAddress1
D = A		// D = return address
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save LCL
@LCL
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save ARG
@ARG
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save THIS
@THIS
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save THAT
@THAT
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// ARG = SP-n-5 
@SP
D = M		// D = RAM[SP]
@5		// numArgs + 5 
D = D - A
@ARG
M = D		// RAM[ARG] = D = SP - (numArgs + 5)
		// LCL = SP
@SP
D = M
@LCL
M = D
@Sys.main
0;JMP
(ReturnAddress1)

//vm command: pop temp 1

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@6		// A = 5 + 1
M = D		//M[A] = D

//vm command: label LOOP

(LOOP)

//vm command: goto LOOP

@LOOP
0;JMP

//vm command: function Sys.main 5

(Sys.main)

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

// push local-3

@0		// A = 0
D = A		// D = A = 0
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

// push local-4

@0		// A = 0
D = A		// D = A = 0
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

// push local-5

@0		// A = 0
D = A		// D = A = 0
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 4001

@4001		// A = 4001
D = A		// D = A = 4001
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop pointer 0

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@THIS
M = D		// M[3+0] = D

//vm command: push constant 5001

@5001		// A = 5001
D = A		// D = A = 5001
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop pointer 1

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@THAT
M = D		// M[3+1] = D

//vm command: push constant 200

@200		// A = 200
D = A		// D = A = 200
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop local 1

@1		// A = 1
D = A		// D = A = 1
@LCL
A = M		// A = M[LCL]
D = A + D		// D = M[LCL] + 1
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

//vm command: push constant 40

@40		// A = 40
D = A		// D = A = 40
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop local 2

@2		// A = 2
D = A		// D = A = 2
@LCL
A = M		// A = M[LCL]
D = A + D		// D = M[LCL] + 2
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

//vm command: push constant 6

@6		// A = 6
D = A		// D = A = 6
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop local 3

@3		// A = 3
D = A		// D = A = 3
@LCL
A = M		// A = M[LCL]
D = A + D		// D = M[LCL] + 3
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

//vm command: push constant 123

@123		// A = 123
D = A		// D = A = 123
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: call Sys.add12 1

@ReturnAddress2
D = A		// D = return address
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save LCL
@LCL
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save ARG
@ARG
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save THIS
@THIS
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// Save THAT
@THAT
D = M
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer
		// ARG = SP-n-5 
@SP
D = M		// D = RAM[SP]
@6		// numArgs + 5 
D = D - A
@ARG
M = D		// RAM[ARG] = D = SP - (numArgs + 5)
		// LCL = SP
@SP
D = M
@LCL
M = D
@Sys.add12
0;JMP
(ReturnAddress2)

//vm command: pop temp 0

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@5		// A = 5 + 0
M = D		//M[A] = D

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

//vm command: push local 2

@2		//A = 2
D = A		// D = A = 2
@LCL
A = M + D		// A = RAM[LCL] + 2
D = M		// D = RAM[RAM[LCL]+2]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push local 3

@3		//A = 3
D = A		// D = A = 3
@LCL
A = M + D		// A = RAM[LCL] + 3
D = M		// D = RAM[RAM[LCL]+3]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push local 4

@4		//A = 4
D = A		// D = A = 4
@LCL
A = M + D		// A = RAM[LCL] + 4
D = M		// D = RAM[RAM[LCL]+4]
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

//vm command: add

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M+D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] + D = x + y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer

//vm command: add

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M+D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] + D = x + y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer

//vm command: add

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M+D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] + D = x + y
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
//vm command: function Sys.add12 0

(Sys.add12)

//vm command: push constant 4002

@4002		// A = 4002
D = A		// D = A = 4002
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop pointer 0

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@THIS
M = D		// M[3+0] = D

//vm command: push constant 5002

@5002		// A = 5002
D = A		// D = A = 5002
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop pointer 1

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@THAT
M = D		// M[3+1] = D

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

//vm command: push constant 12

@12		// A = 12
D = A		// D = A = 12
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