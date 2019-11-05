// Baruch Baruch ID 200844843
// Baruch Gehler ID 866256
// Group number 44

class CodeWriter
	trueCounter:int
	endCounter:int
	callfuncCounter:int
	pathOutputFile:string
	file:FileStream?
	sourceFileName:string
	fileBaseName:string
	
	construct(aOutputFile:string)
		trueCounter = 0
		endCounter = 0
		callfuncCounter = 0
		pathOutputFile = aOutputFile
		file = FileStream.open(pathOutputFile, "w")
		writeInit()
		
	def setFileName(fileName:string)
		sourceFileName = fileName
		fileBaseName = Path.get_basename(sourceFileName)
		comment("File: " + fileName)
		
		
	def writeArithmetic(command:string)
		asmCommands:string=""
			if command.has_prefix( "add" )
				asmCommands = binaryOp("+")
				
			if command.has_prefix( "sub" )
				asmCommands = binaryOp("-")
				
			if command.has_prefix( "and" )
				asmCommands = binaryOp("&")
				
			if command.has_prefix( "or" )
				asmCommands = binaryOp("|")
				
			if command.has_prefix( "neg" )
				asmCommands = unaryOp("-")
				
			if command.has_prefix( "not" )
				asmCommands = unaryOp("!")
				
			if command.has_prefix( "eq" )
				asmCommands = compareOp("JEQ")
				
			if command.has_prefix( "gt" )
				asmCommands = compareOp("JLT")
				
			if command.has_prefix( "lt" )
				asmCommands = compareOp("JGT")

		file.puts(asmCommands)
    	
    
	def writePushPop(command:string, segment:string, index:int)
		asmCommands:string
		
		if command == "C_PUSH"
			asmCommands = push(segment, index)
		else
			asmCommands = pop(segment,index)

		file.puts(asmCommands)
		
		
	def writeLabel(label:string)
		file.puts("(" + label +")" + commentString())
		
	def writeGoto(label:string)
		asmCommands:string
		
		asmCommands = "@" + label + commentString()
		asmCommands += "0;JMP" + commentString()
		
		file.puts(asmCommands)

	def writeIf(label:string)
		asmCommands:string
		
		asmCommands = "@SP" +commentString(" A = 0")
		asmCommands += "M = M - 1" + commentString(" M[SP] = M[SP] - 1 , decrement the stack pointer ")
		asmCommands += "A = M" + commentString(" A = M[SP]")
		asmCommands += "D = M" + commentString(" M = M[M[SP]]")
		asmCommands += "@" + label + commentString()
		asmCommands += "D;JNE" + commentString(" If the stack head is different than zero, jump to Label C")
		
		file.puts( asmCommands)
		
	def writeCall(functionName:string, numArgs:int)
		asmCommands:string
		
		asmCommands = "@ReturnAddress" + callfuncCounter.to_string() +commentString()
		asmCommands += "D = A" + commentString(" D = return address")
		asmCommands += pushToStack() 
		
		asmCommands += commentString(" Save LCL")
		asmCommands += "@LCL" + commentString()
		asmCommands += "D = M" + commentString()
		asmCommands += pushToStack()
		
		asmCommands += commentString(" Save ARG")
		asmCommands += "@ARG" + commentString()
		asmCommands += "D = M" + commentString()
		asmCommands += pushToStack()
		
		asmCommands += commentString(" Save THIS")
		asmCommands += "@THIS" + commentString()
		asmCommands += "D = M" + commentString()
		asmCommands += pushToStack()
	
		asmCommands += commentString(" Save THAT")
		asmCommands += "@THAT" + commentString()
		asmCommands += "D = M" + commentString()
		asmCommands += pushToStack()
		
		asmCommands += commentString(" ARG = SP-n-5 ")
		asmCommands += "@SP" + commentString()
		asmCommands += "D = M" + commentString(" D = RAM[SP]")
		asmCommands += "@" + (numArgs + 5).to_string() + commentString(" numArgs + 5 ")
		asmCommands += "D = D - A" + commentString()
		asmCommands += "@ARG" + commentString()
		asmCommands += "M = D" + commentString(" RAM[ARG] = D = SP - (numArgs + 5)")
	
		asmCommands += commentString(" LCL = SP")
		asmCommands += "@SP" + commentString()
		asmCommands += "D = M" + commentString()
		asmCommands += "@LCL" + commentString()
		asmCommands += "M = D" + commentString()
		
		file.puts(asmCommands)
		
		writeGoto(functionName)
		writeLabel("ReturnAddress"+callfuncCounter.to_string())
		callfuncCounter++
		
	def writeFunction(functionName:string, numLocals:int)
		writeLabel(functionName)
		for var i = 1 to numLocals 
			comment(" push local-" + i.to_string())
			file.puts(pushConstant(0))
		
	def writeReturn()
		asmCommands:string
		asmCommands = commentString("FRAME = LCL")
		asmCommands += "@LCL" + commentString()
		asmCommands += "D = M" + commentString()
		asmCommands += "@R13" + commentString( " FRAME store in R13")
		asmCommands += "M = D" + commentString()
		
		asmCommands += commentString("RET = *(FRAME - 5)")
		asmCommands += commentString("RAM[14] = (LOCAL - 5)")
		asmCommands += "@5" + commentString(" A = 5 ")
		asmCommands += "A = D - A" + commentString(" A = LCL - 5 " )
		asmCommands += "D = M" + commentString(" D = RAM[RAM[LCL]-5]")
		asmCommands += "@R14" + commentString(" RET store in R14")
		asmCommands += "M = D" + commentString()
		
		asmCommands += commentString(" *ARG = pop()")
		asmCommands += "@SP" +commentString(" A = 0")
		asmCommands += "M = M -1" +commentString()
		asmCommands += "A = M" +commentString(" pointer to top the stack")
		asmCommands += "D = M" +commentString(" D = value of top the stack")
		asmCommands += "@ARG" +commentString()
		asmCommands += "A = M" +commentString(" pointer to argument segment")
		asmCommands += "M = D" +commentString(" *ARG = pop")
		
		asmCommands += commentString(" SP = ARG -1")
		asmCommands += "@ARG" + commentString()
		asmCommands += "D = M" +commentString(" D = M[ARG]")
		asmCommands += "@SP" + commentString()
		asmCommands += "M = D + 1" + commentString(" M[SP] = M[ARG] + 1")
		
		asmCommands += commentString("THAT = *(FRAME-1)")
		asmCommands += restoreCaller("THAT")
		
		asmCommands += commentString("THIS = *(FRAME-2)")
		asmCommands += restoreCaller("THIS")
		
		asmCommands += commentString("ARG = *(FRAME-3)")
		asmCommands += restoreCaller("ARG")
		
		asmCommands += commentString("LCL = *(FRAME-4)")
		asmCommands += restoreCaller("LCL")
		
		asmCommands += "@R14" +commentString(" RET store in R14")
		asmCommands += "A = M" +commentString(" A = M[R14]")
		asmCommands += "0;JMP"
		
		file.puts(asmCommands)
		
	def writeInit()
	
		setFileName("Init")
		asmCommands:string
		asmCommands = commentString("SP = 256")
		asmCommands += "@256" + commentString(" A = 256")
		asmCommands += "D = A" + commentString(" D = A = 256")
		asmCommands += "@SP" + commentString(" A = 0")
		asmCommands += "M = D" + commentString(" M[SP] = D = 256")
		asmCommands += commentString(" call Sys.init")
		
		file.puts(asmCommands)
		
		writeCall("Sys.init", 0)
		
		
	def restoreCaller(segment:string):string
		asmCommands:string
		
		asmCommands = "@R13" + commentString(" R13 = FRAME")
		asmCommands += "M = M - 1" + commentString(" FRAME = FRAME - 1")
		asmCommands += "A = M" + commentString()
		asmCommands += "D = M" +commentString()
		asmCommands += "@" + segment + commentString()
		asmCommands += "M = D" + commentString()
		
		return asmCommands
		
		
	def push(segment:string, index:int):string
		if segment.has_prefix("local")
			return pushGroup1("LCL", index)
		if segment.has_prefix("argument")
			return pushGroup1("ARG", index)
		if segment.has_prefix("this")
			return pushGroup1("THIS", index)
		if segment.has_prefix("that")
			return pushGroup1("THAT", index)
		if segment.has_prefix("temp")
			return pushTemp(index)
		if segment.has_prefix("static")
			return pushStatic(index)
		if segment.has_prefix("pointer")
			return pushPointer(index)
		if segment.has_prefix("constant")
			return pushConstant(index)
		return ""
			
	def pop(segment:string, index:int):string
		if segment.has_prefix("local")
			return popGroup1("LCL", index)
		if segment.has_prefix("argument")
			return popGroup1("ARG", index)
		if segment.has_prefix("this")
			return popGroup1("THIS", index)
		if segment.has_prefix("that")
			return popGroup1("THAT", index)
		if segment.has_prefix("temp")
			return popTemp(index)
		if segment.has_prefix("static")
			return popStatic(index)
		if segment.has_prefix("pointer")
			return popPointer(index)	
		return ""
		
	//def close()
    //TODO
    
	def binaryOp(op:string):string
		asmCommand:string
		asmCommand  = "@SP" + commentString(" A = 0")
		asmCommand += "A = M - 1" +commentString( " A = RAM[SP] - 1")
		asmCommand += "D = M" + commentString(" D = RAM[A] = RAM[RAM[SP]-1] = y")
		asmCommand += "A = A-1" + commentString(" A = A -1 = RAM[SP] - 2")
		asmCommand += "M = M" + op + "D" + commentString( "RAM[RAM[SP]-2] =  RAM[RAM[SP]-2] " + op + " D = x " + op + " y")
		asmCommand += "@SP" + commentString( " A = 0")
		asmCommand += "M = M - 1" + commentString("RAM[SP] = RAM[SP] - 1 ,decrement the stack pointer")
		return asmCommand
        
	def unaryOp(op:string):string
		asmCommand:string 
		asmCommand  = "@SP" + commentString( "A = 0")
		asmCommand += "A = M - 1" +commentString(" A = RAM[SP] - 1")
		asmCommand += "M = " + op + "M" + commentString( " RAM[RAM[SP]-1] = " + op + " y")
		return asmCommand
		
	def compareOp(op:string):string
		asmCommands:string
		asmCommands = "@SP" + commentString("A = 0")
		asmCommands += "A = M - 1" +commentString(" A = RAM[sp] -1 ")
		asmCommands += "D = M "    + commentString(" D = y ")
		asmCommands += "A = A - 1" + commentString(" A = RAM[sp] -2 ")
		asmCommands += "D = D - M" + commentString(" D = y - x ")
		asmCommands += "@IF_TRUE"+trueCounter.to_string() + commentString(" label if true")
		asmCommands += "D;" + op + commentString()
		asmCommands += "D = 0" +commentString(" The comparison result is false ")
		asmCommands += "@END" + endCounter.to_string() +commentString()
		asmCommands += "0;JMP" +commentString( " Jump anyway ")
		asmCommands += "(IF_TRUE" + trueCounter.to_string() + ")" +commentString()
		asmCommands += "D = -1" +commentString(" The comparison result is true")
		asmCommands += "(END" + endCounter.to_string() + ")"+commentString()
		asmCommands += "@SP" +commentString(" A = 0")
		asmCommands += "A = M - 1" +commentString(" A = RAM[SP] - 1")
		asmCommands += "A = A - 1" +commentString(" A = RAM[sp] - 2" )
		asmCommands += "M = D" +commentString(" RAM[RAM[SP]-2] = result <0 if false, -1 if true>")
		asmCommands += "@SP" +commentString(" A = 0")
		asmCommands += "M = M -1" +commentString(" RAM[SP] = RAM[SP] -1 ,decrement the stack pointer")
		
		endCounter++
		trueCounter++
		
		return asmCommands
		
	def pushGroup1(segment:string, index:int):string
		asmCommands:string
		
		asmCommands = "@" + index.to_string() +commentString( "A = "+ index.to_string())
		asmCommands += "D = A" +commentString(" D = A = " + index.to_string())
		asmCommands += "@" +segment + commentString()
		asmCommands += "A = M + D" + commentString(" A = RAM[" + segment + "] + " + index.to_string())
		asmCommands += "D = M" + commentString(" D = RAM[RAM[" + segment +"]+" + index.to_string() + "]")
		asmCommands += pushToStack() 
		
		return asmCommands
		
	def pushTemp(index:int):string
		indexStr:string = index.to_string()
		asmCommands:string
		
		asmCommands = "@" + (index + 5).to_string() + commentString( " A = 5 + " + indexStr)
		asmCommands += "D = M" +commentString(" D = RAM[5+"+indexStr+"]")
		asmCommands += pushToStack() + commentString()
		
		return asmCommands
		
	def pushStatic(index:int):string
		indexStr:string = index.to_string()
		asmCommands:string

		asmCommands = "@" + Path.get_basename(sourceFileName) + "." + indexStr + commentString()
		asmCommands += "D = M" +commentString( " D = RAM["+Path.get_basename(sourceFileName) + "." + indexStr +"]")
		asmCommands += pushToStack() + commentString()
		
		return asmCommands
		
	def pushPointer(index:int):string
		indexStr:string = index.to_string()
		asmCommands:string
		
		if index == 0
			asmCommands = "@THIS" + commentString()
		else
			asmCommands = "@THAT" + commentString()
		
		asmCommands += "D = M" +commentString( " D = RAM[3+"+indexStr+"]")
		asmCommands += pushToStack() + commentString()
		
		return asmCommands
		
	def pushConstant(index:int):string
		indexStr:string = index.to_string()
		asmCommands:string
		
		asmCommands  = "@" + indexStr + commentString(" A = " + indexStr)
		asmCommands += "D = A" + commentString(" D = A = " + indexStr)
		asmCommands += pushToStack()
		
		return asmCommands
		
		
	def pushToStack():string // push 'D' to stack
		
		asmCommands:string
		asmCommands = "@SP" +commentString(" A = 0")
		asmCommands += "A = M" +commentString(" A = RAM[SP]")
		asmCommands += "M = D" +commentString(" RAM[RAM[SP]] = D")
		asmCommands += "@SP" +commentString(" A = 0")
		asmCommands += "M = M + 1" +commentString(" RAM[SP] = RAM[SP]+1 ,increment the stack pointer")

		return asmCommands
		
	def popFromStack():string
		
		asmCommands:string
		
		asmCommands = "@SP" + commentString(" A = 0")
		asmCommands += "A = M - 1" + commentString(" A = RAM[SP] - 1")
		asmCommands += "D = M" + commentString(" D = RAM[RAM[SP]-1] ,Top of the stack")
		asmCommands += "@SP" + commentString(" A = 0")
		asmCommands += "M = M - 1" + commentString(" RAM[SP] = RAM[SP] -1 ,decrement the stack pointer")
		
		return asmCommands
		
	def popGroup1(segment:string, index:int):string
		indexStr:string = index.to_string()
		asmCommands:string
		 
		asmCommands = "@" + indexStr + commentString(" A = " + indexStr)
		asmCommands += "D = A" + commentString(" D = A = " + indexStr)
		asmCommands += "@" + segment + commentString()
		asmCommands += "A = M" + commentString(" A = M[" + segment +"]")
		asmCommands += "D = A + D" +commentString(" D = M[" + segment +"] + " + indexStr )
		asmCommands += "@R13" + commentString( "A = 13")
		asmCommands += "M = D" + commentString(" RAM[13] = D" )
		asmCommands += popFromStack()
		asmCommands += "@R13" + commentString(" A = 13")
		asmCommands += "A = M" +commentString(" A = RAM[13]")
		asmCommands += "M = D" +commentString(" M[RAM[13]] = D")
		 
		return asmCommands
		 
	def popTemp(index:int):string
		
		asmCommands:string
		
		asmCommands = popFromStack()
		asmCommands += "@" + (5 + index).to_string() + commentString(" A = 5 + " + index.to_string())
		asmCommands += "M = D" + commentString("M[A] = D")
		
		return asmCommands
		
	def popPointer(index:int):string
		asmCommands:string
		
		asmCommands = popFromStack()
		
		if index == 0
			asmCommands += "@THIS" + commentString()
		else
			asmCommands += "@THAT" + commentString()
		
		asmCommands += "M = D" + commentString(" M[3+" + index.to_string() + "] = D")
		
		return asmCommands
		
	def popStatic(index:int):string
		indexStr:string = index.to_string()
		asmCommands:string

		asmCommands = popFromStack()
		asmCommands += "@" + Path.get_basename(sourceFileName) + "." + indexStr + commentString()
		asmCommands += "M = D" + commentString(" M[" +  Path.get_basename(sourceFileName) + "." + indexStr +"] = D" )
		
		return asmCommands
	
	
	
	def comment(comment:string="")
		file.puts("\n//" + comment +"\n\n")
		
	def commentString(comment:string=""):string
		if comment == ""
			return "\n"
		return "\t\t//" + comment +"\n"
    	
        

    