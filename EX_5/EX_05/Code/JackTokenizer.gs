// Baruch Baruch ID 200844843
// Baruch Gehler ID 866256
// Group number 44

class JackTokenizer

	KeywordArr:array of string = {"class", "constructor", "function", "method", "field", "static", "var", "int", "char", "boolean","void", "true", "false", "null", "this", "let", "do", "if", "else", "while", "return"}
	symbolArr:array of char = {'{', '}', '(', ')', '[', ']', '.', ',', ';', '+', '-', '*', '/', '&', '<', '>', '=', '~', '|'}


	file:FileStream
	currentToken:array of string
	buffer:string
	cur_char:char
	eof:bool
	
	//Opens the input file and gets ready to tokenize it.
	construct(inputFile:string)
		file = FileStream.open(inputFile, "r")
		buffer = ""
		currentToken = new array of string[2]
		cur_char = (char)file.getc()
		eof = file.eof()
	
	def hasMoreTokens():bool
		return not eof
		
		
	def q0()
		if eof
			return
		if cur_char.isalpha() or cur_char == '_'
			next_char()
			q1()
			return
		
		if cur_char.isdigit()
			next_char()
			q2()
			return
			
		if isSimbol(cur_char)
			next_char()
			q3()
			return
			
		if cur_char == '"'
			ignoreChar()
			q4()
			return
			
		if isSlash(cur_char)
			ignoreChar()
			q5()
			return
			
		ignoreChar()
		q0()
			
	def q1()
		if cur_char.isalpha() or cur_char == '_' or cur_char.isdigit()
			next_char()
			q1()
		
		else
			if isKeyword(buffer)
				setToken("KEYWORD", buffer)
			else
				setToken("IDENTIFIER", buffer) 
				
	def q2()
		if cur_char.isdigit()
			next_char()
			q2()
		else
			setToken("INT_CONST", buffer)
		
	def q3()
		setToken("SYMBOL", buffer)
		
	def q4()
		if cur_char != '"'
			next_char()
			q4()
		else
			ignoreChar()
			setToken("STRING_CONST", buffer)
			
	def q5()
		if isSlash(cur_char)
			ignoreChar()
			q6()
			return
		
		if isAsterisk(cur_char)
			ignoreChar()
			q7()
			return
		
		setToken("SYMBOL", "/")
		
		
	def q6()
		if isNewline(cur_char)
			ignoreChar()
			q0()
		else
			ignoreChar()
			q6()
			
	def q7()
		if isAsterisk(cur_char)
			ignoreChar()
			q8()
		else
			ignoreChar()
			q7()
			
	def q8()
		if isSlash(cur_char)
			ignoreChar()
			q0()
		else
			ignoreChar()
			q7()
		
			
	def next_char()
		buffer += string.nfill(1,cur_char)
		if file.eof()
			eof = true
		else
			cur_char = (char)file.getc()
		
	def ignoreChar()
		if file.eof()
			eof = true
		else
			cur_char = (char)file.getc()
		
	def isKeyword(word:string):bool
		for w in KeywordArr
			if w == word
				return true
		return false
			
	def isSimbol(symbol:char):bool
		if symbol == '/'
			return false
		for c in symbolArr
			if c == symbol
				return true
		return false
		
	def isSlash(symbol:char):bool
		return symbol == '/'
	
	def isAsterisk(symbol:char):bool
		return symbol == '*'
		
	def isNewline(symbol:char):bool
		return symbol == '\n' or symbol == '\r'
			
	def setToken(tokenType:string, tokenValue:string)
		currentToken[0] = tokenType
		currentToken[1] = tokenValue
		
	def advance()
		buffer = ""
		currentToken[1] = ""
		currentToken[0] = ""
		q0()
	
	def tokenType():string
		return currentToken[0]
	
	def keyWord():string
		return currentToken[1]
		
	def symbol():string
		return currentToken[1]
		
	def identifier():string
		return currentToken[1]
	
	def intVal():int
		return int.parse(currentToken[1])
	
	def stringVal():string
		return (currentToken[1])[1:-1]
		

	
	