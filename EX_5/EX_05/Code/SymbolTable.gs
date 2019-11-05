class symbolDetails

	construct(t:string, k:string, i:int)
		type = t
		kind = k
		index = i
		
	type:string
	kind:string
	index:int

class SymbolTable

	staticCounter:int
	fieldCounter:int
	
	varCounter:int
	argCounter:int
	

	globalScope:dict of string,symbolDetails
	subroutinesScope:dict of string,symbolDetails
	
	construct()
		globalScope = new dict of string,symbolDetails
		subroutinesScope = new dict of string,symbolDetails
		staticCounter = 0
		fieldCounter = 0
		varCounter = 0
		argCounter = 0
		
	def startSubroutine()
		subroutinesScope.clear()
		varCounter = 0
		argCounter = 0
	
	def define(name:string, type:string, kind:string)
		if kind.ascii_up() == "STATIC" or kind.ascii_up() == "FIELD"
			//print kind
			globalScope[name] = new symbolDetails(type,kind,increaseCount(kind))
			
		if kind.ascii_up() == "VAR" or kind.ascii_up()  == "ARG"
			subroutinesScope[name] = new symbolDetails(type,kind,increaseCount(kind))	

	
	def increaseCount(kind:string):int
		res:int = -1
		if kind.ascii_up() == "STATIC"
			res = staticCounter
			staticCounter++
			
		if kind.ascii_up() == "FIELD"
			res = fieldCounter
			fieldCounter++

		if kind.ascii_up() == "VAR"
			res = varCounter
			varCounter++
			
		if kind.ascii_up() == "ARG"
			res = argCounter
			argCounter++

		return res
		
	def varCount(kind:string):int
		res:int = -1
		if kind.ascii_up() == "STATIC"
			res = staticCounter
			
		if kind.ascii_up() == "FIELD"
			res = fieldCounter

		if kind.ascii_up() == "VAR"
			res = varCounter
			
		if kind.ascii_up() == "ARG"
			res = argCounter

		return res
		
	def kindOf(name:string):string
		if globalScope.has_key(name)
			//print globalScope[name].kind
			return globalScope[name].kind 
		
		if subroutinesScope.has_key(name)
			//print subroutinesScope[name].kind
			return subroutinesScope[name].kind
			
		return "NONE"
	
	def typeOf(name:string):string
		res:string = ""
		if globalScope.has_key(name)
			res = globalScope[name].type 
		
		if subroutinesScope.has_key(name)
			res = subroutinesScope[name].type
		
		return res

		
	def indexOf(name:string):int
		res:int = -1
		
		if globalScope.has_key(name)
			res = globalScope[name].index 
		
		if subroutinesScope.has_key(name)
			res = subroutinesScope[name].index
		
		return res	
		
	def isInSymbolTables(name:string):bool
		return globalScope.has_key(name) or subroutinesScope.has_key(name)
	