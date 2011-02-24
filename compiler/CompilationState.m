#import "CompilationState.h"
#import "Bytecode.h"

@implementation CompilationState

@synthesize impl;
@synthesize stringtable;
@synthesize ip;
@synthesize tokens;
@synthesize errMgr;

+ (id) newCompilationState:(ErrorManager *)anErrMgr
                      name:(NSString *)aName
                    stream:(ANTLRCommonTokenStream *)theTokens
{
    return [[CompilationState alloc] init:anErrMgr name:aName stream:theTokens];
}

- (id) init:(ErrorManager *)anErrMgr name:(NSString *)aName stream:(ANTLRCommonTokenStream *)theTokens
{
    if (self = [super init]) {
        impl = [[CompiledST alloc] init];
        stringtable = [[StringTable alloc] init];
        ip = 0;
        errMgr = anErrMgr;
        tokens = theTokens;
        impl.name = aName;
    }
    return self;
}

- (NSInteger) defineString:(NSString *)s
{
    return [stringtable addObject:s];
}

- (void) refAttr:(ANTLRCommonToken *)templateToken tree:(ANTLRCommonTree *)aTree
{
    NSString *name = [aTree getText];
    if (impl.formalArguments != nil && [impl.formalArguments objectForKey:name] != nil) {
        FormalArgument *arg = [impl.formalArguments objectForKey:name];
        NSInteger index = [arg getIndex];
        [self emit1:aTree opcode:Bytecode.INSTR_LOAD_LOCAL arg:index];
    }
    else {
        if ([[Interpreter predefinedAnonSubtemplateAttributes] containsObject:name]) {
            [errMgr compileTimeError:NO_SUCH_ATTRIBUTE templateToken:templateToken t:aTree.token];
            [self emit:aTree opcode:Bytecode.INSTR_NULL];
        }
        else {
            [self emit1:aTree opcode:Bytecode.INSTR_LOAD_ATTR s:name];
        }
    }
}

- (void) setOption:(ANTLRCommonTree *)aTree
{
    NSInteger O;
    O = [[Compiler getSupportedOptions] objectForKey:[aTree getText]];
    [self emit1:aTree opcode:Bytecode.INSTR_STORE_OPTION arg:O];
}

- (void) func:(ANTLRCommonToken *)templateToken tree:(ANTLRCommonTree *)aTree
{
    NSNumber * funcBytecode = [[Compiler funcs] objectForKey:[aTree getText]];
    if (funcBytecode == nil) {
        [errMgr compileTimeError:NO_SUCH_FUNCTION templateToken:templateToken t:aTree.token];
        [self emit:aTree opcode:Bytecode.INSTR_POP];
    }
    else {
        [self emit:aTree opcode:[funcBytecode shortValue]];
    }
}

- (void) emit:(short)opcode
{
    [self emit:nil opcode:opcode];
}

- (void) emit:(ANTLRCommonTree *)opAST opcode:(short)opcode
{
    [self ensureCapacity:1];
    if (opAST != nil) {
        NSInteger i = [opAST getTokenStartIndex];
        NSInteger j = [opAST getTokenStopIndex];
        NSInteger p = [((ANTLRCommonToken *)[[tokens getTokens] objectAtIndex:i]) getStart];
        NSInteger q = [((ANTLRCommonToken *)[[tokens getTokens] objectAtIndex:j]) getStop];
        if (!(p < 0 || q < 0))
            [impl.sourceMap insertObject:[Interval newInterval:p b:q] atIndex:ip];
    }
    [impl.instrs insertChar:opcode atIndex:ip++];
}

- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)opcode arg:(NSInteger)arg
{
    [self emit:opAST opcode:opcode];
    [self ensureCapacity:Bytecode.OPND_SIZE_IN_BYTES];
//    [self writeShort:impl.instrs index:ip value:(short)arg];
    [impl.instrs insertShort:(short)arg atIndex:ip];
    ip += Bytecode.OPND_SIZE_IN_BYTES;
}

- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)opcode arg:(NSInteger)arg arg2:(NSInteger)arg2
{
    [self emit:opAST opcode:opcode];
    [self ensureCapacity:Bytecode.OPND_SIZE_IN_BYTES * 2];
//    [self writeShort:impl.instrs index:ip value:(short)arg];
    [impl.instrs insertShort:(short)arg atIndex:ip];
    ip += Bytecode.OPND_SIZE_IN_BYTES;
//    [self writeShort:impl.instrs index:ip value:(short)arg2];
    [impl.instrs insertShort:(short)arg2 atIndex:ip];
    ip += Bytecode.OPND_SIZE_IN_BYTES;
}

- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)opcode s:(NSString *)s arg2:(NSInteger)arg2
{
    NSInteger i = [self defineString:s];
    [self emit2:opAST opcode:opcode arg:i arg2:arg2];
}

- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)opcode s:(NSString *)s {
    NSInteger i = [self defineString:s];
    [self emit1:opAST opcode:opcode arg:i];
}

- (void) insert:(NSInteger)addr opcode:(short)opcode s:(NSString *)s {
    [self ensureCapacity:1 + Bytecode.OPND_SIZE_IN_BYTES];
    NSInteger instrSize = 1 + Bytecode.OPND_SIZE_IN_BYTES;
#ifdef DONTUSENOMO
    [System arraycopy:impl.instrs param1:addr param2:impl.instrs param3:addr + instrSize param4:ip - addr];
#endif
    NSInteger save = ip;
    ip = addr;
    [self emit1:nil opcode:opcode s:s];
    ip = save + instrSize;
    NSInteger a = addr + instrSize;
    
    while (a < ip) {
        char op = [impl.instrs charAtIndex:a];
        Instruction * I = Bytecode.instructions[op];
        if (op == Bytecode.INSTR_BR || op == Bytecode.INSTR_BRF) {
            //NSInteger opnd = [BytecodeDisassembler getShort:impl.instrs index:a + 1];
            NSInteger opnd = [impl.instrs shortAtIndex:a + 1];
            //[self writeShort:impl.instrs index:a + 1 value:(short)(opnd + instrSize)];
            [impl.instrs insertShort:(short)(opnd + instrSize) atIndex:a + 1];
        }
        a += I.nopnds * Bytecode.OPND_SIZE_IN_BYTES + 1;
    }
}

- (void) write:(NSInteger)addr value:(short)value
{
    //[self writeShort:impl.instrs index:addr value:value];
    [impl.instrs insertShort:value atIndex:addr];
}

- (void) ensureCapacity:(NSInteger)n
{
    if ((ip + n) >= [impl.instrs size]) {
        [impl.instrs ensureCapacity:(ip + n)];
        MemBuffer *c = [MemBuffer newMemBufferWithLen:30];
#ifdef DONTUSENOMO
        [System arraycopy:impl.instrs param1:0 param2:c param3:0 param4:impl.instrs.length];
#endif
        impl.instrs = c;
        NSArray * sm = [NSArray array];
#ifdef DONTUSENOMO
        [System arraycopy:impl.sourceMap param1:0 param2:sm param3:0 param4:impl.sourceMap.count];
#endif
        impl.sourceMap = sm;
    }
}

- (void) indent:(NSString *)indent
{
    [self emit1:nil opcode:Bytecode.INSTR_INDENT s:indent];
}


/**
 * Write value at index into a byte array highest to lowest byte,
 * left to right.
 */
+ (void) writeShort:(char *)memory index:(NSInteger)index value:(short)value
{
    memory[index + 0] = (char)((value >> (8 * 1)) & 0xFF);
    memory[index + 1] = (char)(value & 0xFF);
}

- (void) dealloc
{
    [impl release];
    [stringtable release];
    [tokens release];
    [errMgr release];
    [super dealloc];
}

@end
