class XMLwriter

	file:FileStream
	d:dict of string,string
	
	construct(fileName:string)
		print fileName
		file = FileStream.open(fileName, "w")
		d = new dict of string,string

		d["KEYWORD"] = "keyword"
		d["SYMBOL"] = "symbol"
		d["IDENTIFIER"] = "identifier"
		d["INT_CONST"] = "integerConstant"
		d["STRING_CONST"] = "stringConstant"

	def writeElement(tag:string, data:string)
		temp:string = d[tag]
		if data == "<"
			data = "&lt;"
			
		if data == ">"
			data = "&gt;"
			
		if data == "\""
			data = "&quot;"
			
		if data == "&"
			data = "&amp;"
		file.puts("<" + temp + "> " + data + " </" + temp + ">\n")
		
	def writeStartTag(startTag:string)
		file.puts("<" + startTag + ">\n")
		
	def writeEndTag(endTag:string)
		file.puts("</" + endTag + ">\n")
		
	

		