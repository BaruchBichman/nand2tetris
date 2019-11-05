class VMWriter
	file:FileStream
	
	construct(outputFile:string)
		file = FileStream.open(outputFile, "w")
		
	def writePush(segment:string, index:int)
		file.puts("push " + segment + " " + index.to_string() + "\n") 
	
	def writePop(segment:string, index:int)
		file.puts("pop " + segment + " " + index.to_string() + "\n")
		
	def writeArithmetic(command:string)
		file.puts(command + "\n")
		
	def writeLabel(label:string)
		file.puts("label " + label + "\n")
		
	def writeGoto(label:string)
		file.puts("goto " + label + "\n")	
		
	def writeIf(label:string)
		file.puts("if-goto " + label + "\n")
	
	def writeCall(name:string, nArgs:int)
		file.puts("call " + name + " " + nArgs.to_string() + "\n")
		
	def writeFunction(name:string, nLocals:int)
		file.puts("function " + name + " " + nLocals.to_string() + "\n")
		
	def writeReturn()
		file.puts("return\n")
	