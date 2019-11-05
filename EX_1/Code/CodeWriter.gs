// Baruch Baruch ID 200844843
// Baruch Gehler ID 866256
// Group number 44

class CodeWriter
	trueCounter:int
	endCounter:int
	pathOutputFile:string
	file:FileStream?
	sourceFileName:string
	
	construct(aOutputFile:string)
		trueCounter = 0
		endCounter = 0
		pathOutputFile = aOutputFile
		file = FileStream.open(pathOutputFile, "w")
		
	def setFileName(fileName:string)
		sourceFileName = fileName
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
		
		
	def pushToStack():string
		
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
    	
        

    