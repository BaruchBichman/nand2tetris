
class CompilationEngine
	
	tokenizer:JackTokenizer
	vmWriter:VMWriter
	symbolTable:SymbolTable
	
	funcName:string
	funcType:string
	className:string
	
	ifCounter:int
	whileCounter:int
	
	op:array of string = {"+", "-", "*", "/", "|", "=", "<", ">", "&"}
	unaryOp:array of string = {"-", "~"}
	keywordConstant:array of string = {"true", "false", "null", "this"}
	
	construct(inputFile:string, outputFileXML:string, outputFileVM:string)
		tokenizer = new JackTokenizer(inputFile)
		vmWriter = new VMWriter(outputFileVM)
		symbolTable = new SymbolTable()
		tokenizer.advance()
		
		ifCounter = 0
		whileCounter = 0
		
	def compileClass()
		advance() // write class keyWord
		
		className = tokenizer.keyWord()
		
		advance() // write className
		advance() // write '{' symbol
		
		compileClassVarDec()
		compileSubroutine()
		
		advance() // write '{' symbol

	def compileClassVarDec()
		kind:string
		type:string
		
		while isNextTokClassVarDec()

			kind = tokenizer.keyWord() // static/field
			
			advance()		// 'static'/'field'
			
			type = tokenizer.keyWord() // type
			
			advance()		// type
			
			symbolTable.define(tokenizer.keyWord(), type, kind)
			
			advance()		// varName
			
			while isNextTokComma()
				advance()	// ','
				
				symbolTable.define(tokenizer.keyWord(), type, kind)
				
				advance()	// varName
			
			advance()		// ';'

	def compileSubroutine()
	
		while isNextTokSubroutine()
		
			symbolTable.startSubroutine()
			//ifCounter = 0
			//whileCounter = 0

			funcType = tokenizer.keyWord() //('constructor'|'function'|'method')
			advance()		// ('constructor'|'function'|'method')
			advance()		//  return type ('void'|'type')
			
			
			
			funcName = className + "." + tokenizer.keyWord() //subroutineName
			
			advance()		// subroutineName
			advance()		// '('
			
			compileParameterList()
			
			advance()		// ')'
			
			compileSubroutineBody()
			
		
	def compileParameterList()

		type:string
		
		if funcType == "method"
			symbolTable.define("this", "self", "ARG") //TODO
		
		if isNextTokType()
		
			type = tokenizer.keyWord() // type
			
			advance() // Type
			
			symbolTable.define(tokenizer.keyWord(), type, "ARG")
			
			advance() // Var name
			
			
			while isNextTokComma()
				advance() // ','
				
				type = tokenizer.keyWord()
				
				advance() // Type
				
				symbolTable.define(tokenizer.keyWord(), type, "ARG")
				
				advance() // Var name
				
		
	def compileSubroutineBody()

		advance() // '{'
		
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
		
		advance() // '}'
	
	
	def compileVarDec()
	
		type:string
		
		while isNextTokVarDec()

			advance() // 'var'
			
			type = tokenizer.keyWord()
			
			advance() // type
			
			symbolTable.define(tokenizer.keyWord(), type, "VAR")
			
			advance() // var name
			
			while isNextTokComma()
				advance() // ','
				
				symbolTable.define(tokenizer.keyWord(), type, "VAR")
				
				advance() // var name
				
			advance() // ';'


	def compileStatements()

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
		
		
	def compileDo()

		advance() // 'do'
		
		compileSubroutineCall()
		
		vmWriter.writePop("temp", 0)
		
		advance() // ';'
		
	
	def compileLet()

		advance() // 'let'
		
		varName:string = tokenizer.keyWord()
		isArr:bool = false
		
		advance() // varName
		
		if isNextTok("[")
			isArr = true
			advance() // '['
			
			compileExpression()
			
			vmWriter.writePush(kindToSegment(symbolTable.kindOf(varName)),symbolTable.indexOf(varName))
			vmWriter.writeArithmetic("add")
			
			advance() // ']'
			
			
		advance() // '='
		
		compileExpression()
		
		if isArr
			vmWriter.writePop("temp", 0)
			vmWriter.writePop("pointer", 1)
			vmWriter.writePush("temp", 0)
			vmWriter.writePop("that", 0)

		else
			vmWriter.writePop(kindToSegment(symbolTable.kindOf(varName)),symbolTable.indexOf(varName))
		
		advance() // ';'
		
	def compileWhile()

		counterStr:string = whileCounter.to_string()
		whileCounter++
		vmWriter.writeLabel("WHILE_EXP" + counterStr)
		
		advance() // 'while'
		advance() // '('
		
		compileExpression() 
		
		vmWriter.writeArithmetic("not")
		vmWriter.writeIf("WHILE_END" + counterStr)
		
		advance() // ')'
		advance() // '{'
		
		compileStatements()
		
		vmWriter.writeGoto("WHILE_EXP" + counterStr)
		vmWriter.writeLabel("WHILE_END" + counterStr)

		advance() // '}'
		

	def compileReturn()

		advance() // 'return'
		
		if isNextTokExpression()
			compileExpression()
		else
			vmWriter.writePush("constant", 0)
		
		vmWriter.writeReturn()
		
		advance() // ';'
		
		
	def compileIf()
		tempIfCounter:int = ifCounter
		ifCounter++ 

		advance() // 'if'
		advance() // '('
		
		compileExpression() 
		
		advance() // ')'
		advance() // '{'
		
		vmWriter.writeIf("IF_TRUE" + tempIfCounter.to_string())
		vmWriter.writeGoto("IF_FALSE" + tempIfCounter.to_string())
		vmWriter.writeLabel("IF_TRUE" + tempIfCounter.to_string())
		
		compileStatements() 
		
		advance() // '}'
		
		if isNextTok("else")
		
			vmWriter.writeGoto("IF_END" + tempIfCounter.to_string())
			vmWriter.writeLabel("IF_FALSE" + tempIfCounter.to_string())
			
			advance() // 'else
			advance() // '{'
			
			compileStatements()
			
			advance() //'}'
			
			vmWriter.writeLabel("IF_END" + tempIfCounter.to_string())
			
		else 
			vmWriter.writeLabel("IF_FALSE" + tempIfCounter.to_string())
			
	
	def compileExpression()
		op:string

		compileTerm()
		
		while isNextTokOp()
			
			op = tokenizer.keyWord()

			advance() // op
			compileTerm()
			
			writeOp(op)
			
	
	def compileTerm()
		nLocals:int = 0
							
		if isTypeNextTok("INT_CONST") //integerConstant | stringConstant | keyWordConstant
			
			vmWriter.writePush("constant",int. parse(tokenizer.keyWord()))
			
			advance()		// write constant

			return
			
		if  isTypeNextTok("STRING_CONST")
			s:string = tokenizer.keyWord()
			
			vmWriter.writePush("constant", s.length)
			vmWriter.writeCall("String.new", 1)
			
			for i:int = 0 to (s.length - 1)
				vmWriter.writePush("constant", (int)s[i])
				vmWriter.writeCall("String.appendChar", 2)
				
			advance()		// write constant

			return

		if isKeywordConstant() 
			
			word:string = tokenizer.keyWord()
			if word == "this"
				vmWriter.writePush("pointer", 0)
			else 
				vmWriter.writePush("constant", 0)
				if word == "true"
				vmWriter.writeArithmetic("not")
				
			advance()		// write constant

			return
			
			
		if isNextTok("(")			// '(' expression ')'
			advance()		// '('
			compileExpression()
			advance()		// ')'

			return
			
		if isNextTokUnaryOp()		//unaryOp term
			op:string = tokenizer.keyWord()
			
			advance()		// 'unaryOp'
			compileTerm() 
			
			if op == "-"
				vmWriter.writeArithmetic("neg")
			if op == "~"
				vmWriter.writeArithmetic("not")
				
			return
		
		//  varName | varName '[' expression ']' | subroutineCall
		
		nextTokenType:string = tokenizer.tokenType()
		nextTokenValue:string = tokenizer.keyWord()
	
		nextNextValue:string = NextNextTok()
		//print nextNextValue
		
		if nextTokenType == "IDENTIFIER" and nextNextValue == "["

			advance() // '['
				
			compileExpression()
			
			vmWriter.writePush(kindToSegment(symbolTable.kindOf(nextTokenValue)),symbolTable.indexOf(nextTokenValue))
			vmWriter.writeArithmetic("add")
			vmWriter.writePop("pointer", 1)
			vmWriter.writePush("that", 0)
		
			advance() // ']'
			
		else if nextTokenType == "IDENTIFIER" and nextNextValue == "("

			nLocals++
			vmWriter.writePush("pointer", 0)
			advance() // '('
			nLocals += compileExpressionList()
			advance() // ')'
			vmWriter.writeCall(className + "." + nextTokenValue, nLocals)
			

		else if nextTokenType == "IDENTIFIER" and nextNextValue == "."
			subroutineName:string
			typeName:string = nextTokenValue

			advance() // '.'
			
			subroutineName = tokenizer.keyWord()
			
			if symbolTable.isInSymbolTables(typeName)
				vmWriter.writePush(kindToSegment(symbolTable.kindOf(typeName)), symbolTable.indexOf(typeName))
				nLocals++
				subroutineName = symbolTable.typeOf(typeName) + "." + subroutineName
			
			else 
				subroutineName = typeName + "." +subroutineName
				
			advance() // subroutineName
			
			
			advance() // '('
			nLocals += compileExpressionList()
			advance() // ')'	
			vmWriter.writeCall(subroutineName, nLocals)
			

		else if nextTokenType == "IDENTIFIER"

			vmWriter.writePush(kindToSegment(symbolTable.kindOf(nextTokenValue)),symbolTable.indexOf(nextTokenValue))
			
			
	def compileExpressionList():int

		numOfExp:int = 0 
		if isNextTokExpression() //TODO
			numOfExp++
			compileExpression()
			
			while isNextTokComma()
				advance() // ','
				numOfExp++
				compileExpression()
				
		return numOfExp

	def compileSubroutineCall()
		subroutineName:string
		typeName:string
		nLocals:int = 0
		
		typeName = tokenizer.keyWord()
			
		advance() // subroutineName / className / varName
			
		if not isNextTok(".")
			
			advance() // '('
			vmWriter.writePush("pointer", 0)
			nLocals++
			subroutineName = className + "." + typeName
			nLocals += compileExpressionList()
			
			advance() // ')'
		
		else // subroutine of another  class
			advance() // '.' 
			subroutineName = tokenizer.keyWord()
			if symbolTable.isInSymbolTables(typeName)
				vmWriter.writePush(kindToSegment(symbolTable.kindOf(typeName)), symbolTable.indexOf(typeName))
				nLocals++
				subroutineName = symbolTable.typeOf(typeName) + "." + subroutineName
			
			else 
				subroutineName = typeName + "." +subroutineName
				
			advance() // subroutineName
			
			advance() // '('
			
			nLocals += compileExpressionList()
			
			advance() // ')'
			
		vmWriter.writeCall(subroutineName, nLocals)

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
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
		
	def advance()
		tokenizer.advance()
		
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

		return "this"
		