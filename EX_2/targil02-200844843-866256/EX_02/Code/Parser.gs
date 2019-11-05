// Baruch Baruch ID 200844843
// Baruch Gehler ID 866256
// Group number 44

class Parser

	construct(aPathInputFile:string)
		pathInputFile=aPathInputFile
		file = FileStream.open(pathInputFile, "r")

	def hasMoreCommands():bool
		return not file.eof()

	def advance()
		currentCommand = file.read_line()

	def commandType():string //currentCommand = currentCommand.strip()
		if currentCommand == null
			return ""
	
		firstWord:string = currentCommand.split_set(" \n\t\r")[0]

		if firstWord =="add" or firstWord == "sub" or firstWord == "neg" or firstWord == "eq" or firstWord == "gt" or firstWord == "lt" 
			return "C_ARITHMETIC"
		if firstWord == "or" or firstWord == "and" or firstWord == "not"
			return "C_ARITHMETIC"

		if currentCommand.has_prefix("push")
			return "C_PUSH"
		if currentCommand.has_prefix("pop")
			return "C_POP"
			
		if currentCommand.has_prefix("label")
			return "C_LABEL"
		if currentCommand.has_prefix("goto")
			return "C_GOTO"
		if currentCommand.has_prefix("if")
			return "C_IF"

		if currentCommand.has_prefix("function")
			return "C_FUNCTION"
		if currentCommand.has_prefix("return")
			return "C_RETURN"
		if currentCommand.has_prefix("call")
			return "C_CALL"
		return ""

	def arg1():string
		if commandType()== "C_ARITHMETIC"
			return currentCommand.split_set(" \n\t\r")[0]
		else
			return currentCommand.split_set(" \n\t\r")[1]


	def arg2():int
		return int.parse(currentCommand.split_set(" \n\t\r")[2])

	def getCurrentCommand():string
		return currentCommand

	pathInputFile:string
	file:FileStream
	currentCommand:string
