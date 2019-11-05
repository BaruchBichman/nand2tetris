
class CompilationEngine
	
	tokenizer:JackTokenizer
	xmlWriter:XMLwriter
	
	op:array of string = {"+", "-", "*", "/", "|", "=", "<", ">", "&"}
	unaryOp:array of string = {"-", "~"}
	keywordConstant:array of string = {"true", "false", "null", "this"}
	
	construct(inputFile:string, outputFile:string)
		tokenizer = new JackTokenizer(inputFile)
		xmlWriter = new XMLwriter(outputFile)
		tokenizer.advance()
		
		
	def nextToken()
		tokenizer.advance()
		
	def writeTerminal()
		xmlWriter.writeElement(tokenizer.tokenType(), tokenizer.keyWord())
		
	def writeNextToken()
		writeTerminal()
		nextToken()
	
		
	def compileClass()
		xmlWriter.writeStartTag("class")
		writeNextToken() // write class keyWord
		writeNextToken() // write className
		writeNextToken() // write '{' symbol
		
		compileClassVarDec()
		compileSubroutine()
		
		writeNextToken() // write '{' symbol
		xmlWriter.writeEndTag("class")
		
	
	def compileClassVarDec()
		while isNextTokClassVarDec()
			xmlWriter.writeStartTag("classVarDec")
			writeNextToken()		// 'static'/'field'
			writeNextToken()		// type
			writeNextToken()		// varName
			
			while isNextTokComma()
				writeNextToken()	// ','
				writeNextToken()	// varName
			
			writeNextToken()		// ';'
			xmlWriter.writeEndTag("classVarDec")
	
	def isNextTokClassVarDec():bool
		return tokenizer.keyWord() == "static" or tokenizer.keyWord() == "field"
		
	def isNextTokComma():bool
		return tokenizer.keyWord() == ","
	
	def compileSubroutine()
	
		while isNextTokSubroutine()
			xmlWriter.writeStartTag("subroutineDec")
			writeNextToken()		// ('constructor'|'function'|'method')
			writeNextToken()		// ('void'|'type')
			writeNextToken()		// subroutineName
			writeNextToken()		// '('
			
			compileParameterList()
			
			writeNextToken()		// ')'
			
			compileSubroutineBody()
			
			xmlWriter.writeEndTag("subroutineDec")
			

	def isNextTokSubroutine():bool
		keyWord:string = tokenizer.keyWord()
		return  keyWord == "constructor" or keyWord == "function" or keyWord == "method" 
	
	def compileParameterList()
		xmlWriter.writeStartTag("parameterList")
		
		if isNextTokType()
			writeNextToken() // Type
			writeNextToken() // Var name
			
			while isNextTokComma()
				writeNextToken() // ','
				writeNextToken() // Type
				writeNextToken() // Var name
				
		xmlWriter.writeEndTag("parameterList")
		
	def isNextTokType():bool
		return tokenizer.tokenType() != "SYMBOL" // if not exist parm so token is type 
		
	def compileSubroutineBody()
		xmlWriter.writeStartTag("subroutineBody")
		
		writeNextToken() // '{'
		
		compileVarDec()
		compileStatements()
		
		writeNextToken() // '}'
	
		xmlWriter.writeEndTag("subroutineBody")
	
	def compileVarDec()
		while isNextTokVarDec()
			xmlWriter.writeStartTag("varDec")
			
			writeNextToken() // 'var'
			writeNextToken() // type
			writeNextToken() // var name
			
			while isNextTokComma()
				writeNextToken() // ','
				writeNextToken() // var name
				
			writeNextToken() // ';'
			xmlWriter.writeEndTag("varDec")
			
	def isNextTokVarDec():bool
		return tokenizer.keyWord() == "var"
		
	def compileStatements()
		xmlWriter.writeStartTag("statements")
		
		while isNextTokStatment()
			if isNextTokDo() 
				compileDo()
			if isNextTokLet()
				compileLet()
			if isNextTokWhile()
				compileWhile()
			if isNextTokReturn()
				compileReturn()
			if isNextTokIf()
				compileIf()
		
		xmlWriter.writeEndTag("statements")
		
	def isNextTokStatment():bool
		k:string = tokenizer.keyWord()
		return  k == "let" or k == "if" or k == "while" or k == "do" or k == "return"
	
	
	def isNextTokReturn():bool
		return tokenizer.keyWord() == "return"
	
	def isNextTokWhile():bool
		return tokenizer.keyWord() == "while"
		
	def isNextTokLet():bool
		return tokenizer.keyWord() == "let"
		
	def isNextTokDo():bool
		return tokenizer.keyWord() == "do"
		
	def isNextTokIf():bool
		return tokenizer.keyWord() == "if"
	
	def compileDo()
		xmlWriter.writeStartTag("doStatement")
		
		writeNextToken() // 'do'
		
		compileSubroutineCall()
		
		writeNextToken() // ';'
		
		xmlWriter.writeEndTag("doStatement")
	
	def compileLet()
		xmlWriter.writeStartTag("letStatement")
		
		writeNextToken() // 'let'
		writeNextToken() // varName
		
		if isNextTok("[")
			writeNextToken() // '['
			
			compileExpression()
			
			writeNextToken() // ']'
			
			
		writeNextToken() // '='
		
		compileExpression()
		
		writeNextToken() // ';'
		
		xmlWriter.writeEndTag("letStatement")
	
	def isNextTok(s:string):bool
		return tokenizer.keyWord() == s
	
	def compileWhile()
		xmlWriter.writeStartTag("whileStatement")
		
		writeNextToken() // 'while'
		writeNextToken() // '('
		
		compileExpression() 
		
		writeNextToken() // ')'
		writeNextToken() // '{'
		
		compileStatements()
		
		writeNextToken() // '}'
		
		xmlWriter.writeEndTag("whileStatement")
	
	def compileReturn()
		xmlWriter.writeStartTag("returnStatement")
		
		writeNextToken() // 'return'
		
		if isNextTokExpression()
			compileExpression()
		
		writeNextToken() // ';'
		
		xmlWriter.writeEndTag("returnStatement")
	
	def isNextTokExpression():bool
		return tokenizer.keyWord() != ")" and tokenizer.keyWord() != ";"
		
	
	def compileIf()
		xmlWriter.writeStartTag("ifStatement")
		
		writeNextToken() // 'if'
		writeNextToken() // '('
		
		compileExpression() 
		
		writeNextToken() // ')'
		writeNextToken() // '{'
		
		compileStatements() 
		
		writeNextToken() // '}'
		
		xmlWriter.writeEndTag("ifStatement")
	
	
	def compileExpression()
		xmlWriter.writeStartTag("expression")
		
		compileTerm()
		
		while isNextTokOp()
			writeNextToken() // op
			compileTerm()
			
		xmlWriter.writeEndTag("expression")
	
	def isNextTokOp():bool
		for o in op
			if o == tokenizer.keyWord()
				return true
		return false
		
	def	isNextTokUnaryOp():bool
		for o in unaryOp
			if o == tokenizer.keyWord()
				return true
		return false
		
	def isKeywordConstant():bool
		for c in keywordConstant
			if c == tokenizer.keyWord()
				return true
		return false
	
	def compileTerm()
		xmlWriter.writeStartTag("term")
		
									//integerConstant | stringConstant | keyWordConstant
		
		if isTypeNextTok("INT_CONST") or isTypeNextTok("STRING_CONST") or isKeywordConstant() 
			writeNextToken()		// write constant
			xmlWriter.writeEndTag("term")
			return
			
			
		if isNextTok("(")			// '(' expression ')'
			writeNextToken()		// '('
			compileExpression()
			writeNextToken()		// ')'
			xmlWriter.writeEndTag("term")
			return
			
		if isNextTokUnaryOp()		//unaryOp term
			writeNextToken()		// 'unaryOp'
			compileTerm() 
			xmlWriter.writeEndTag("term")
			return
		
		//  varName | varName '[' expression ']' | subroutineCall
		
		nextTokenType:string = tokenizer.tokenType()
		nextTokenValue:string = tokenizer.keyWord()
		
		nextNextValue:string = NextNextTok()
		
		
		if nextTokenType == "IDENTIFIER" and nextNextValue == "["
			xmlWriter.writeElement("IDENTIFIER",nextTokenValue) // write var name
			writeNextToken() // '['
				
			compileExpression()
				
			writeNextToken() // ']'
			
		else if nextTokenType == "IDENTIFIER" and nextNextValue == "("
			xmlWriter.writeElement("IDENTIFIER",nextTokenValue)	//'varName'
			writeNextToken() // '('
			compileExpressionList()
			writeNextToken() // ')'
			
		else if nextTokenType == "IDENTIFIER" and nextNextValue == "."
			xmlWriter.writeElement("IDENTIFIER",nextTokenValue)	// varName
			writeNextToken() // '.'
			writeNextToken() // subroutineName
			writeNextToken() // '('
			compileExpressionList()
			writeNextToken() // ')'	
			
		else if nextTokenType == "IDENTIFIER"
			xmlWriter.writeElement("IDENTIFIER",nextTokenValue) // write var name
			
		xmlWriter.writeEndTag("term")
	
	def NextNextTok():string
		tokenizer.advance()
		return tokenizer.keyWord()
	
	def isTypeNextTok(s:string):bool
		return tokenizer.tokenType() == s
	
	def compileExpressionList()
		xmlWriter.writeStartTag("expressionList")
		
		if isNextTokExpression() //TODO

			compileExpression()
			
			while isNextTokComma()
				writeNextToken() // ','
				compileExpression()
				
		xmlWriter.writeEndTag("expressionList")
	 
	
	def compileSubroutineCall(nextNextValue:string = "")
		//xmlWriter.writeStartTag("subroutineCall")
		
		if nextNextValue == ""
			writeNextToken() // subroutineName / className / varName
		else 
			xmlWriter.writeElement("IDENTIFIER" , nextNextValue)
		if not isNextTok(".")
			
			writeNextToken() // '('
			
			compileExpressionList()
			
			writeNextToken() // ')'
		
		else 
			writeNextToken() // '.' 
			writeNextToken() // subroutineName
			writeNextToken() // '('
			
			compileExpressionList()
			
			writeNextToken() // ')'
			
		//xmlWriter.writeEndTag("subroutineCall")
		
	