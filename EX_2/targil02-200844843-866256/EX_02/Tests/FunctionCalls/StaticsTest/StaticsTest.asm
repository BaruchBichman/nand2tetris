
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

//File: ../Tests/FunctionCalls/StaticsTest/Class2.vm


//vm command: function Class2.set 0

(Class2.set)

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

//vm command: pop static 0

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@Class2.vm.0
M = D		// M[Class2.vm.0] = D

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

//vm command: pop static 1

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@Class2.vm.1
M = D		// M[Class2.vm.1] = D

//vm command: push constant 0

@0		// A = 0
D = A		// D = A = 0
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

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
//vm command: function Class2.get 0

(Class2.get)

//vm command: push static 0

@Class2.vm.0
D = M		// D = RAM[Class2.vm.0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer


//vm command: push static 1

@Class2.vm.1
D = M		// D = RAM[Class2.vm.1]
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
//File: ../Tests/FunctionCalls/StaticsTest/Sys.vm


//vm command: function Sys.init 0

(Sys.init)

//vm command: push constant 6

@6		// A = 6
D = A		// D = A = 6
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 8

@8		// A = 8
D = A		// D = A = 8
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: call Class1.set 2

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
@7		// numArgs + 5 
D = D - A
@ARG
M = D		// RAM[ARG] = D = SP - (numArgs + 5)
		// LCL = SP
@SP
D = M
@LCL
M = D
@Class1.set
0;JMP
(ReturnAddress1)

//vm command: pop temp 0 // Dumps the return value

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@5		// A = 5 + 0
M = D		//M[A] = D

//vm command: push constant 23

@23		// A = 23
D = A		// D = A = 23
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 15

@15		// A = 15
D = A		// D = A = 15
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: call Class2.set 2

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
@7		// numArgs + 5 
D = D - A
@ARG
M = D		// RAM[ARG] = D = SP - (numArgs + 5)
		// LCL = SP
@SP
D = M
@LCL
M = D
@Class2.set
0;JMP
(ReturnAddress2)

//vm command: pop temp 0 // Dumps the return value

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@5		// A = 5 + 0
M = D		//M[A] = D

//vm command: call Class1.get 0

@ReturnAddress3
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
@Class1.get
0;JMP
(ReturnAddress3)

//vm command: call Class2.get 0

@ReturnAddress4
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
@Class2.get
0;JMP
(ReturnAddress4)

//vm command: label WHILE

(WHILE)

//vm command: goto WHILE

@WHILE
0;JMP

//File: ../Tests/FunctionCalls/StaticsTest/Class1.vm


//vm command: function Class1.set 0

(Class1.set)

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

//vm command: pop static 0

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@Class1.vm.0
M = D		// M[Class1.vm.0] = D

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

//vm command: pop static 1

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@Class1.vm.1
M = D		// M[Class1.vm.1] = D

//vm command: push constant 0

@0		// A = 0
D = A		// D = A = 0
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

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
//vm command: function Class1.get 0

(Class1.get)

//vm command: push static 0

@Class1.vm.0
D = M		// D = RAM[Class1.vm.0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer


//vm command: push static 1

@Class1.vm.1
D = M		// D = RAM[Class1.vm.1]
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