#import "Interpreter.h"
#import "Bytecode.h"
#import "BytecodeDisassembler.h"
#import "CompilationState.h"
#import "CompiledST.h"
#import "Compiler.h"
#import "FormalArgument.h"
#import "STException.h"
#import "STLexer.h"
#import "StringTable.h"
#import "TestNewStuff.h"
#import "Compiler.h"
#import "DebugST.h"
#import "EvalExprEvent.h"
#import "EvalTemplateEvent.h"
#import "InterpEvent.h"
#import "ArrayIterator.h"
#import "Coordinate.h"
#import "ErrorBuffer.h"
#import "ErrorManager.h"
#import "ErrorType.h"
#import "Interval.h"
#import "MapModelAdaptor.h"
#import "Misc.h"
#import "MultiMap.h"
#import "ObjectModelAdaptor.h"
#import "STCompiletimeMessage.h"
#import "STDump.h"
#import "STGroupCompiletimeMessage.h"
#import "STLexerMessage.h"
#import "STMessage.h"
#import "STModelAdaptor.h"
//#import "STNoSuchPropertyException.h"
#import "STRuntimeMessage.h"
//#import "IOException.h"
#import "StringWriter.h"

@implementation Interpreter_Anon1

+ (id) newInterpreter_Anon1
{
    return [[Interpreter_Anon1 alloc] init];
}

- (id) init {
    if (self = [super init]) {
        [self addObject:@"i"];
        [self addObject:@"i0"];
    }
    return self;
}

@end

@implementation Interpreter_Anon2

+ (id) newInterpreter_Anon2WithST:(ST *)anST
{
    return [[Interpreter_Anon2 alloc] initWithST:anST];
}

- (id) initWithST:(ST *)anST {
    if (self = [super init]) {
        [self addObject:anST];
    }
    return self;
}

@end

@implementation Interpreter_Anon3

+ (OptionEnum) ANCHOR
{
    return ANCHOR;
}

+ (OptionEnum) FORMAT
{
    return FORMAT;
}

+ (OptionEnum) _NULL
{
    return _NULL;
}

+ (OptionEnum) SEPARATOR
{
    return SEPARATOR;
}

+ (OptionEnum) WRAP
{
    return WRAP;
}


- (id) init
{
    return (self = [super init]);
}

- (OptionEnum) ANCHOR
{
    return ANCHOR;
}

- (OptionEnum) FORMAT
{
    return FORMAT;
}

- (OptionEnum) _NULL
{
    return _NULL;
}

- (OptionEnum) SEPARATOR
{
    return SEPARATOR;
}

- (OptionEnum) WRAP
{
    return WRAP;
}

- (OptionEnum) containsObject:(NSString *)text
{
    if (text) {
        if ([text isEqualToString:@"ANCHOR"])
            return ANCHOR;
        else if ([text isEqualToString:@"FORMAT"])
            return FORMAT;
        else if ([text isEqualToString:@"NULL"])
            return _NULL;
        else if ([text isEqualToString:@"SEPARATOR"])
            return SEPARATOR;
        else if ([text isEqualToString:@"WRAP"])
            return WRAP;
    }
    return -1;
}

- (NSInteger) count
{
    return 5;
}

@end

OptionEnum OptionValueOf(NSString *text)
{
    if (text) {
        if ([text isEqualToString:@"ANCHOR"])
            return ANCHOR;
        else if ([text isEqualToString:@"FORMAT"])
            return FORMAT;
        else if ([text isEqualToString:@"NULL"])
            return _NULL;
        else if ([text isEqualToString:@"SEPARATOR"])
            return SEPARATOR;
        else if ([text isEqualToString:@"WRAP"])
            return WRAP;
    }
    return -1;
}

NSString *OptionDescription(OptionEnum value)
{
    switch (value) {
        case ANCHOR:
            return @"ANCHOR";
        case FORMAT:
            return @"FORMAT";
        case _NULL:
            return @"NULL";
        case SEPARATOR:
            return @"SEPARATOR";
        case WRAP:
            return @"WRAP";
    }
    return nil;
}

/**
 * Dump bytecode instructions as we execute them?
 */
BOOL trace = NO;

#define DEF_INSTR_LOAD_STR 1
#define DEF_INSTR_LOAD_ATTR 2
#define DEF_INSTR_LOAD_LOCAL 3
#define DEF_INSTR_LOAD_PROP 4
#define DEF_INSTR_LOAD_PROP_IND 5
#define DEF_INSTR_STORE_OPTION 6
#define DEF_INSTR_STORE_ARG 7
#define DEF_INSTR_NEW 8
#define DEF_INSTR_NEW_IND 9
#define DEF_INSTR_NEW_BOX_ARGS 10
#define DEF_INSTR_SUPER_NEW 11
#define DEF_INSTR_SUPER_NEW_BOX_ARGS 12
#define DEF_INSTR_WRITE 13
#define DEF_INSTR_WRITE_OPT 14
#define DEF_INSTR_MAP 15
#define DEF_INSTR_ROT_MAP 16
#define DEF_INSTR_ZIP_MAP 17
#define DEF_INSTR_BR 18
#define DEF_INSTR_BRF 19
#define DEF_INSTR_OPTIONS 20
#define DEF_INSTR_ARGS 21
#define DEF_INSTR_LIST 22
#define DEF_INSTR_ADD 23
#define DEF_INSTR_TOSTR 24
#define DEF_INSTR_FIRST 25
#define DEF_INSTR_LAST 26
#define DEF_INSTR_REST 27
#define DEF_INSTR_TRUNC 28
#define DEF_INSTR_STRIP 29
#define DEF_INSTR_TRIM 30
#define DEF_INSTR_LENGTH 31
#define DEF_INSTR_STRLEN 32
#define DEF_INSTR_REVERSE 33
#define DEF_INSTR_NOT 34
#define DEF_INSTR_OR 35
#define DEF_INSTR_AND 36
#define DEF_INSTR_INDENT 37
#define DEF_INSTR_DEDENT 38
#define DEF_INSTR_NEWLINE 39
#define DEF_INSTR_NOOP 40
#define DEF_INSTR_POP 41
#define DEF_INSTR_NULL 42

