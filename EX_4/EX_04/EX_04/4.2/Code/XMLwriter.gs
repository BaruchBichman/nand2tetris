class XMLwriter

	file:FileStream
	d:dict of string,string
	
	construct(fileName:string)
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
		//print "<" + temp + "> " + data + " </" + temp + ">\n"
		file.puts("<" + temp + "> " + data + " </" + temp + ">\n")
		
	def writeStartTag(startTag:string)
		//print "<" + startTag + ">\n"
		file.puts("<" + startTag + ">\n")
		
	def writeEndTag(endTag:string)
		//print "</" + endTag + ">\n"
		file.puts("</" + endTag + ">\n")


		
	
	

		