def tokenizeOneFile(inputFile:string)
	outputFile:string = inputFile.splice(inputFile.length-5, inputFile.length,"T.xml")
	jt:JackTokenizer = new JackTokenizer(inputFile)
	xmlw:XMLwriter = new XMLwriter(outputFile)
	
	xmlw.writeStartTag("tokens")
	
	while jt.hasMoreTokens() 
		jt.advance()
		if not (jt.tokenType() == "" and jt.keyWord() == "")
			xmlw.writeElement( jt.tokenType(), jt.keyWord())
	
	xmlw.writeEndTag("tokens")

init

	pathSource:string = args[1]
	isDir:bool = FileUtils.test (pathSource, FileTest.IS_DIR)
	if (not isDir) and (pathSource.has_suffix(".jack"))

		tokenizeOneFile(pathSource)

	else
		dir:Dir=null
		try
			dir = Dir.open (pathSource, 0)
			fileName:string
			path:string
			while ((fileName = dir.read_name ()) != null)
				path=Path.build_filename (pathSource, fileName)
				if(path.has_suffix(".jack"))
					tokenizeOneFile(path)
					
		except ex : FileError
			print "There is no such folder"
	