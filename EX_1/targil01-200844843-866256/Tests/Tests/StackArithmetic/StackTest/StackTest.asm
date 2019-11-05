
//File: ../Tests/StackArithmetic/StackTest/StackTest.vm


//vm command: push constant 17

@17		// A = 17
D = A		// D = A = 17
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 17

@17		// A = 17
D = A		// D = A = 17
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: eq

@SP		//A = 0
A = M - 1		// A = RAM[sp] -1 
D = M 		// D = y 
A = A - 1		// A = RAM[sp] -2 
D = D - M		// D = y - x 
@IF_TRUE0		// label if true
D;JEQ
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

//vm command: push constant 892

@892		// A = 892
D = A		// D = A = 892
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 891

@891		// A = 891
D = A		// D = A = 891
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: lt

@SP		//A = 0
A = M - 1		// A = RAM[sp] -1 
D = M 		// D = y 
A = A - 1		// A = RAM[sp] -2 
D = D - M		// D = y - x 
@IF_TRUE1		// label if true
D;JGT
D = 0		// The comparison result is false 
@END1
0;JMP		// Jump anyway 
(IF_TRUE1)
D = -1		// The comparison result is true
(END1)
@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
A = A - 1		// A = RAM[sp] - 2
M = D		// RAM[RAM[SP]-2] = result <0 if false, -1 if true>
@SP		// A = 0
M = M -1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer

//vm command: push constant 32767

@32767		// A = 32767
D = A		// D = A = 32767
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 32766

@32766		// A = 32766
D = A		// D = A = 32766
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: gt

@SP		//A = 0
A = M - 1		// A = RAM[sp] -1 
D = M 		// D = y 
A = A - 1		// A = RAM[sp] -2 
D = D - M		// D = y - x 
@IF_TRUE2		// label if true
D;JLT
D = 0		// The comparison result is false 
@END2
0;JMP		// Jump anyway 
(IF_TRUE2)
D = -1		// The comparison result is true
(END2)
@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
A = A - 1		// A = RAM[sp] - 2
M = D		// RAM[RAM[SP]-2] = result <0 if false, -1 if true>
@SP		// A = 0
M = M -1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer

//vm command: push constant 56

@56		// A = 56
D = A		// D = A = 56
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 31

@31		// A = 31
D = A		// D = A = 31
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push constant 53

@53		// A = 53
D = A		// D = A = 53
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

//vm command: push constant 112

@112		// A = 112
D = A		// D = A = 112
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

//vm command: neg

@SP		//A = 0
A = M - 1		// A = RAM[SP] - 1
M = -M		// RAM[RAM[SP]-1] = - y

//vm command: and

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M&D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] & D = x & y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer

//vm command: push constant 82

@82		// A = 82
D = A		// D = A = 82
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: or

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M|D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] | D = x | y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer
