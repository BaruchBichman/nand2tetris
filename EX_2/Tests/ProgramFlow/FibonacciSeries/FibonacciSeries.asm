
//File: ../Tests/ProgramFlow/FibonacciSeries/FibonacciSeries.vm


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

//vm command: pop pointer 1           // that = argument[1]

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[RAM[SP]-1] ,Top of the stack
@SP		// A = 0
M = M - 1		// RAM[SP] = RAM[SP] -1 ,decrement the stack pointer
@THAT
M = D		// M[3+1] = D

//vm command: push constant 0

@0		// A = 0
D = A		// D = A = 0
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop that 0              // first element = 0

@0		// A = 0
D = A		// D = A = 0
@THAT
A = M		// A = M[THAT]
D = A + D		// D = M[THAT] + 0
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

//vm command: push constant 1

@1		// A = 1
D = A		// D = A = 1
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: pop that 1              // second element = 1

@1		// A = 1
D = A		// D = A = 1
@THAT
A = M		// A = M[THAT]
D = A + D		// D = M[THAT] + 1
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

//vm command: pop argument 0          // num_of_elements -= 2 (first 2 elements are set)

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

//vm command: label MAIN_LOOP_START

(MAIN_LOOP_START)

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

//vm command: if-goto COMPUTE_ELEMENT // if num_of_elements > 0, goto COMPUTE_ELEMENT

@SP		// A = 0
M = M - 1		// M[SP] = M[SP] - 1 , decrement the stack pointer 
A = M		// A = M[SP]
D = M		// M = M[M[SP]]
@COMPUTE_ELEMENT
D;JNE		// If the stack head is different than zero, jump to Label C

//vm command: goto END_PROGRAM        // otherwise, goto END_PROGRAM

@END_PROGRAM
0;JMP

//vm command: label COMPUTE_ELEMENT

(COMPUTE_ELEMENT)

//vm command: push that 0

@0		//A = 0
D = A		// D = A = 0
@THAT
A = M + D		// A = RAM[THAT] + 0
D = M		// D = RAM[RAM[THAT]+0]
@SP		// A = 0
A = M		// A = RAM[SP]
M = D		// RAM[RAM[SP]] = D
@SP		// A = 0
M = M + 1		// RAM[SP] = RAM[SP]+1 ,increment the stack pointer

//vm command: push that 1

@1		//A = 1
D = A		// D = A = 1
@THAT
A = M + D		// A = RAM[THAT] + 1
D = M		// D = RAM[RAM[THAT]+1]
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

//vm command: pop that 2              // that[2] = that[0] + that[1]

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

//vm command: push pointer 1

@THAT
D = M		// D = RAM[3+1]
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

//vm command: add

@SP		// A = 0
A = M - 1		// A = RAM[SP] - 1
D = M		// D = RAM[A] = RAM[RAM[SP]-1] = y
A = A-1		// A = A -1 = RAM[SP] - 2
M = M+D		//RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] + D = x + y
@SP		// A = 0
M = M - 1		//RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer

//vm command: pop pointer 1           // that += 1

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

//vm command: pop argument 0          // num_of_elements--

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

//vm command: goto MAIN_LOOP_START

@MAIN_LOOP_START
0;JMP

//vm command: label END_PROGRAM

(END_PROGRAM)
