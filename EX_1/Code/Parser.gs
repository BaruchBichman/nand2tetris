[indent=4]

// Baruch Baruch ID 200844843
// Baruch Gehler ID 866256
// Group number 44

class Parser

    construct(aPathInputFile:string)
        pathInputFile=aPathInputFile
        file = FileStream.open(pathInputFile, "r")

    def hasMoreCommands():bool
        return not file.eof()

    def advance()
        currentCommand = file.read_line()

    def commandType():string
        if currentCommand == null
            return ""
        if currentCommand.has_prefix("add")
            return "C_ARITHMETIC"
        if currentCommand.has_prefix("sub")
            return "C_ARITHMETIC"
        if currentCommand.has_prefix("neg")
            return "C_ARITHMETIC"
        if currentCommand.has_prefix("eq")
            return "C_ARITHMETIC"
        if currentCommand.has_prefix("gt")
            return "C_ARITHMETIC"
        if currentCommand.has_prefix("lt")
            return "C_ARITHMETIC"
        if currentCommand.has_prefix("and")
            return "C_ARITHMETIC"
        if currentCommand.has_prefix("or")
            return "C_ARITHMETIC"
        if currentCommand.has_prefix("not")
            return "C_ARITHMETIC"
            
        if currentCommand.has_prefix("push")
            return "C_PUSH"
        if currentCommand.has_prefix("pop")
            return "C_POP"
        return ""
        
    def arg1():string
        if commandType()== "C_ARITHMETIC"
            return currentCommand.split(" ")[0]
        else
            return currentCommand.split(" ")[1]

    
    def arg2():int
        return int.parse(currentCommand.split(" ")[2])

    def getCurrentCommand():string
        return currentCommand
    
    pathInputFile:string
    file:FileStream
    currentCommand:string