@implementation Interpreter

static Interpreter_Anon3 *Option;
static Interpreter_Anon3 *predefinedAnonSubtemplateAttributes;
static NSInteger DEFAULT_OPERAND_STACK_SIZE;

@synthesize operands;
@synthesize sp;
@synthesize current_ip;
@synthesize nwline;
@synthesize locale;
@synthesize errMgr;
@synthesize events;
@synthesize executeTrace;
@synthesize debugInfo;

+ (void) initialize
{
    predefinedAnonSubtemplateAttributes = [Interpreter_Anon1 newInterpreter_Anon1];
    Option = [[Interpreter_Anon3 alloc] init];
    DEFAULT_OPERAND_STACK_SIZE = 100;
}

+ (NSInteger) DEFAULT_OPERAND_STACK_SIZE
{
    return DEFAULT_OPERAND_STACK_SIZE;
}

+ (Interpreter_Anon3 *)predefinedAnonSubtemplateAttributes
{
    return predefinedAnonSubtemplateAttributes;
}

+ (Interpreter_Anon3 *) Option
{
    return Option;
}

- (id) initWithGroup:(STGroup *)aGroup
{
    if (self = [self init:aGroup locale:[NSLocale currentLocale] errMgr:group.errMgr]) {
    }
    return self;
}

- (id) init:(STGroup *)aGroup locale:(NSLocale *)aLocale
{
    if (self = [self init:aGroup locale:aLocale errMgr:aGroup.errMgr]) {
    }
    return self;
}

- (id) init:(STGroup *)aGroup errMgr:(ErrorManager *)anErrMgr
{
    if (self = [self init:aGroup locale:[NSLocale currentLocale] errMgr:anErrMgr]) {
    }
    return self;
}

- (id) init:(STGroup *)aGroup locale:(NSLocale *)aLocale errMgr:(ErrorManager *)anErrMgr
{
    if (self = [super init]) {
        operands = [NSArray array];
        sp = -1;
        current_ip = 0;
        nwline = 0;
        group = aGroup;
        locale = aLocale;
        errMgr = anErrMgr;
        if (STGroup.debug) {
            events = [NSMutableArray arrayWithCapacity:30];
            executeTrace = [NSMutableArray arrayWithCapacity:30];
            debugInfo = [NSMutableDictionary dictionaryWithCapacity:30];
        }
    }
    return self;
}

/**
 * Execute template self and return how many characters it wrote to out
 */
- (NSInteger) exec:(id<STWriter>)anSTWriter who:(ST *)aWho
{
    NSInteger save = current_ip;
    @try {
        return [self _exec:anSTWriter who:aWho];
    }
    @catch (NSException * e) {
        ;
    }
    @finally {
        current_ip = save;
    }
    return current_ip;
}
/**
 * Execute template self and return how many characters it wrote to out
 */
