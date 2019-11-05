
class CompilationEngine
	
	tokenizer:JackTokenizer
	vmWriter:VMWriter
	symbolTable:SymbolTable
	
	funcName:string
	funcType:string
	className:string
	
	ifCounter:int
	whileCounter:int
	
	//xmlWriter:XMLwriter
	
	op:array of string = {"+", "-", "*", "/", "|", "=", "<", ">", "&"}
	unaryOp:array of string = {"-", "~"}
	keywordConstant:array of string = {"true", "false", "null", "this"}
	
	construct(inputFile:string, outputFileXML:string, outputFileVM:string)
		tokenizer = new JackTokenizer(inputFile)
		vmWriter = new VMWriter(outputFileVM)
		//xmlWriter = new XMLwriter(outputFileXML)
		symbolTable = new SymbolTable()
		tokenizer.advance()
		
		ifCounter = 0
		whileCounter = 0
		
	def compileClass()
		//xmlWriter.writeStartTag("class")
		writeNextToken() // write class keyWord
		
		className = tokenizer.keyWord()
		
		writeNextToken() // write className
		writeNextToken() // write '{' symbol
		
		compileClassVarDec()
		compileSubroutine()
		
		writeNextToken() // write '{' symbol
		//xmlWriter.writeEndTag("class")
		
	def compileClassVarDec()
		kind:string
		type:string
		
		while isNextTokClassVarDec()
			//xmlWriter.writeStartTag("classVarDec")
			
			kind = tokenizer.keyWord() // static/field
			
			writeNextToken()		// 'static'/'field'
			
			type = tokenizer.keyWord() // type
			
			writeNextToken()		// type
			
			symbolTable.define(tokenizer.keyWord(), type, kind)
			
			writeNextToken()		// varName
			
			while isNextTokComma()
				writeNextToken()	// ','
				
				symbolTable.define(tokenizer.keyWord(), type, kind)
				
				writeNextToken()	// varName
			
			writeNextToken()		// ';'
			//xmlWriter.writeEndTag("classVarDec")

	def compileSubroutine()
	
		while isNextTokSubroutine()
			//xmlWriter.writeStartTag("subroutineDec")
			
			symbolTable.startSubroutine()
			//ifCounter = 0
			//whileCounter = 0

			funcType = tokenizer.keyWord() //('constructor'|'function'|'method')
			writeNextToken()		// ('constructor'|'function'|'method')
			writeNextToken()		//  return type ('void'|'type')
			
			
			
			funcName = className + "." + tokenizer.keyWord() //subroutineName
			
			//print funcName + "	" + ifCounter.to_string()
			
			writeNextToken()		// subroutineName
			writeNextToken()		// '('
			
			compileParameterList()
			
			writeNextToken()		// ')'
			
			compileSubroutineBody()
			
			//xmlWriter.writeEndTag("subroutineDec")
			

	def compileParameterList()
		//xmlWriter.writeStartTag("parameterList")
		
		type:string
		
		if funcType == "method"
			symbolTable.define("this", "self", "ARG") //TODO
		
		if isNextTokType()
		
			type = tokenizer.keyWord() // type
			
			writeNextToken() // Type
			
			symbolTable.define(tokenizer.keyWord(), type, "ARG")
			
			writeNextToken() // Var name
			
			
			while isNextTokComma()
				writeNextToken() // ','
				
				type = tokenizer.keyWord()
				
				writeNextToken() // Type
				
				symbolTable.define(tokenizer.keyWord(), type, "ARG")
				
				writeNextToken() // Var name
				
		//xmlWriter.writeEndTag("parameterList")
		
	def compileSubroutineBody()
		//xmlWriter.writeStartTag("subroutineBody")
		
		writeNextToken() // '{'
		
		compileVarDec()
		
		vmWriter.writeFunction(funcName, symbolTable.varCount("VAR")) // TODO
		
		if funcType == "constructor"
			vmWriter.writePush("constant", symbolTable.varCount("FIELD"))
			vmWriter.writeCall("Memory.alloc", 1)
			vmWriter.writePop("pointer", 0) // 'this'
			
		if funcType == "method"
			vmWriter.writePush("argument", 0)
			vmWriter.writePop("pointer", 0)
		
		compileStatements()
		
		writeNextToken() // '}'
	
		//xmlWriter.writeEndTag("subroutineBody")
	
	def compileVarDec()
	
		type:string
		
		while isNextTokVarDec()
			//xmlWriter.writeStartTag("varDec")
			
			writeNextToken() // 'var'
			
			type = tokenizer.keyWord()
			
			writeNextToken() // type
			
			symbolTable.define(tokenizer.keyWord(), type, "VAR")
			
			writeNextToken() // var name
			
			while isNextTokComma()
				writeNextToken() // ','
				
				symbolTable.define(tokenizer.keyWord(), type, "VAR")
				
				writeNextToken() // var name
				
			writeNextToken() // ';'
			//xmlWriter.writeEndTag("varDec")

		
	def compileStatements()
		//xmlWriter.writeStartTag("statements")
		
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
		
		//xmlWriter.writeEndTag("statements")
		
	def compileDo()
		//xmlWriter.writeStartTag("doStatement")
		
		writeNextToken() // 'do'
		
		compileSubroutineCall()
		
		vmWriter.writePop("temp", 0)
		
		writeNextToken() // ';'
		
		//xmlWriter.writeEndTag("doStatement")
		
	
	def compileLet()
		//xmlWriter.writeStartTag("letStatement")
		
		writeNextToken() // 'let'
		
		varName:string = tokenizer.keyWord()
		isArr:bool = false
		
		writeNextToken() // varName
		
		if isNextTok("[")
			isArr = true
			writeNextToken() // '['
			
			compileExpression()
			
			vmWriter.writePush(kindToSegment(symbolTable.kindOf(varName)),symbolTable.indexOf(varName))
			vmWriter.writeArithmetic("add")
			
			writeNextToken() // ']'
			
			
		writeNextToken() // '='
		
		compileExpression()
		
		if isArr
			vmWriter.writePop("temp", 0)
			vmWriter.writePop("pointer", 1)
			vmWriter.writePush("temp", 0)
			vmWriter.writePop("that", 0)

		else
			vmWriter.writePop(kindToSegment(symbolTable.kindOf(varName)),symbolTable.indexOf(varName))
		
		writeNextToken() // ';'
		
		//xmlWriter.writeEndTag("letStatement")
	
	
	def compileWhile()
		//xmlWriter.writeStartTag("whileStatement")
		
		counterStr:string = whileCounter.to_string()
		whileCounter++
		vmWriter.writeLabel("WHILE_EXP" + counterStr)
		
		writeNextToken() // 'while'
		writeNextToken() // '('
		
		compileExpression() 
		
		vmWriter.writeArithmetic("not")
		vmWriter.writeIf("WHILE_END" + counterStr)
		
		writeNextToken() // ')'
		writeNextToken() // '{'
		
		compileStatements()
		
		vmWriter.writeGoto("WHILE_EXP" + counterStr)
		vmWriter.writeLabel("WHILE_END" + counterStr)

		writeNextToken() // '}'
		
		//xmlWriter.writeEndTag("whileStatement")
		
	
	

	def compileReturn()
		//xmlWriter.writeStartTag("returnStatement")
		
		writeNextToken() // 'return'
		
		if isNextTokExpression()
			compileExpression()
		else
			vmWriter.writePush("constant", 0)
		
		vmWriter.writeReturn()
		
		writeNextToken() // ';'
		
		//xmlWriter.writeEndTag("returnStatement")

	def compileIf()
		tempIfCounter:int = ifCounter
		ifCounter++ //+++++++++++++++++++++++++++++++++++++++++++ TODO
		//xmlWriter.writeStartTag("ifStatement")
		
		writeNextToken() // 'if'
		writeNextToken() // '('
		
		compileExpression() 
		
		writeNextToken() // ')'
		writeNextToken() // '{'
		
		vmWriter.writeIf("IF_TRUE" + tempIfCounter.to_string())
		vmWriter.writeGoto("IF_FALSE" + tempIfCounter.to_string())
		vmWriter.writeLabel("IF_TRUE" + tempIfCounter.to_string())
		
		compileStatements() 
		
		writeNextToken() // '}'
		
		if isNextTok("else")
		
			vmWriter.writeGoto("IF_END" + tempIfCounter.to_string())
			vmWriter.writeLabel("IF_FALSE" + tempIfCounter.to_string())
			
			writeNextToken() // 'else
			writeNextToken() // '{'
			
			compileStatements()
			
			writeNextToken() //'}'
			
			vmWriter.writeLabel("IF_END" + tempIfCounter.to_string())
			
		else 
			vmWriter.writeLabel("IF_FALSE" + tempIfCounter.to_string())
			
		//xmlWriter.writeEndTag("ifStatement")

	
	
	def compileExpression()
		op:string
		//xmlWriter.writeStartTag("expression")
		
		compileTerm()
		
		while isNextTokOp()
			
			op = tokenizer.keyWord()
			
			//print className
			//print op
			
			writeNextToken() // op
			compileTerm()
			
			writeOp(op)
			
		//xmlWriter.writeEndTag("expression")
	
	def compileTerm()
		nLocals:int = 0
		//xmlWriter.writeStartTag("term")
		
									//integerConstant | stringConstant | keyWordConstant
									
		if isTypeNextTok("INT_CONST")
			
			vmWriter.writePush("constant",int. parse(tokenizer.keyWord()))
			
			writeNextToken()		// write constant
			//xmlWriter.writeEndTag("term")
			return
			
		if  isTypeNextTok("STRING_CONST")
			s:string = tokenizer.keyWord()
			
			vmWriter.writePush("constant", s.length)
			vmWriter.writeCall("String.new", 1)
			
			for i:int = 0 to (s.length - 1)
				vmWriter.writePush("constant", (int)s[i])
				vmWriter.writeCall("String.appendChar", 2)
				
			writeNextToken()		// write constant
			//xmlWriter.writeEndTag("term")
			return

		if isKeywordConstant() 
			
			word:string = tokenizer.keyWord()
			if word == "this"
				vmWriter.writePush("pointer", 0)
			else 
				vmWriter.writePush("constant", 0)
				if word == "true"
				vmWriter.writeArithmetic("not")
				
			writeNextToken()		// write constant
			//xmlWriter.writeEndTag("term")
			return
			
			
		if isNextTok("(")			// '(' expression ')'
			writeNextToken()		// '('
			compileExpression()
			writeNextToken()		// ')'
			//xmlWriter.writeEndTag("term")
			return
			
		if isNextTokUnaryOp()		//unaryOp term
			op:string = tokenizer.keyWord()
			
			writeNextToken()		// 'unaryOp'
			compileTerm() 
			
			if op == "-"
				vmWriter.writeArithmetic("neg")
			if op == "~"
				vmWriter.writeArithmetic("not")
				
			//xmlWriter.writeEndTag("term")
			return
		
		//  varName | varName '[' expression ']' | subroutineCall
		
		nextTokenType:string = tokenizer.tokenType()
		nextTokenValue:string = tokenizer.keyWord()
	
		nextNextValue:string = NextNextTok()
		//print nextNextValue
		
		if nextTokenType == "IDENTIFIER" and nextNextValue == "["
			//xmlWriter.writeElement("IDENTIFIER",nextTokenValue) // write var name
			
			writeNextToken() // '['
				
			compileExpression()
			
			vmWriter.writePush(kindToSegment(symbolTable.kindOf(nextTokenValue)),symbolTable.indexOf(nextTokenValue))
			vmWriter.writeArithmetic("add")
			vmWriter.writePop("pointer", 1)
			vmWriter.writePush("that", 0)
			

				
			writeNextToken() // ']'
			
		else if nextTokenType == "IDENTIFIER" and nextNextValue == "("
			//xmlWriter.writeElement("IDENTIFIER",nextTokenValue)	//'varName'
			
			nLocals++
			vmWriter.writePush("pointer", 0)
			writeNextToken() // '('
			nLocals += compileExpressionList()
			writeNextToken() // ')'
			vmWriter.writeCall(className + "." + nextTokenValue, nLocals)
			

		else if nextTokenType == "IDENTIFIER" and nextNextValue == "."
			subroutineName:string
			typeName:string = nextTokenValue
			//xmlWriter.writeElement("IDENTIFIER",nextTokenValue)	// varName
			writeNextToken() // '.'
			
			subroutineName = tokenizer.keyWord()
			
			if symbolTable.isInSymbolTables(typeName)
				vmWriter.writePush(kindToSegment(symbolTable.kindOf(typeName)), symbolTable.indexOf(typeName))
				nLocals++
				subroutineName = symbolTable.typeOf(typeName) + "." + subroutineName
			
			else 
				subroutineName = typeName + "." +subroutineName
				
			writeNextToken() // subroutineName
			
			
			writeNextToken() // '('
			nLocals += compileExpressionList()
			writeNextToken() // ')'	
			vmWriter.writeCall(subroutineName, nLocals)
			

		else if nextTokenType == "IDENTIFIER"
			//xmlWriter.writeElement("IDENTIFIER",nextTokenValue) // write var name
			
			vmWriter.writePush(kindToSegment(symbolTable.kindOf(nextTokenValue)),symbolTable.indexOf(nextTokenValue))
			
		//xmlWriter.writeEndTag("term")

	
	def compileExpressionList():int
		//xmlWriter.writeStartTag("expressionList")
		numOfExp:int = 0 
		if isNextTokExpression() //TODO
			numOfExp++
			compileExpression()
			
			while isNextTokComma()
				writeNextToken() // ','
				numOfExp++
				compileExpression()
				
		//xmlWriter.writeEndTag("expressionList")
		return numOfExp

	def compileSubroutineCall()
		subroutineName:string
		typeName:string
		nLocals:int = 0
		
		typeName = tokenizer.keyWord()
			
		writeNextToken() // subroutineName / className / varName
			
		if not isNextTok(".")
			
			writeNextToken() // '('
			vmWriter.writePush("pointer", 0)
			nLocals++
			subroutineName = className + "." + typeName
			nLocals += compileExpressionList()
			
			writeNextToken() // ')'
		
		else // subroutine of another  class
			writeNextToken() // '.' 
			subroutineName = tokenizer.keyWord()
			if symbolTable.isInSymbolTables(typeName)
				vmWriter.writePush(kindToSegment(symbolTable.kindOf(typeName)), symbolTable.indexOf(typeName))
				nLocals++
				subroutineName = symbolTable.typeOf(typeName) + "." + subroutineName
			
			else 
				subroutineName = typeName + "." +subroutineName
				
			writeNextToken() // subroutineName
			
			writeNextToken() // '('
			
			nLocals += compileExpressionList()
			
			writeNextToken() // ')'
			
		vmWriter.writeCall(subroutineName, nLocals)

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==
		
	def isNextTokClassVarDec():bool
		return tokenizer.keyWord() == "static" or tokenizer.keyWord() == "field"
		
	def isNextTokComma():bool
		return tokenizer.keyWord() == ","
	
	def isNextTokSubroutine():bool
		keyWord:string = tokenizer.keyWord()
		return  keyWord == "constructor" or keyWord == "function" or keyWord == "method" 
		
	def isNextTokType():bool
		return tokenizer.tokenType() != "SYMBOL" // if not exist parm so token is type 
	
	def isNextTokVarDec():bool
		return tokenizer.keyWord() == "var"
		
	def isNextTokExpression():bool
		return tokenizer.keyWord() != ")" and tokenizer.keyWord() != ";"
		
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
		
	def isNextTok(s:string):bool
		return tokenizer.keyWord() == s
		
	def writeOp(op:string)
	
		if op == "+"
			vmWriter.writeArithmetic("add")
		if op == "-"
			vmWriter.writeArithmetic("sub")
		if op == "*"
			vmWriter.writeCall("Math.multiply", 2)
		if op == "/"
			vmWriter.writeCall("Math.divide", 2)
		if op == "|"
			vmWriter.writeArithmetic("or")
		if op == "&"
			vmWriter.writeArithmetic("and")
		if op == "="
			vmWriter.writeArithmetic("eq")
		if op == "<"
			vmWriter.writeArithmetic("lt")
		if op == ">"
			vmWriter.writeArithmetic("gt")
		
	def nextToken()
		tokenizer.advance()
		
	//def writeTerminal()
		//xmlWriter.writeElement(tokenizer.tokenType(), tokenizer.keyWord())
		
	def writeNextToken()
		//writeTerminal()
		nextToken()

	def isNextTokOp():bool
		for o in op
			if o == tokenizer.keyWord()
				//print tokenizer.keyWord() + "	true" 
				return true
		//print tokenizer.keyWord() + "	false" 
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
		
	def NextNextTok():string
		tokenizer.advance()
		return tokenizer.keyWord()
	
	def isTypeNextTok(s:string):bool
		return tokenizer.tokenType() == s

	def kindToSegment(kind:string):string
		if kind == "VAR"
			return "local"
		if kind == "ARG"
			return "argument"
		if kind == "static"
			return "static"
		//print kind
		return "this"
		