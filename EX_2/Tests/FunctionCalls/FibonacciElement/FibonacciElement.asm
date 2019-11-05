
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

//File: ../Tests/FunctionCalls/FibonacciElement/Main.vm


//vm command: function Main.fibonacci 0

(Main.fibonacci)

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

//vm command: push constant 2

@2		// A = 2
D = A		// D = A = 2
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: lt                     // check if n < 2

@SP		//A = 0
A = M - 1		// A = RAM[sp] -1 
D = M 		// D = y 
A = A - 1		// A = RAM[sp] -2 
D = D - M		// D = y - x 
@IF_TRUE0		// label if true
D;JGT
D = 0		// The comparison result is false 
@END0
0;JMP		// Jump anyway 
(IF_TRUE0)
D = -1		// The comparison result is true
(END0)
@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
A = A - 1		// A = RAM[sp] - 2
M = D		// RAM[RAM[SP]-2] = result <0 if false, -1 if true>
@SP		// A = 0
M = M -1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer

//vm command: if-goto IF_TRUE

@SP		// A = 0
M = M - 1		// M[SP] = M[SP] - 1 , decrement the stack pointer 
A = M		// A = M[SP]
D = M		// M = M[M[SP]]
@IF_TRUE
D;JNE		// If the stack head is different than zero, jump to Label C

//vm command: goto IF_FALSE

@IF_FALSE
0;JMP

//vm command: label IF_TRUE          // if n<2, return n

(IF_TRUE)

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
//vm command: label IF_FALSE         // if n>=2, return fib(n-2)+fib(n-1)

(IF_FALSE)

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

//vm command: push constant 2

@2		// A = 2
D = A		// D = A = 2
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

//vm command: call Main.fibonacci 1  // compute fib(n-2)

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
@6		// numArgs + 5 
D = D - A
@ARG
M = D		// RAM[ARG] = D = SP - (numArgs + 5)
		// LCL = SP
@SP
D = M
@LCL
M = D
@Main.fibonacci
0;JMP
(ReturnAddress1)

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

//vm command: call Main.fibonacci 1  // compute fib(n-1)

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
@Main.fibonacci
0;JMP
(ReturnAddress2)

//vm command: add                    // return fib(n-1) + fib(n-2)

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
//File: ../Tests/FunctionCalls/FibonacciElement/Sys.vm


//vm command: function Sys.init 0

(Sys.init)

//vm command: push constant 4

@4		// A = 4
D = A		// D = A = 4
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: call Main.fibonacci 1   // Compute the 4'th fibonacci element

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
@6		// numArgs + 5 
D = D - A
@ARG
M = D		// RAM[ARG] = D = SP - (numArgs + 5)
		// LCL = SP
@SP
D = M
@LCL
M = D
@Main.fibonacci
0;JMP
(ReturnAddress3)

//vm command: label WHILE

(WHILE)

//vm command: goto WHILE              // Loop infinitely

@WHILE
0;JMP