- (NSInteger) _exec:(id<STWriter>)anSTWriter who:(ST *)aWho
{
    NSInteger start = [anSTWriter index];
    NSInteger prevOpcode = 0;
    NSInteger n = 0;
    NSInteger idx;
    NSInteger nargs;
    NSInteger addr;
    NSString *name;
    id obj;
    id left;
    id right;
    id propName;
    ST *st;
    NSMutableArray *options;
    MemBuffer *code;
    NSInteger ip = 0;
    short opcode;
    
    code = aWho.impl.instrs;
    while (ip < aWho.impl.codeSize) {
        if (trace || STGroup.debug)
            [self trace:aWho ip:ip];
        opcode = [code shortAtIndex:ip];
        current_ip = ip;
        ip++;
        
        switch (opcode) {
            case  DEF_INSTR_LOAD_STR:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                [operands insertObject:[aWho.impl.strings objectAtIndex:idx] atIndex:++sp];
                break;
            case  DEF_INSTR_LOAD_ATTR:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:idx];
                
                @try {
                    obj = [aWho getAttribute:name];
                }
                @catch (STNoSuchPropertyException * nspe) {
                    [errMgr runTimeError:aWho ip:current_ip error:NO_SUCH_ATTRIBUTE arg:name];
                    obj = nil;
                }
                [operands replaceObjectAtIndex:++sp withObject:obj];
                break;
            case  DEF_INSTR_LOAD_LOCAL:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = [aWho.locals objectAtIndex:idx];
                if (obj == ST.EMPTY_ATTR)
                    obj = nil;
                [operands replaceObjectAtIndex:++sp withObject:obj];
                break;
            case  DEF_INSTR_LOAD_PROP:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = [operands objectAtIndex:sp--];
                name = [aWho.impl.strings objectAtIndex:idx];
                [operands replaceObjectAtIndex:++sp withObject:[self getObjectProperty:aWho obj:obj property:name]];
                break;
            case  DEF_INSTR_LOAD_PROP_IND:
                propName = [operands objectAtIndex:sp--];
                obj = [operands objectAtIndex:sp];
                [operands replaceObjectAtIndex:sp withObject:[self getObjectProperty:aWho obj:obj property:propName]];
                break;
            case  DEF_INSTR_NEW:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:idx];
                nargs = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                st = [aWho.groupThatCreatedThisInstance getEmbeddedInstanceOf:aWho ip:ip name:name];
                [self storeArgs:aWho nargs:nargs st:st];
                sp -= nargs;
                [operands replaceObjectAtIndex:++sp withObject:st];
                break;
            case  DEF_INSTR_NEW_IND:
                nargs = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = (NSString *)[operands objectAtIndex:sp - nargs];
                st = [aWho.groupThatCreatedThisInstance getEmbeddedInstanceOf:aWho ip:ip name:name];
                [self storeArgs:aWho nargs:nargs st:st];
                sp -= nargs;
                sp--;
                [operands replaceObjectAtIndex:++sp withObject:st];
                break;
            case  DEF_INSTR_NEW_BOX_ARGS:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:idx];
                NSMutableDictionary *attrs = (NSMutableDictionary *)[operands objectAtIndex:sp--];
                st = [aWho.groupThatCreatedThisInstance getEmbeddedInstanceOf:aWho ip:ip name:name];
                [self storeArgs:aWho attrs:attrs st:st];
                [operands replaceObjectAtIndex:++sp withObject:st];
                break;
            case  DEF_INSTR_SUPER_NEW:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:idx];
                nargs = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                [self super_new:aWho name:name nargs:nargs];
                break;
            case  DEF_INSTR_SUPER_NEW_BOX_ARGS:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:idx];
                attrs = (NSMutableDictionary *)[operands objectAtIndex:sp--];
                [self super_new:aWho name:name attrs:attrs];
                break;
            case  DEF_INSTR_STORE_OPTION:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = [operands objectAtIndex:sp--];
                options = [operands objectAtIndex:sp];
                [options replaceObjectAtIndex:idx withObject:obj];
                break;
            case  DEF_INSTR_STORE_ARG:
                idx = [code shortAtIndex:ip];
                name = [aWho.impl.strings objectAtIndex:idx];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = [operands objectAtIndex:sp--];
                attrs = (NSMutableDictionary *)[operands objectAtIndex:sp];
                [attrs setObject:name forKey:obj];
                break;
            case  DEF_INSTR_WRITE:
                obj = [operands objectAtIndex:sp--];
                idx = [self writeObjectNoOptions:anSTWriter who:aWho obj:obj];
                n += idx;
                nwline += idx;
                break;
            case  DEF_INSTR_WRITE_OPT:
                options = (NSMutableArray *)[operands objectAtIndex:sp--];
                obj = [operands objectAtIndex:sp--];
                idx = [self writeObjectWithOptions:anSTWriter who:aWho obj:obj options:options];
                n += idx;
                nwline += idx;
                break;
            case  DEF_INSTR_MAP:
                st = (ST *)[operands objectAtIndex:sp--];
                obj = [operands objectAtIndex:sp--];
                [self map:aWho attr:obj st:st];
                break;
            case  DEF_INSTR_ROT_MAP:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                NSMutableArray * templates = [NSMutableArray arrayWithCapacity:16];
                
                for (NSInteger i = idx - 1; i >= 0; i--)
                    [templates addObject:(ST *)[operands objectAtIndex:sp - i]];
                
                sp -= idx;
                obj = [operands objectAtIndex:sp--];
                if (obj != nil)
                    [self rot_map:aWho attr:obj prototypes:templates];
                break;
            case  DEF_INSTR_ZIP_MAP:
                st = (ST *)[operands objectAtIndex:sp--];
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                NSMutableArray * exprs = [NSMutableArray arrayWithCapacity:16];
                
                for (NSInteger i = idx - 1; i >= 0; i--)
                    [exprs addObject:[operands objectAtIndex:sp - i]];
                
                sp -= idx;
                [operands replaceObjectAtIndex:++sp withObject:[self zip_map:aWho exprs:exprs prototype:st]];
                break;
            case  DEF_INSTR_BR:
                ip = [code shortAtIndex:ip];
                break;
            case  DEF_INSTR_BRF:
                addr = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = [operands objectAtIndex:sp--];
                if (![self testAttributeTrue:obj])
                    ip = addr;
                break;
            case  DEF_INSTR_OPTIONS:
                [operands replaceObjectAtIndex:++sp withObject:[NSMutableArray arrayWithCapacity:16]];
                break;
            case  DEF_INSTR_ARGS:
                [operands replaceObjectAtIndex:++sp withObject:[NSMutableDictionary dictionaryWithCapacity:16]];
                break;
            case  DEF_INSTR_LIST:
                [operands replaceObjectAtIndex:++sp withObject:[NSMutableArray arrayWithCapacity:16]];
                break;
            case  DEF_INSTR_ADD:
                obj = [operands objectAtIndex:sp--];
                NSMutableArray * list = (NSMutableArray *)[operands objectAtIndex:sp];
                [self addToList:list obj:obj];
                break;
            case  DEF_INSTR_TOSTR:
                [operands replaceObjectAtIndex:sp withObject:[self description:aWho value:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_FIRST:
                [operands replaceObjectAtIndex:sp withObject:[self first:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_LAST:
                [operands replaceObjectAtIndex:sp withObject:[self last:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_REST:
                [operands replaceObjectAtIndex:sp withObject:[self rest:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_TRUNC:
                [operands replaceObjectAtIndex:sp withObject:[self trunc:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_STRIP:
                [operands replaceObjectAtIndex:sp withObject:[self strip:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_TRIM:
                obj = [operands objectAtIndex:sp--];
                if ([obj isKindOfClass:[NSString class]]) {
                    [operands replaceObjectAtIndex:++sp withObject:[((NSString *)obj) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                }
                else {
                    [errMgr runTimeError:aWho ip:current_ip error:EXPECTING_STRING arg:@"trim" arg2:[obj className]];
                    [operands replaceObjectAtIndex:++sp withObject:obj];
                }
                break;
            case  DEF_INSTR_LENGTH:
                [operands replaceObjectAtIndex:sp withObject:[self length:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_STRLEN:
                obj = [operands objectAtIndex:sp--];
                if ([obj isKindOfClass:[NSString class]]) {
                    [operands replaceObjectAtIndex:++sp withObject:[NSNumber numberWithInt:[((NSString *)obj) length]]];
                }
                else {
                    [errMgr runTimeError:aWho ip:current_ip error:EXPECTING_STRING arg:@"strlen" arg2:[obj className]];
                    [operands replaceObjectAtIndex:++sp withObject:[NSNumber numberWithInteger:0]];
                }
                break;
            case  DEF_INSTR_REVERSE:
                [operands replaceObjectAtIndex:sp withObject:[self reverse:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_NOT:
#pragma mark error fix this
                [operands replaceObjectAtIndex:sp withObject:![self testAttributeTrue:[operands objectAtIndex:sp]]];
                break;
            case  DEF_INSTR_OR:
                right = [operands objectAtIndex:sp--];
                left = [operands objectAtIndex:sp--];
#pragma mark error fix this
                [operands replaceObjectAtIndex:++sp withObject:([self testAttributeTrue:left] || [self testAttributeTrue:right])];
                break;
            case  DEF_INSTR_AND:
                right = [operands objectAtIndex:sp--];
                left = [operands objectAtIndex:sp--];
#pragma mark error fix this
                [operands replaceObjectAtIndex:++sp withObject:[self testAttributeTrue:left] && [self testAttributeTrue:right]];
                break;
            case  DEF_INSTR_INDENT:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                [anSTWriter pushIndentation:[aWho.impl.strings objectAtIndex:idx]];
                break;
            case  DEF_INSTR_DEDENT:
                [anSTWriter popIndentation];
                break;
            case  DEF_INSTR_NEWLINE:
                
                @try {
                    if (prevOpcode ==  DEF_INSTR_NEWLINE || prevOpcode ==  DEF_INSTR_INDENT || nwline > 0) {
                        [anSTWriter write:Misc.newline];
                    }
                    nwline = 0;
                }
                @catch (IOException * ioe) {
                    [errMgr IOError:aWho error:WRITE_IO_ERROR e:ioe];
                }
                break;
            case  DEF_INSTR_NOOP:
                break;
            case  DEF_INSTR_POP:
                sp--;
                break;
            case  DEF_INSTR_NULL:
                [operands replaceObjectAtIndex:++sp withObject:nil];
                break;
            default:
                [errMgr internalError:aWho msg:[NSString stringWithFormat:@"invalid bytecode @ %d:%d", ip - 1, opcode] e:nil];
                [aWho.impl dump];
                break;
        }
        prevOpcode = opcode;
    }
    
    if (STGroup.debug) {
        NSInteger stop = [anSTWriter index] - 1;
        EvalTemplateEvent * e = [EvalTemplateEvent newEvalTemplateEventWithWho:(DebugST *)aWho start:start stop:stop];
        [events addObject:e];
        if (aWho.enclosingInstance != nil) {
            DebugST *parent = ((DebugST *)aWho).enclosingInstance;
            [[self getEvents:parent] addObject:e];
        }
    }
    return n;
}

- (void) super_new:(ST *)aWho name:(NSString *)name nargs:(NSInteger)nargs
{
    ST *st = nil;
    CompiledST *imported = [aWho.impl.nativeGroup lookupImportedTemplate:name];
    if (imported == nil) {
        [errMgr runTimeError:aWho ip:current_ip error:NO_IMPORTED_TEMPLATE arg:name];
        st = [aWho.groupThatCreatedThisInstance createStringTemplate];
        st.impl = [CompiledST newCompiledST];
        sp -= nargs;
        [operands replaceObjectAtIndex:++sp withObject:st];
        return;
    }
    st = [imported.nativeGroup createStringTemplate];
    st.enclosingInstance = aWho;
    st.groupThatCreatedThisInstance = group;
    st.impl = imported;
    [self storeArgs:aWho nargs:nargs st:st];
    sp -= nargs;
    [operands replaceObjectAtIndex:++sp withObject:st];
}

- (void) super_new:(ST *)aWho name:(NSString *)name attrs:(NSMutableDictionary *)attrs
{
    ST * st = nil;
    CompiledST * imported = [aWho.impl.nativeGroup lookupImportedTemplate:name];
    if (imported == nil) {
        [errMgr runTimeError:aWho ip:current_ip error:NO_IMPORTED_TEMPLATE arg:name];
        st = [aWho.groupThatCreatedThisInstance createStringTemplate];
        st.impl = [[CompiledST alloc] init];
        [operands replaceObjectAtIndex:++sp withObject:st];
        return;
    }
    st = [imported.nativeGroup createStringTemplate];
    st.enclosingInstance = aWho;
    st.groupThatCreatedThisInstance = group;
    st.impl = imported;
    [self storeArgs:aWho attrs:attrs st:st];
    [operands replaceObjectAtIndex:++sp withObject:st];
}

- (void) storeArgs:(ST *)aWho attrs:(NSMutableDictionary *)attrs st:(ST *)st
{
    NSInteger nformalArgs = 0;
    if (st.impl.formalArguments != nil)
        nformalArgs = [st.impl.formalArguments count];
    NSInteger nargs = 0;
    if (attrs != nil)
        nargs = [attrs count];
    if (nargs < (nformalArgs - [st.impl getNumberOfArgsWithDefaultValues]) || nargs > nformalArgs) {
        [errMgr runTimeError:aWho ip:current_ip error:ARGUMENT_COUNT_MISMATCH arg:nargs arg2:st.impl.name arg3:nformalArgs];
    }
    
    for (NSString *argName in [attrs allKeys]) {
        if ([st.impl.formalArguments objectForKey:argName] == nil) {
            [errMgr runTimeError:aWho ip:current_ip error:NO_SUCH_ATTRIBUTE arg:argName];
            continue;
        }
        id obj = [attrs objectForKey:argName];
        [st rawSetAttribute:argName value:obj];
    }
    
}

- (void) storeArgs:(ST *)aWho nargs:(NSInteger)nargs st:(ST *)st
{
    NSInteger nformalArgs = 0;
    if (st.impl.formalArguments != nil)
        nformalArgs = [st.impl.formalArguments count];
    NSInteger firstArg = sp - (nargs - 1);
    NSInteger numToStore = (nargs < nformalArgs)?nargs:nformalArgs;
    if (st.impl.isAnonSubtemplate)
        nformalArgs -= [predefinedAnonSubtemplateAttributes count];
    if (nargs < (nformalArgs - [st.impl getNumberOfArgsWithDefaultValues]) || nargs > nformalArgs) {
        [errMgr runTimeError:aWho ip:current_ip error:ARGUMENT_COUNT_MISMATCH arg:nargs arg2:st.impl.name arg3:nformalArgs];
    }
    if (st.impl.formalArguments == nil)
        return;
    NSEnumerator *argNames = [st.impl.formalArguments keyEnumerator];
    
    for (NSInteger i = 0; i < numToStore; i++) {
        id obj = [operands objectAtIndex:firstArg + i];
        NSString *argName = [argNames nextObject];
        [st rawSetAttribute:argName value:obj];
    }
    
}


/**
 * Write out an expression result that doesn't use expression options.
 * E.g., <name>
 */
- (NSInteger) writeObjectNoOptions:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj
{
    NSInteger start = [anSTWriter index];
    NSInteger n = [self writeObject:anSTWriter who:aWho obj:obj options:nil];
    if (STGroup.debug) {
        Interval * templateLocation = [aWho.impl.sourceMap objectAtIndex:current_ip];
        NSInteger exprStart = -1;
        NSInteger exprStop = -1;
        if (templateLocation != nil) {
            exprStart = templateLocation.a;
            exprStop = templateLocation.b;
        }
        EvalExprEvent * e = [EvalExprEvent newEvalExprEventWithWho:aWho start:start stop:[anSTWriter index]-1 exprStart:exprStart exprStop:exprStop];
        // [System.anSTWriter println:e];
        [events addObject:e];
    }
    return n;
}


/**
 * Write out an expression result that uses expression options.
 * E.g., <names; separator=", ">
 */
- (NSInteger) writeObjectWithOptions:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj options:(NSMutableArray *)options
{
    NSInteger start = [anSTWriter index];
    NSMutableArray * optionStrings = nil;
    if (options != nil) {
        optionStrings = [NSMutableArray arrayWithCapacity:16];
        
        for (NSInteger i = 0; i < /* org.stringtemplate.v4.compiler. */ Compiler.NUM_OPTIONS; i++) {
            [optionStrings insertObject:[self description:aWho value:[options objectAtIndex:i]] atIndex:i];
        }
        
    }
    if (options != nil && [options objectAtIndex:Interpreter.Option.ANCHOR] != nil) {
        [anSTWriter pushAnchorPoint];
    }
    NSInteger n = [self writeObject:anSTWriter who:aWho obj:obj options:optionStrings];
    if (options != nil && [options objectAtIndex:Interpreter.Option.ANCHOR] != nil) {
        [anSTWriter popAnchorPoint];
    }
    if (STGroup.debug) {
        Interval *templateLocation = [aWho.impl.sourceMap objectAtIndex:current_ip];
        NSInteger exprStart = templateLocation.a;
        NSInteger exprStop = templateLocation.b;
        EvalExprEvent * e = [EvalExprEvent newEvalExprEventWithWho:aWho start:start stop:[anSTWriter index]-1 exprStart:exprStart exprStop:exprStop];
        // [System.anSTWriter println:e];
        [events addObject:e];
    }
    return n;
}


/**
 * Generic method to emit text for an object. It differentiates
 * between templates, iterable objects, and plain old Java objects (POJOs)
 */
- (NSInteger) writeObject:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj options:(NSArray *)options
{
    NSInteger n = 0;
    if (obj == nil) {
        if (options != nil && [options objectAtIndex:Interpreter.Option._NULL] != nil) {
            obj = [options objectAtIndex:Interpreter.Option._NULL];
        }
        else
            return 0;
    }
    if ([obj isKindOfClass:[ST class]]) {
        ((ST *)obj).enclosingInstance = aWho;
        [self setDefaultArguments:(ST *)obj];
        if (options != nil && [options objectAtIndex:Interpreter.Option.WRAP] != nil) {
            
            @try {
                [anSTWriter writeWrap:[options objectAtIndex:Interpreter.Option.WRAP]];
            }
            @catch (IOException * ioe) {
                [errMgr IOError:aWho error:WRITE_IO_ERROR e:ioe];
            }
        }
        n = [self exec:anSTWriter who:(ST *)obj];
    }
    else {
        obj = [Interpreter convertAnythingIteratableToIterator:obj];
        
        @try {
            if ([obj isKindOfClass:[NSEnumerator class]])
                n = [self writeIterator:anSTWriter who:aWho obj:obj options:options];
            else
                n = [self writePOJO:anSTWriter obj:obj options:options];
        }
        @catch (IOException * ioe) {
            [errMgr IOError:aWho error:WRITE_IO_ERROR e:ioe arg:obj];
        }
    }
    return n;
}

- (NSInteger) writeIterator:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj options:(NSArray *)options
{
    if (obj == nil)
        return 0;
    NSInteger n = 0;
    NSEnumerator * it = (NSEnumerator *)obj;
    NSString * separator = nil;
    if (options != nil)
        separator = [options objectAtIndex:Interpreter.Option.SEPARATOR];
    BOOL seenAValue = NO;

    id iterValue;
    while ((iterValue = [it nextObject]) != nil) {
        BOOL needSeparator = seenAValue && separator != nil && (iterValue != nil || [options objectAtIndex:Interpreter.Option._NULL] != nil);
        if (needSeparator)
            n += [anSTWriter writeSeparator:separator];
        NSInteger nw = [self writeObject:anSTWriter who:aWho obj:iterValue options:options];
        if (nw > 0)
            seenAValue = YES;
        n += nw;
    }
    
    return n;
}

- (NSInteger) writePOJO:(id<STWriter>)anSTWriter obj:(id)obj options:(NSArray *)options {
    NSString * formatString = nil;
    if (options != nil)
        formatString = [options objectAtIndex:Interpreter.Option.FORMAT];
    AttributeRenderer * r = [group getAttributeRenderer:[obj class]];
    NSString * v;
    if (r != nil)
        v = [r description:obj formatString:formatString locale:locale];
    else
        v = [obj description];
    NSInteger n;
    if (options != nil && [options objectAtIndex:Interpreter.Option.WRAP] != nil) {
        n = [anSTWriter write:v wrap:[options objectAtIndex:Interpreter.Option.WRAP]];
    }
    else {
        n = [anSTWriter write:v];
    }
    return n;
}

- (void) map:(ST *)awho attr:(id)attr st:(ST *)st
{
    [self rot_map:awho attr:attr prototypes:[[Interpreter_Anon2 alloc] initWithST:st]];
}

- (void) rot_map:(ST *)aWho attr:(id)attr prototypes:(NSMutableArray *)prototypes
{
    if (attr == nil) {
        [operands replaceObjectAtIndex:sp withObject:nil];
        return;
    }
    attr = [Interpreter convertAnythingIteratableToIterator:attr];
    if ([attr isKindOfClass:[NSEnumerator class]]) {
        NSMutableArray * mapped = [NSMutableArray arrayWithCapacity:16];
        NSEnumerator * iter = (NSEnumerator *)attr;
        NSInteger i0 = 0;
        NSInteger i = 1;
        NSInteger ti = 0;
        id iterValue;

        while ((iterValue = [iter nextObject]) != nil) {
            if (iterValue == nil) {
                [mapped addObject:nil];
                continue;
            }
            NSInteger templateIndex = ti % [prototypes count];
            ti++;
            ST * proto = [prototypes objectAtIndex:templateIndex];
            ST * st = [group createStringTemplate:proto];
            [self setFirstArgument:aWho st:st attr:iterValue];
            if (st.impl.isAnonSubtemplate) {
                [st rawSetAttribute:@"i0" value:i0];
                [st rawSetAttribute:@"i" value:i];
            }
            [mapped addObject:st];
            i0++;
            i++;
        }
        
        [operands replaceObjectAtIndex:++sp withObject:mapped];
    }
    else {
        ST * proto = [prototypes objectAtIndex:0];
        ST * st = [group createStringTemplate:proto];
        if (st != nil) {
            [self setFirstArgument:aWho st:st attr:attr];
            if (st.impl.isAnonSubtemplate) {
                [st rawSetAttribute:@"i0" value:0];
                [st rawSetAttribute:@"i" value:1];
            }
            [operands replaceObjectAtIndex:++sp withObject:st];
        }
        else {
            [operands replaceObjectAtIndex:++sp withObject:nil];
        }
    }
}

- (AttributeList *) zip_map:(ST *)aWho exprs:(NSMutableArray *)exprs prototype:(ST *)prototype
{
    if (exprs == nil || prototype == nil || [exprs count] == 0) {
        return nil;
    }
    id tmp;
    for (NSInteger i = 0; i < [exprs count]; i++) {
        id attr = [exprs objectAtIndex:i];
        if (attr != nil)
            [exprs insertObject:[Interpreter convertAnythingToIterator:attr] atIndex:i];
    }
    
    NSInteger numExprs = [exprs count];
    CompiledST * code = prototype.impl;
    NSMutableDictionary * formalArguments = code.formalArguments;
    if (!code.hasFormalArgs || formalArguments == nil) {
        [errMgr runTimeError:aWho ip:current_ip error:MISSING_FORMAL_ARGUMENTS];
        return nil;
    }
    NSArray *formalArgumentNames = [formalArguments allKeys];
    NSInteger nformalArgs = [formalArgumentNames count];
    if ([prototype getIsAnonSubtemplate])
        nformalArgs -= [predefinedAnonSubtemplateAttributes count];
    if (nformalArgs != numExprs) {
        [errMgr runTimeError:aWho ip:current_ip error:MAP_ARGUMENT_COUNT_MISMATCH arg:numExprs arg2:nformalArgs];
        NSInteger shorterSize = ([formalArgumentNames count] > numExprs)?[formalArgumentNames count]:numExprs;
        numExprs = shorterSize;
        NSArray *newFormalArgumentNames = [NSArray array];
#pragma mark fix this
        //[System arraycopy:formalArgumentNames param1:0 param2:newFormalArgumentNames param3:0 param4:shorterSize];
        formalArgumentNames = newFormalArgumentNames;
    }
    AttributeList *results = [AttributeList arrayWithCapacity:5];
    NSInteger i = 0;
    
    while (YES) {
        NSInteger numEmpty = 0;
        ST * embedded = [group createStringTemplate:prototype];
        [embedded rawSetAttribute:@"i0" value:i];
        [embedded rawSetAttribute:@"i" value:i + 1];
        
        for (NSInteger a = 0; a < numExprs; a++) {
            NSEnumerator * it = (NSEnumerator *)[exprs objectAtIndex:a];
            if (it != nil && (tmp = [it nextObject]) != nil) {
                NSString * argName = (NSString *)[formalArgumentNames objectAtIndex:a];
                id iteratedValue = tmp;
                [embedded rawSetAttribute:argName value:iteratedValue];
            }
            else {
                numEmpty++;
            }
        }
        
        if (numEmpty == numExprs)
            break;
        [results addObject:embedded];
        i++;
    }
    
    return results;
}

- (void) setFirstArgument:(ST *)aWho st:(ST *)st attr:(id)attr
{
    if (st.impl.formalArguments == nil) {
        [errMgr runTimeError:aWho ip:current_ip error:ARGUMENT_COUNT_MISMATCH arg:1 arg2:st.impl.name arg3:0];
        return;
    }
    [st.locals insertObject:attr atIndex:0];
}

- (void) addToList:(NSMutableArray *)list obj:(id)obj
{
    id tmp;
    //obj = [Interpreter convertAnythingIteratableToIterator:obj];
    if ([obj isKindOfClass:[NSEnumerator class]]) {
        NSEnumerator * it = (NSEnumerator *)obj;
        while ((tmp = [it nextObject])!= nil)
            [list addObject:tmp];
    }
    else {
        [list addObject:obj];
    }
}


/**
 * Return the first attribute if multiple valued or the attribute
 * itself if single-valued.  Used in <names:first()>
 */
- (id) first:(id)v
{
    if (v == nil)
        return nil;
    id r = v;
    id tmp;
    // v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[NSEnumerator class]]) {
        NSEnumerator *it = [v objectEnumerator];
        if ((tmp = [it nextObject]) != nil) {
            r = tmp;
        }
    }
    return r;
}


/**
 * Return the last attribute if multiple valued or the attribute
 * itself if single-valued. Unless it's a list or array, this is pretty
 * slow as it iterates until the last element.
 */
- (id) last:(id)v
{
    id tmp;
    if (v == nil)
        return nil;
    if ([v isKindOfClass:[NSArray class]])
        return [((NSMutableArray *)v) objectAtIndex:[((NSMutableArray *)v) count] - 1];
    else if ([[v class] array]) {
        NSArray * elems = (NSArray *)v;
        return [elems objectAtIndex:[elems count]-1];
    }
    id last = v;
    // v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[NSEnumerator class]]) {
        NSEnumerator *it = [v objectEnumerator];
        while ((tmp = [it nextObject]) != nil) {
            last = tmp;
        }
    }
    return last;
}


/**
 * Return everything but the first attribute if multiple valued
 * or null if single-valued.
 */
- (id) rest:(id)v
{
    if (v == nil)
        return nil;
    id obj;
    if ([v isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *elems = (NSMutableArray *)v;
        if ([elems count] <= 1)
            return nil;
        return [elems subarrayWithRange:NSMakeRange(1, [elems count])];
    }
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[NSEnumerator class]]) {
        NSMutableArray *a = [NSMutableArray arrayWithCapacity:16];
        NSEnumerator *it = [v objectEnumerator];
        if ((obj = [it nextObject]) == nil)
            return nil;
        do {
            [a addObject:obj];
        } while ((obj = [it nextObject]) != nil);
        return a;
    }
    return nil;
}


/**
 * Return all but the last element.  trunc(x)=null if x is single-valued.
 */
- (id) trunc:(id)v
{
    id obj;
    if (v == nil)
        return nil;
    if ([v isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *elems = (NSMutableArray *)v;
        if ([elems count] <= 1)
            return nil;
        return [elems subarrayWithRange:NSMakeRange(0, [elems count] - 1)];
    }
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[NSEnumerator class]]) {
        NSMutableArray * a = [NSMutableArray arrayWithCapacity:16];
        NSEnumerator * it = (NSEnumerator *)v;
        
        while ((obj = [it nextObject]) != nil) {
            [a addObject:obj];
        }
        
        return a;
    }
    return nil;
}


/**
 * Return a new list w/o null values.
 */
- (id) strip:(id)v
{
    id obj;
    if (v == nil)
        return nil;
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[NSEnumerator class]]) {
        NSMutableArray * a = [NSMutableArray arrayWithCapacity:16];
        NSEnumerator * it = (NSEnumerator *)v;
        
        while ((obj = [it nextObject]) != nil) {
            [a addObject:obj];
        }
        return a;
    }
    return v;
}


/**
 * Return a list with the same elements as v but in reverse order. null
 * values are NOT stripped out. use reverse(strip(v)) to do that.
 */
- (id) reverse:(id)v
{
    id tmp;
    if (v == nil)
        return nil;
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[NSEnumerator class]]) {
        NSMutableArray *a = [NSMutableArray arrayWithCapacity:16];
        NSEnumerator *it = [v objectEnumerator];
        
        while ((tmp = [it nextObject]) != nil) {
            [a insertObject:tmp atIndex:0];
        }
        return a;
    }
    return v;
}


/**
 * Return the length of a mult-valued attribute or 1 if it is a
 * single attribute. If attribute is null return 0.
 * Special case several common collections and primitive arrays for
 * speed. This method by Kay Roepke from v3.
 */
- (NSInteger) length:(id)v {
    if (v == nil)
        return 0;
    NSInteger i = 1;
    if ([v isKindOfClass:[NSMutableDictionary class]])
        i = [((NSMutableDictionary *)v) count];
    else if ([v isKindOfClass:[NSMutableArray class]])
        i = [((NSMutableArray *)v) count];
    else if ([v isKindOfClass:[NSArray class]])
        i = [((NSArray *)v) count];
    else if ([v isKindOfClass:[NSEnumerator class]]) {
        NSEnumerator * it = [v objectEnumerator];
        i = 0;
        while ([it nextObject]) {
            i++;
        }
        
    }
    return i;
}

- (NSString *) description:(ST *)aWho value:(id)value
{
    if (value != nil) {
        if ([value class] == [NSString class])
            return (NSString *)value;
        if ([value isKindOfClass:[ST class]])
            ((ST *)value).enclosingInstance = aWho;
        StringWriter * sw = [[StringWriter alloc] init];
        [self writeObjectNoOptions:[NoIndentWriter newNoIdentWriterWithWriter:sw] who:aWho obj:value];
        return [sw description];
    }
    return nil;
}

+ (NSEnumerator *) convertAnythingIteratableToIterator:(id)obj
{
    NSEnumerator * iter = nil;
    if (obj == nil)
        return nil;
    if ([obj isKindOfClass:[NSMutableArray class]])
        iter = [((NSMutableArray *)obj) objectEnumerator];
    else if ([obj  isKindOfClass:[NSArray class]])
        iter = [((NSArray *)obj) objectEnumerator];
    else if ([obj isKindOfClass:[NSMutableDictionary class]])
        iter = [((NSMutableDictionary *)obj) keyEnumerator];
    else if ([obj isKindOfClass:[NSEnumerator class]])
        iter = (NSEnumerator *)obj;
    if (iter == nil)
        return obj;
    return iter;
}

+ (NSEnumerator *) convertAnythingToIterator:(id)obj
{
    obj = [Interpreter convertAnythingIteratableToIterator:obj];
    if ([obj isKindOfClass:[NSEnumerator class]])
        return (NSEnumerator *)obj;
    NSMutableArray *singleton = [[AttributeList alloc] init:1];
    [singleton addObject:obj];
    return [singleton objectEnumerator];
}

- (BOOL) testAttributeTrue:(id)a
{
    if (a == nil)
        return NO;
    if ([a isKindOfClass:[NSNumber class]])
        return (NSNumber *)a;
    if ([a isKindOfClass:[NSMutableArray class]])
        return [((NSMutableArray *)a) count] > 0;
    if ([a isKindOfClass:[NSMutableDictionary class]])
        return [((NSMutableDictionary *)a) count] > 0;
    if ([a isKindOfClass:[NSEnumerator class]])
        return [((NSEnumerator *)a) nextObject];
    return YES;
}

- (id) getObjectProperty:(ST *)aWho obj:(id)obj property:(id)property
{
    if (obj == nil) {
        [errMgr runTimeError:aWho ip:current_ip error:NO_SUCH_PROPERTY arg:@"null attribute"];
        return nil;
    }
    
    @try {
        id<ModelAdaptor> adap = [aWho.groupThatCreatedThisInstance getModelAdaptor:[obj class]];
        return [adap getProperty:aWho obj:obj property:property propertyName:[self description:aWho value:property]];
    }
    @catch (STNoSuchPropertyException * e) {
        [errMgr runTimeError:aWho ip:current_ip error:NO_SUCH_PROPERTY e:e arg:[NSString stringWithFormat:@"%@.%@", [obj className], property]];
    }
    return nil;
}


/**
 * Set any default argument values that were not set by the
 * invoking template or by setAttribute directly.  Note
 * that the default values may be templates.
 * 
 * The evaluation context is the template enclosing invokedST.
 */
- (void) setDefaultArguments:(ST *)invokedST
{
    if (invokedST.impl.formalArguments == nil)
        return;
    
    for (FormalArgument *arg in invokedST.impl.formalArguments) {
        if ([invokedST.locals objectAtIndex:arg.index] == ST.EMPTY_ATTR && arg.compiledDefaultValue != nil) {
            ST * defaultArgST = [group createStringTemplate];
            defaultArgST.enclosingInstance = invokedST.enclosingInstance;
            defaultArgST.groupThatCreatedThisInstance = group;
            defaultArgST.impl = arg.compiledDefaultValue;
#ifdef DONTUSENOMO
            [System.anSTWriter println:[[@"setting def arg " stringByAppendingString:arg.name] stringByAppendingString:@" to "] + defaultArgST];
#endif
#pragma mark remove debugging print statements
            NSLog( @"setting def arg %@ to ", arg.name, defaultArgST );
            NSString * defArgTemplate = [arg.defaultValueToken getText];
            if ([defArgTemplate hasPrefix:@"{<("] && [defArgTemplate hasSuffix:@")>}"]) {
                [invokedST rawSetAttribute:arg.name value:[self description:invokedST value:defaultArgST]];
            }
            else {
                [invokedST rawSetAttribute:arg.name value:defaultArgST];
            }
        }
    }
    
}

- (void) trace:(ST *)aWho ip:(NSInteger)ip
{
    NSMutableString *tr = [NSMutableString stringWithCapacity:16];
    BytecodeDisassembler *dis = [BytecodeDisassembler newBytecodeDisassembler:aWho.impl];
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    [dis disassembleInstruction:buf ip:ip];
    NSString * name = [aWho.impl.name stringByAppendingString:@":"];
    if (aWho.impl.name == ST.UNKNOWN_NAME)
        name = @"";
    [tr appendString:[NSMutableString stringWithFormat:@"%-40s%@%@\tstack=[", name, buf]];
    
    for (NSInteger i = 0; i <= sp; i++) {
        id obj = [operands objectAtIndex:i];
        [self printForTrace:tr obj:obj];
    }
    
    [tr appendFormat:@" ], calls=%@, sp=%d, nw=%d", [aWho getEnclosingInstanceStackString], sp, nwline];
    NSString * s = [tr description];
    if (STGroup.debug)
        [executeTrace addObject:s];
    if (trace) {
        // [System.anSTWriter println:s];
        NSLog(@"%@", s );
    }
}

- (void) printForTrace:(NSMutableString *)tr obj:(id)obj
{
    id tmp;
    if ([obj isKindOfClass:[ST class]]) {
        if (((ST *)obj).impl == nil)
            [tr appendString:@"bad-template()"];
        else
            [tr appendString:[[@" " stringByAppendingString:((ST *)obj).impl.name] stringByAppendingString:@"()"]];
        return;
    }
    obj = [Interpreter convertAnythingIteratableToIterator:obj];
    if ([obj isKindOfClass:[NSEnumerator class]]) {
        NSEnumerator * it = (NSEnumerator *)obj;
        [tr appendString:@" ["];
        
        while ((tmp = [it nextObject]) != nil) {
            id iterValue = tmp;
            [self printForTrace:tr obj:iterValue];
        }
        
        [tr appendString:@" ]"];
    }
    else {
        [tr appendFormat:@" %@", obj];
    }
}

- (NSMutableArray *) getEvents:(ST *)st
{
    if ([debugInfo objectForKey:st] == nil) {
        [debugInfo setObject:st forKey:[NSMutableArray arrayWithCapacity:16]];
    }
    return [debugInfo objectForKey:st];
}

+ (NSInteger) getShort:(char *)memory index:(NSInteger)index
{
    NSInteger b1 = memory[index] & 0xFF;
    NSInteger b2 = memory[index + 1] & 0xFF;
    return b1 << (8 * 1) | b2;
}

- (void) dealloc
{
    [operands release];
    [group release];
    [locale release];
    [errMgr release];
    [events release];
    [executeTrace release];
    [debugInfo release];
    [super dealloc];
}

@end
