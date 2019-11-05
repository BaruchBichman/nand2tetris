
//File: ../Tests/MemoryAccess/StaticTest/StaticTest.vm


//vm command: push constant 111

@111		// A = 111
D = A		// D = A = 111
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 333

@333		// A = 333
D = A		// D = A = 333
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 888

@888		// A = 888
D = A		// D = A = 888
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop static 8

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@StaticTest.vm.8
M = D		// M[StaticTest.vm.8] = D

//vm command: pop static 3

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@StaticTest.vm.3
M = D		// M[StaticTest.vm.3] = D

//vm command: pop static 1

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@StaticTest.vm.1
M = D		// M[StaticTest.vm.1] = D

//vm command: push static 3

@StaticTest.vm.3
D = M		// D = RAM[StaticTest.vm.3]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer


//vm command: push static 1

@StaticTest.vm.1
D = M		// D = RAM[StaticTest.vm.1]
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

//vm command: push static 8

@StaticTest.vm.8
D = M		// D = RAM[StaticTest.vm.8]
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
