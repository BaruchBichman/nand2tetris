
//File: ../Tests/MemoryAccess/PointerTest/PointerTest.vm


//vm command: push constant 3030

@3030		// A = 3030
D = A		// D = A = 3030
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

//vm command: push constant 3040

@3040		// A = 3040
D = A		// D = A = 3040
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

//vm command: push constant 32

@32		// A = 32
D = A		// D = A = 32
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop this 2

@2		// A = 2
D = A		// D = A = 2
@THIS
A = M		// A = M[THIS]
D = A + D		// D = M[THIS] + 2
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

//vm command: push constant 46

@46		// A = 46
D = A		// D = A = 46
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop that 6

@6		// A = 6
D = A		// D = A = 6
@THAT
A = M		// A = M[THAT]
D = A + D		// D = M[THAT] + 6
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

//vm command: push pointer 0

@THIS
D = M		// D = RAM[3+0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer


//vm command: push pointer 1

@THAT
D = M		// D = RAM[3+1]
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

//vm command: push this 2

@2		//A = 2
D = A		// D = A = 2
@THIS
A = M + D		// A = RAM[THIS] + 2
D = M		// D = RAM[RAM[THIS]+2]
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

//vm command: push that 6

@6		//A = 6
D = A		// D = A = 6
@THAT
A = M + D		// A = RAM[THAT] + 6
D = M		// D = RAM[RAM[THAT]+6]
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
