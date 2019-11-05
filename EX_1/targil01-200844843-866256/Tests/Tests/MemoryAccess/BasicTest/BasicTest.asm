
//File: ../Tests/MemoryAccess/BasicTest/BasicTest.vm


//vm command: push constant 10

@10		// A = 10
D = A		// D = A = 10
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop local 0

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

//vm command: push constant 21

@21		// A = 21
D = A		// D = A = 21
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 22

@22		// A = 22
D = A		// D = A = 22
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop argument 2

@2		// A = 2
D = A		// D = A = 2
@ARG
A = M		// A = M[ARG]
D = A + D		// D = M[ARG] + 2
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

//vm command: pop argument 1

@1		// A = 1
D = A		// D = A = 1
@ARG
A = M		// A = M[ARG]
D = A + D		// D = M[ARG] + 1
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

//vm command: push constant 36

@36		// A = 36
D = A		// D = A = 36
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop this 6

@6		// A = 6
D = A		// D = A = 6
@THIS
A = M		// A = M[THIS]
D = A + D		// D = M[THIS] + 6
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

//vm command: push constant 42

@42		// A = 42
D = A		// D = A = 42
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 45

@45		// A = 45
D = A		// D = A = 45
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop that 5

@5		// A = 5
D = A		// D = A = 5
@THAT
A = M		// A = M[THAT]
D = A + D		// D = M[THAT] + 5
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

//vm command: pop that 2

@2		// A = 2
D = A		// D = A = 2
@THAT
A = M		// A = M[THAT]
D = A + D		// D = M[THAT] + 2
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

//vm command: push constant 510

@510		// A = 510
D = A		// D = A = 510
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop temp 6

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@11		// A = 5 + 6
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

//vm command: push that 5

@5		//A = 5
D = A		// D = A = 5
@THAT
A = M + D		// A = RAM[THAT] + 5
D = M		// D = RAM[RAM[THAT]+5]
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

//vm command: push this 6

@6		//A = 6
D = A		// D = A = 6
@THIS
A = M + D		// A = RAM[THIS] + 6
D = M		// D = RAM[RAM[THIS]+6]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push this 6

@6		//A = 6
D = A		// D = A = 6
@THIS
A = M + D		// A = RAM[THIS] + 6
D = M		// D = RAM[RAM[THIS]+6]
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

//vm command: sub

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M-D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] - D = x - y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer

//vm command: push temp 6

@11		// A = 5 + 6
D = M		// D = RAM[5+6]
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
