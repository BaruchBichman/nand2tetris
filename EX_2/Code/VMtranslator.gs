// Baruch Baruch ID 200844843
// Baruch Gehler ID 866256
// Group number 44

init

	pathSource:string = args[1]
	outputFile:string
	codeWriter:CodeWriter
	isDir:bool = FileUtils.test (pathSource, FileTest.IS_DIR)
	if (not isDir) and (pathSource.has_suffix(".vm"))

		outputFile = pathSource.splice(pathSource.length-3, pathSource.length,".asm")
		codeWriter = new CodeWriter(outputFile)
		writeOneFile(pathSource, codeWriter)

		
	else
		dir:Dir=null
		try
			dir = Dir.open (pathSource, 0)
			outputFile = Path.build_filename (pathSource ,Path.get_basename(pathSource)+".asm")
			codeWriter = new CodeWriter(outputFile)
			fileName:string
			path:string
			while ((fileName = dir.read_name ()) != null)
				path=Path.build_filename (pathSource, fileName)
				if(path.has_suffix(".vm"))
					writeOneFile(path, codeWriter)
					
		except ex : FileError
			print "There is no such folder"
			


	


def writeOneFile(pathFile:string ,codeWriter:CodeWriter)
	codeWriter.setFileName(pathFile)
	parser:Parser=new Parser(pathFile)
	commandType:string

	while(parser.hasMoreCommands() == true)
		parser.advance()
		commandType = parser.commandType()
		if commandType == "C_POP" or commandType == "C_PUSH"
			codeWriter.comment("vm command: " + parser.getCurrentCommand())
			codeWriter.writePushPop(commandType, parser.arg1() ,parser.arg2())
		if commandType == "C_ARITHMETIC"
			codeWriter.comment("vm command: " + parser.getCurrentCommand())
			codeWriter.writeArithmetic(parser.arg1())
		if commandType == "C_LABEL"
			codeWriter.comment("vm command: " + parser.getCurrentCommand())
			codeWriter.writeLabel(parser.arg1())
		if commandType == "C_GOTO"
			codeWriter.comment("vm command: " + parser.getCurrentCommand())
			codeWriter.writeGoto(parser.arg1())
		if commandType == "C_IF"
			codeWriter.comment("vm command: " + parser.getCurrentCommand())
			codeWriter.writeIf(parser.arg1())
		if commandType == "C_FUNCTION"
			codeWriter.comment("vm command: " + parser.getCurrentCommand())
			codeWriter.writeFunction(parser.arg1(), parser.arg2())
		if commandType == "C_RETURN"
			codeWriter.comment("vm command: " + parser.getCurrentCommand())	
			codeWriter.writeReturn()
		if commandType == "C_CALL"
			codeWriter.comment("vm command: " + parser.getCurrentCommand())
			codeWriter.writeCall(parser.arg1(), parser.arg2())
		
