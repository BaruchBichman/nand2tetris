def compileOneFile(inputFile:string)
	outputFileXML:string = inputFile.splice(inputFile.length-5, inputFile.length,".xml")
	outputFileVM:string = inputFile.splice(inputFile.length-5, inputFile.length,".vm")
	c:CompilationEngine = new CompilationEngine(inputFile,outputFileXML, outputFileVM)
	c.compileClass()

init
	pathSource:string = args[1]
	isDir:bool = FileUtils.test (pathSource, FileTest.IS_DIR)
	if (not isDir) and (pathSource.has_suffix(".jack"))

		compileOneFile(pathSource)

	else
		dir:Dir=null
		try
			dir = Dir.open (pathSource, 0)
			fileName:string
			path:string
			while ((fileName = dir.read_name ()) != null)
				path=Path.build_filename (pathSource, fileName)
				if(path.has_suffix(".jack"))
					compileOneFile(path)
					
		except ex : FileError
			print "There is no such folder"
	