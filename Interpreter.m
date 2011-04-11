/*
 * [The "BSD license"]
 *  Copyright (c) 2011 Terence Parr and Alan Condit
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  3. The name of the author may not be used to endorse or promote products
 *     derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 *  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#import <Cocoa/Cocoa.h>
#import "STErrorListener.h"
#import "ArrayIterator.h"
#import "Interpreter.h"
#import "Bytecode.h"
#import "BytecodeDisassembler.h"
#import "CompilationState.h"
#import "CompiledST.h"
#import "Compiler.h"
#import "FormalArgument.h"
#import "STException.h"
#import "StringTable.h"
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
#import "STRuntimeMessage.h"
#import "StringWriter.h"
#import "PrintWriter.h"
#import "GroupParser.h"

@implementation Interpreter_Anon1

@synthesize dict;

+ (id) newInterpreter_Anon1
{
    return [[[Interpreter_Anon1 alloc] init] retain];
}

- (id) init {
    self=[super init];
    if ( self != nil ) {
        dict = [[NSMutableDictionary dictionaryWithCapacity:16] retain];
        [self setObject:@"0"  forKey:@"i"];
        [self setObject:@"1" forKey:@"i1"];
    }
    return self;
}

- (BOOL) containsObject:(NSString *)text
{
    if ([dict objectForKey:text])
        return YES;
    return NO;
}

- (void) setObject:(id)obj forKey:(id)key
{
    [dict setObject:[obj retain] forKey:[key retain]];
}

- (id) objectForKey:(NSString *)key
{
    return [dict objectForKey:key];
}

- (NSInteger) count
{
    return [dict count];
}

- (NSEnumerator *) keyEnumerator
{
    return [dict keyEnumerator];
}
            
- (NSEnumerator *) objectEnumerator
{
    return [dict objectEnumerator];
}
            
            
@end

@implementation Interpreter_Anon2

+ (id) newArrayWithST:(ST *)anST
{
    return [[[Interpreter_Anon2 alloc] initWithST:anST] retain];
}

- (id) initWithST:(ST *)anST
{
    self=[super initWithCapacity:5];
    if ( self != nil ) {
        [self addObject:anST];
    }
    return self;
}

@end

@implementation Interpreter_Anon3
@synthesize Option;

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

+ (id) newInterpreter_Anon3
{
    return [[[Interpreter_Anon3 alloc] init] retain];
}

- (id) init
{
    self=[super init];
    return self;
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
        if ([text isEqualToString:@"anchor"])
            return ANCHOR;
        else if ([text isEqualToString:@"format"])
            return FORMAT;
        else if ([text isEqualToString:@"null"])
            return _NULL;
        else if ([text isEqualToString:@"separator"])
            return SEPARATOR;
        else if ([text isEqualToString:@"wrap"])
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
        if ([text isEqualToString:@"anchor"])
            return ANCHOR;
        else if ([text isEqualToString:@"format"])
            return FORMAT;
        else if ([text isEqualToString:@"null"])
            return _NULL;
        else if ([text isEqualToString:@"separator"])
            return SEPARATOR;
        else if ([text isEqualToString:@"wrap"])
            return WRAP;
    }
    return -1;
}

NSString *OptionDescription(OptionEnum value)
{
    switch (value) {
        case ANCHOR:
            return @"anchor";
        case FORMAT:
            return @"format";
        case _NULL:
            return @"null";
        case SEPARATOR:
            return @"separator";
        case WRAP:
            return @"wrap";
    }
    return nil;
}

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
#define DEF_INSTR_PASSTHRU 22
#define DEF_INSTR_PASSTHRU_IND 23
#define DEF_INSTR_LIST 24
#define DEF_INSTR_ADD 25
#define DEF_INSTR_TOSTR 26
#define DEF_INSTR_FIRST 27
#define DEF_INSTR_LAST 28
#define DEF_INSTR_REST 29
#define DEF_INSTR_TRUNC 30
#define DEF_INSTR_STRIP 31
#define DEF_INSTR_TRIM 32
#define DEF_INSTR_LENGTH 33
#define DEF_INSTR_STRLEN 34
#define DEF_INSTR_REVERSE 35
#define DEF_INSTR_NOT 36
#define DEF_INSTR_OR 37
#define DEF_INSTR_AND 38
#define DEF_INSTR_INDENT 39
#define DEF_INSTR_DEDENT 40
#define DEF_INSTR_NEWLINE 41
#define DEF_INSTR_NOOP 42
#define DEF_INSTR_POP 43
#define DEF_INSTR_NULL 44
#define DEF_INSTR_TRUE 45
#define DEF_INSTR_FALSE 46
#define DEF_INSTR_WRITE_STR 47
#define DEF_INSTR_WRITE_LOCAL 48

#define DEF_MAX_BYTECODE 48

@implementation Interpreter

#ifdef USE_FREQ_COUNT
static NSInteger count[DEF_MAX_BYTECODE+1];
#endif
static NSDictionary *predefinedAnonSubtemplateAttributes;
static Interpreter_Anon3 *Option;
static NSInteger DEFAULT_OPERAND_STACK_SIZE;
/** Dump bytecode instructions as we execute them? mainly for parrt */
static BOOL trace = NO;
/** Track events inside templates and in this.events */

//@synthesize operands;
@synthesize sp;
@synthesize current_ip;
@synthesize nwline;
@synthesize group;
@synthesize locale;
@synthesize errMgr;
@synthesize events;
@synthesize executeTrace;
@synthesize debugInfo;
@synthesize debug;

+ (void) initialize
{
    predefinedAnonSubtemplateAttributes = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"i", @"1", @"i1", nil];
    Option = [Interpreter_Anon3 newInterpreter_Anon3];
    DEFAULT_OPERAND_STACK_SIZE = 100;
}

+ (NSInteger) DEFAULT_OPERAND_STACK_SIZE
{
    return DEFAULT_OPERAND_STACK_SIZE;
}

+ (NSDictionary *)predefinedAnonSubtemplateAttributes
{
    return predefinedAnonSubtemplateAttributes;
}

+ (Interpreter_Anon3 *) Option
{
    return Option;
}

+ (id) newInterpreter:(STGroup *)aGroup locale:(NSLocale *)aLocale debug:(BOOL)aDebug
{
    return [[Interpreter alloc] init:aGroup locale:aLocale debug:aDebug];
}

- (id) initWithGroup:(STGroup *)aGroup debug:(BOOL)aDebug
{
    self = [self init:aGroup locale:[NSLocale currentLocale] errMgr:aGroup.errMgr debug:aDebug];
    return self;
}

- (id) init:(STGroup *)aGroup locale:(NSLocale *)aLocale debug:(BOOL)aDebug
{
    self = [self init:aGroup locale:aLocale errMgr:aGroup.errMgr debug:aDebug];
    return self;
}

- (id) init:(STGroup *)aGroup errMgr:(ErrorManager *)anErrMgr debug:(BOOL)aDebug
{
    self = [self init:aGroup locale:[NSLocale currentLocale] errMgr:anErrMgr debug:aDebug];
    return self;
}

- (id) init:(STGroup *)aGroup locale:(NSLocale *)aLocale errMgr:(ErrorManager *)anErrMgr debug:(BOOL)aDebug
{
    self=[super init];
    if ( self != nil ) {
        //operands = [AMutableArray arrayWithCapacity:10];
        sp = -1;
        current_ip = 0;
        nwline = 0;
        currentScope=nil;
        group = aGroup;
        locale = aLocale;
        errMgr = anErrMgr;
        debug = aDebug;
        if (debug) {
            events = [AMutableArray arrayWithCapacity:5];
//            executeTrace = [AMutableArray arrayWithCapacity:10];
            debugInfo = [NSMutableDictionary dictionaryWithCapacity:5];
        }
    }
    return self;
}

#ifdef USE_FREQ_COUNT
- (void) dumpOpcodeFreq
{
    NSLog(@"#### instr freq:");
    for (int i=1; i <= Bytecode.MAX_BYTECODE; i++) {
        NSLog(@"%d %@", count[i], Bytecode.instructions[i].name);
    }
}
#endif

/**
 * Execute template self and return how many characters it wrote to out
 */
- (NSInteger) exec:(Writer *)anSTWriter who:(ST *)aWho
{
    [self pushScope:self];
    currentScope = [InstanceScope newInstanceScope:currentScope who:aWho]; // push scope
    if ( debug ) {
        currentScope.events = [AMutableArray arrayWithCapacity:5];
        currentScope.childEvalTemplateEvents = [AMutableArray arrayWithCapacity:5];
    }
    currentScope.ret_ip = current_ip;
    @try {
        NSInteger n = [self _exec:anSTWriter who:aWho];
        return n;
    }
    @catch (NSException *e) {
        StringWriter *sw = [StringWriter newWriter];
        PrintWriter *pw = [PrintWriter newWriter:sw];
        [e printStackTrace:pw];
        [errMgr runTimeError:self
                         who:aWho ip:current_ip
                       Error:INTERNAL_ERROR
                         arg:[NSString stringWithFormat:@"internal error caused by: %@", [sw toString]]];
        return 0;
    }
    @finally {
        [self popScope]; // pop scope
    }
    return current_ip;
}
/**
 * Execute template self and return how many characters it wrote to out
 */
- (NSInteger) _exec:(Writer *)anSTWriter who:(ST *)aWho
{
    NSInteger start = [anSTWriter index];
    NSInteger prevOpcode = 0;
    NSInteger n = 0;
    NSInteger n1 = 0;
    NSInteger idx;
    NSInteger nargs;
    NSInteger nameIndex;
    NSInteger optionIndex;
    NSInteger addr;
    NSInteger nmaps;
    NSString *name;
    id obj;
    id left;
    id right;
    id propName;
    ST *st;
    AMutableArray *options;
    //id option_ar[15];
    //id *options = &option_ar[0];
    MemBuffer *code;
    NSInteger ip = 0;
    short opcode;

    //options = [AMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], nil];
    code = aWho.impl.instrs;
    while (ip < aWho.impl.codeSize) {
        if (trace || debug)
            [self trace:aWho ip:ip];
        opcode = [code charAtIndex:ip];
#ifdef USE_FREQ_COUNT
        count[opcode]++;
#endif
        current_ip = ip;
        ip++;
        
        switch (opcode) {
            case  DEF_INSTR_LOAD_STR:
                // just testing...
                [self load_str:aWho ip:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                break;
            case  DEF_INSTR_LOAD_ATTR:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:idx];
                @try {
                    obj = [aWho getAttribute:name];
                }
                @catch (STNoSuchPropertyException *nspe) {
                    [errMgr runTimeError:self who:aWho ip:current_ip error:NO_SUCH_ATTRIBUTE arg:name];
                    obj = nil;
                }
                operands[++sp] = obj;
                break;
            case  DEF_INSTR_LOAD_LOCAL:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = [aWho.locals objectAtIndex:idx];
                if ( obj == ST.EMPTY_ATTR || obj == nil )
                    obj = nil;
                operands[++sp] = obj;
                break;
            case  DEF_INSTR_LOAD_PROP:
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = operands[sp--];
                name = [aWho.impl.strings objectAtIndex:idx];
                operands[++sp] = [self getObjectProperty:anSTWriter who:aWho obj:obj property:name];
                break;
            case  DEF_INSTR_LOAD_PROP_IND:
                propName = operands[sp--];
                obj = operands[sp];
                operands[++sp] = [self getObjectProperty:anSTWriter who:aWho obj:obj property:propName];
                break;
            case  DEF_INSTR_NEW:
                nameIndex = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:nameIndex];
                nargs = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                // look up in original hierarchy not enclosing template (variable group)
                // see TestSubtemplates.testEvalSTFromAnotherGroup()
                st = [aWho.groupThatCreatedThisInstance getEmbeddedInstanceOf:self who:aWho ip:ip name:name];
                [self storeArgs:aWho nargs:nargs st:st];
                sp -= nargs;
                operands[++sp] = st;
                break;
            case  DEF_INSTR_NEW_IND:
                nargs = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = (NSString *)operands[sp - nargs];
                st = [aWho.groupThatCreatedThisInstance getEmbeddedInstanceOf:self who:aWho ip:ip name:name];
                [self storeArgs:aWho nargs:nargs st:st];
                sp -= nargs;
                sp--;
                operands[++sp] = st;
                break;
            case  DEF_INSTR_NEW_BOX_ARGS:
                nameIndex = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:nameIndex];
                NSMutableDictionary *attrs = (NSMutableDictionary *)operands[sp--];
                st = [aWho.groupThatCreatedThisInstance getEmbeddedInstanceOf:self who:aWho ip:ip name:name];
                [self storeArgs:aWho attrs:attrs st:st];
                 operands[++sp] = st;
                break;
            case  DEF_INSTR_SUPER_NEW:
                nameIndex = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:nameIndex];
                nargs = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                [self super_new:aWho name:name nargs:nargs];
                break;
            case  DEF_INSTR_SUPER_NEW_BOX_ARGS:
                nameIndex = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:nameIndex];
                attrs = (NSMutableDictionary *)operands[sp--];
                [self super_new:aWho name:name attrs:attrs];
                break;
            case  DEF_INSTR_STORE_OPTION:
                optionIndex = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = operands[sp--];
                //options = operands[sp];
                //options[optionIndex] = obj;
                options = (AMutableArray *)operands[sp];
                [options replaceObjectAtIndex:optionIndex withObject:obj];
                break;
            case  DEF_INSTR_STORE_ARG:
                idx = [code shortAtIndex:ip];
                name = [aWho.impl.strings objectAtIndex:idx];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = operands[sp--];
                attrs = (NSMutableDictionary *)operands[sp];
                // if ( obj == nil ) obj = [NSNull null];
                if ( name == nil ) name = (NSString *)[NSNull null];
                [attrs setObject:name forKey:obj];
                break;
            case  DEF_INSTR_WRITE:
                obj = operands[sp--];
                idx = [self writeObjectNoOptions:anSTWriter who:aWho obj:obj];
                n += idx;
                nwline += idx;
                break;
            case  DEF_INSTR_WRITE_OPT:
                options = (AMutableArray *)operands[sp--];
                //options = (id *)operands[sp--];
                obj = operands[sp--];
                idx = [self writeObjectWithOptions:anSTWriter who:aWho obj:obj options:options];
                n += idx;
                nwline += idx;
                break;
            case  DEF_INSTR_MAP:
                st = (ST *)operands[sp--];
                obj = operands[sp--];
                [self map:aWho attr:obj st:st];
                break;
            case  DEF_INSTR_ROT_MAP:
                nmaps = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                AMutableArray *templates = [AMutableArray arrayWithCapacity:5];
                for (NSInteger i = nmaps - 1; i >= 0; i--)
                    [templates addObject:(ST *)(operands[sp - i])];
                sp -= nmaps;
                obj = operands[sp--];
                if (obj != nil)
                    [self rot_map:aWho attr:obj prototypes:templates];
                break;
            case  DEF_INSTR_ZIP_MAP:
                st = (ST *)operands[sp--];
                nmaps = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                AMutableArray *exprs = [AMutableArray arrayWithCapacity:5];
                for (NSInteger i = nmaps - 1; i >= 0; i--) {
                    obj = (operands[sp - i]);
                    [exprs addObject:obj];
                }
                sp -= nmaps;
                operands[++sp] = [self zip_map:aWho exprs:exprs prototype:st];
                break;
            case  DEF_INSTR_BR:
                ip = [code shortAtIndex:ip];
                break;
            case  DEF_INSTR_BRF:
                addr = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = operands[sp--];
                if (![self testAttributeTrue:obj])
                    ip = addr;
                break;
            case  DEF_INSTR_OPTIONS:
                 operands[++sp] = [AMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], nil];
                break;
            case  DEF_INSTR_ARGS:
                 operands[++sp] = [NSMutableDictionary dictionaryWithCapacity:5];
                break;
            case DEF_INSTR_PASSTHRU :
                nameIndex = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                name = [aWho.impl.strings objectAtIndex:nameIndex];
                attrs = (AttributeList *)operands[sp];
                [self passthru:aWho templateName:name attrs:attrs];
                break;
            case  DEF_INSTR_LIST:
                operands[++sp] = [AMutableArray arrayWithCapacity:5];
                break;
            case  DEF_INSTR_ADD:
                obj = operands[sp--];
                AMutableArray *list = (AMutableArray *)operands[sp];
                [self addToList:list obj:obj];
                break;
            case  DEF_INSTR_TOSTR:
                operands[sp] = [self description:anSTWriter who:aWho value:operands[sp]];
                break;
            case  DEF_INSTR_FIRST:
                operands[sp] = [self first:operands[sp]];
                break;
            case  DEF_INSTR_LAST:
                operands[sp] = [self last:operands[sp]];
                break;
            case  DEF_INSTR_REST:
                operands[sp] = [self rest:operands[sp]];
                break;
            case  DEF_INSTR_TRUNC:
                operands[sp] = [self trunc:operands[sp]];
                break;
            case  DEF_INSTR_STRIP:
                operands[sp] = [self strip:operands[sp]];
                break;
            case  DEF_INSTR_TRIM:
                obj = operands[sp--];
                if ([obj isKindOfClass:[NSString class]]) {
                    operands[++sp] = [((NSString *)obj) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                }
                else {
                    [errMgr runTimeError:self who:aWho ip:current_ip error:EXPECTING_STRING arg:@"trim" arg2:[obj className]];
                    operands[++sp] = obj;
                }
                break;
            case  DEF_INSTR_LENGTH:
                obj = operands[sp];
                operands[sp] = (id)[NSString stringWithFormat:@"%d",[self length:operands[sp]]];
                break;
            case  DEF_INSTR_STRLEN:
                obj = operands[sp--];
                if ([obj isKindOfClass:[NSString class]]) {
                    operands[++sp] = (id)[NSString stringWithFormat:@"%d",[((NSString *)obj) length]];
                }
                else {
                    [errMgr runTimeError:self who:aWho ip:current_ip error:EXPECTING_STRING arg:@"strlen" arg2:[obj className]];
                    operands[++sp] = @"0";
                }
                break;
            case  DEF_INSTR_REVERSE:
                operands[sp] = [self reverse:operands[sp]];
                break;
            case  DEF_INSTR_NOT:
                operands[sp] = (id)(![self testAttributeTrue:operands[sp]]);
                break;
            case  DEF_INSTR_OR:
                right = operands[sp--];
                left = operands[sp--];
                operands[++sp] = (id)([self testAttributeTrue:left] || [self testAttributeTrue:right]);
                break;
            case  DEF_INSTR_AND:
                right = operands[sp--];
                left = operands[sp--];
                operands[++sp] = (id)([self testAttributeTrue:left] && [self testAttributeTrue:right]);
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
                        [anSTWriter writeStr:Misc.newline];
                    }
                    nwline = 0;
                }
                @catch (IOException *ioe) {
                    [errMgr IOError:aWho error:WRITE_IO_ERROR e:ioe];
                }
                break;
            case  DEF_INSTR_NOOP:
                break;
            case  DEF_INSTR_POP:
                sp--;
                break;
            case  DEF_INSTR_NULL:
                 operands[++sp] = [NSNull null];
                break;
            case DEF_INSTR_TRUE:
                operands[++sp] = (id) YES;
                break;
            case DEF_INSTR_FALSE :
                operands[++sp] = NO;
                break;
            case DEF_INSTR_WRITE_STR :
                idx = [code shortAtIndex:ip];
                ip += Bytecode.OPND_SIZE_IN_BYTES;
                obj = [aWho.impl.strings objectAtIndex:idx];
                n1 = [self writeObjectNoOptions:anSTWriter who:aWho obj:obj];
                n += n1;
                nwline += n1;
                break;
//            case DEF_INSTR_WRITE_LOCAL:
//                idx = [code shortAtIndex:ip];
//                ip += Bytecode.OPND_SIZE_IN_BYTES;
//                obj = [aWho.locals objectAtIndex:idx];
//                if ( obj==ST.EMPTY_ATTR ) obj = nil;
//                n1 = [self writeObjectNoOptions:anSTWriter who:aWho obj:obj];
//                n += n1;
//                nwline += n1;
//                break;
            default:
                [errMgr internalError:aWho msg:[NSString stringWithFormat:@"invalid bytecode @ %d:%d", ip - 1, opcode] e:nil];
                [aWho.impl dump];
                break;
        }
        prevOpcode = opcode;
    }
    
    if ( debug ) {
        NSInteger stop = [anSTWriter index] - 1;
        EvalTemplateEvent *e = [EvalTemplateEvent newEvalTemplateEventWithWho:(DebugST *)aWho start:start stop:stop];
        [self trackDebugEvent:self event:e];
//        [events addObject:e];
//        if (aWho.enclosingInstance != nil) {
//            ST *parent = ((ST *)aWho).enclosingInstance;
//            [[self getEvents:parent] addObject:e];
//        }
    }
    return n;
}

- (void) load_str:(ST *)who ip:(NSInteger)ip
{
    int strIndex = [who.impl.instrs shortAtIndex:ip];
    ip += Bytecode.OPND_SIZE_IN_BYTES;
    operands[++sp] = [who.impl.strings objectAtIndex:strIndex];
}

// TODO: refactor to remove dup'd code
- (void) super_new:(ST *)aWho name:(NSString *)name nargs:(NSInteger)nargs
{
    ST *st = nil;
    CompiledST *imported = [aWho.impl.nativeGroup lookupImportedTemplate:name];
    if (imported == nil) {
        [errMgr runTimeError:self who:aWho ip:current_ip error:NO_IMPORTED_TEMPLATE arg:name];
        st = [aWho.groupThatCreatedThisInstance createStringTemplateInternally];
        st.impl = [CompiledST newCompiledST];
        sp -= nargs;
        operands[++sp] = st;
        return;
    }
    st = [imported.nativeGroup createStringTemplateInternally];
    st.groupThatCreatedThisInstance = group;
    st.impl = imported;
    [self storeArgs:aWho nargs:nargs st:st];
    sp -= nargs;
    operands[++sp] = st;
}

- (void) super_new:(ST *)aWho name:(NSString *)name attrs:(NSMutableDictionary *)attrs
{
    ST *st = nil;
    CompiledST *imported = [aWho.impl.nativeGroup lookupImportedTemplate:name];
    if (imported == nil) {
        [errMgr runTimeError:self who:aWho ip:current_ip error:NO_IMPORTED_TEMPLATE arg:name];
        st = [aWho.groupThatCreatedThisInstance createStringTemplateInternally];
        st.impl = [CompiledST newCompiledST];
        operands[++sp] = st;
        return;
    }

    st = [imported.nativeGroup createStringTemplateInternally];
    st.groupThatCreatedThisInstance = group;
    st.impl = [CompiledST newCompiledST];

    // get n args and store into st's attr list
    [self storeArgs:aWho attrs:attrs st:st];
    operands[++sp] = st;
}

- (void) passthru:(ST *)aWho templateName:(NSString *)templateName attrs:(AMutableArray *)attrs
{
    CompiledST *c = [group lookupTemplate:templateName];
    if ( c == nil ) return; // will get error later
    for (FormalArgument *arg in [c.formalArguments allObjects]) {
        if ( [attrs objectForKey:arg.name] == nil ) {
            //System.out.println("arg "+arg.name+" missing");
            id obj = [self getAttribute:aWho name:arg.name];
            //System.out.println("setting to "+obj);
            [attrs setObject:obj forKey:arg.name];
        }
    }
}

- (void) storeArgs:(ST *)aWho attrs:(NSMutableDictionary *)attrs st:(ST *)st
{
    NSInteger nformalArgs = 0;
    if (st.impl.formalArguments != nil)
        nformalArgs = [st.impl.formalArguments count];
    NSInteger nargs = 0;
    if (attrs != nil)
        nargs = [attrs count];
    if (nargs < (nformalArgs - st.impl.numberOfArgsWithDefaultValues) || nargs > nformalArgs) {
        [errMgr runTimeError:self
                         who:aWho
                          ip:current_ip
                       error:ARGUMENT_COUNT_MISMATCH
                         arg:(id)nargs
                        arg2:st.impl.name
                        arg3:(id)nformalArgs];
    }
    
    for (NSString *argName in [attrs allKeys]) {
        if ([st.impl.formalArguments objectForKey:argName] == nil) {
            [errMgr runTimeError:self
                             who:aWho
                              ip:current_ip
                           error:NO_SUCH_ATTRIBUTE
                             arg:argName];
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
    if (nargs < (nformalArgs - st.impl.numberOfArgsWithDefaultValues) || nargs > nformalArgs) {
        [errMgr runTimeError:self
                         who:aWho
                          ip:current_ip
                       error:ARGUMENT_COUNT_MISMATCH
                         arg:(id)nargs
                        arg2:st.impl.name
                        arg3:(id)nformalArgs];
    }
    if (st.impl.formalArguments == nil)
        return;
    ArrayIterator *argNames = (ArrayIterator *)[ArrayIterator newIteratorForDictKey:(NSDictionary *)st.impl.formalArguments];

    id obj;
    for (NSInteger i = 0; i < numToStore; i++) {
        obj = operands[firstArg + i];
        NSString *argName = [argNames nextObject];
        [st rawSetAttribute:argName value:obj];
    }
}


/**
 * Write out an expression result that doesn't use expression options.
 * E.g., <name>
 */
- (NSInteger) storeArgs:(Writer *)anSTWriter who:(ST *)aWho obj:(id)obj
{
    NSInteger start = [anSTWriter index];
    NSInteger n = [self writeObject:anSTWriter who:aWho obj:obj options:nil];
    if (debug) {
        Interval *templateLocation = [aWho.impl.sourceMap objectAtIndex:current_ip];
        NSInteger exprStart = -1;
        NSInteger exprStop = -1;
        if (templateLocation != nil) {
            exprStart = templateLocation.a;
            exprStop = templateLocation.b;
        }
        EvalExprEvent *e = [EvalExprEvent newEvalExprEventWithWho:aWho start:start stop:[anSTWriter index]-1 exprStart:exprStart exprStop:exprStop];
        [anSTWriter println:e];
        [events addObject:e];
    }
    return n;
}

- (void) indent:(id<STWriter>)wr1 who:(ST *)aWho index:(NSInteger)strIndex
{
    NSString *indent = [aWho.impl.strings objectAtIndex:strIndex];
    if ( debug ) {
        int aStart = [wr1 index]; // track char we're about to write
        EvalExprEvent *e = [EvalExprEvent newEvalExprEventWithWho:(DebugST *)aWho
                                                            start:aStart
                                                             stop:aStart + [indent length] - 1
                                                        exprStart:[self getExprStartChar:aWho]
                                                         exprStop:[self getExprStopChar:aWho]];
        [self trackDebugEvent:self event:e];
    }
    [wr1 pushIndentation:indent];
}

/** Write out an expression result that doesn't use expression options.
 *  E.g., <name>
 */
- (NSInteger) writeObjectNoOptions:(Writer *)wr1 who:(ST *)aWho obj:(id)obj
{
    int aStart = [wr1 index]; // track char we're about to write
    int n = [self writeObject:wr1 who:aWho obj:obj options:nil];
    if ( debug ) {
        EvalExprEvent *e = [EvalExprEvent newEvalExprEventWithWho:(DebugST *) aWho
                                                            start:aStart
                                                             stop:[wr1 index] - 1
                                                        exprStart:[self getExprStartChar:aWho]
                                                         exprStop:[self getExprStopChar:aWho]];
        [self trackDebugEvent:self event:e];
    }
    return n;
}

/**
 * Write out an expression result that uses expression options.
 * E.g., <names; separator=", ">
 */
- (NSInteger) writeObjectWithOptions:(Writer *)anSTWriter who:(ST *)aWho obj:(id)obj options:(AMutableArray *)options
{
    NSInteger start = [anSTWriter index];
    AMutableArray *optionStrings = nil;
    if (options != nil) {
        optionStrings = [AMutableArray arrayWithObjects:@"", @"", @"", @"",@"", nil];
        for (NSInteger i = 0; i < Compiler.NUM_OPTIONS; i++) {
            id obj = [self description:anSTWriter who:aWho value:[options objectAtIndex:i]];
            [optionStrings replaceObjectAtIndex:i withObject:obj];
        }
    }
    if (options != nil && [options objectAtIndex:Interpreter.Option.ANCHOR] != nil) {
        [anSTWriter pushAnchorPoint];
    }

    NSInteger n = [self writeObject:anSTWriter who:aWho obj:obj options:optionStrings];

    if (options != nil && [options objectAtIndex:Interpreter.Option.ANCHOR] != nil) {
        [anSTWriter popAnchorPoint];
    }
    if ( debug ) {
        EvalExprEvent *e = [EvalExprEvent newEvalExprEventWithWho:aWho start:start stop:[anSTWriter index]-1 exprStart:[self getExprStart:aWho] exprStop:[self getExprStop:aWho]];
        [self trackDebugEvent:self event:e];

    }
    return n;
}


/**
 * Generic method to emit text for an object. It differentiates
 * between templates, iterable objects, and plain old Java objects (POJOs)
 */
- (NSInteger) writeObject:(Writer *)anSTWriter who:(ST *)aWho obj:(id)obj options:(AMutableArray *)options
{
    NSInteger n = 0;
    if ( obj == nil ) {
        if ( options != nil && [options objectAtIndex:Interpreter.Option._NULL] != nil ) {
            obj = [options objectAtIndex:Interpreter.Option._NULL];
        }
        else {
            return 0;
        }
    }
    if ( [obj isKindOfClass:[ST class]] ) {
        ST *st = obj;
        if ( options != nil && [options objectAtIndex:Interpreter.Option.WRAP] != nil ) {
            @try {
                [anSTWriter writeWrap:[options objectAtIndex:Interpreter.Option.WRAP]];
            }
            @catch (IOException *ioe) {
                [errMgr IOError:aWho error:WRITE_IO_ERROR e:ioe];
            }
        }
        n = [self exec:anSTWriter who:st];
    }
    else {
        obj = [Interpreter convertAnythingIteratableToIterator:obj];
        
        @try {
            if ( [obj isKindOfClass:[ArrayIterator class]] )
                n = [self writeIterator:anSTWriter who:aWho obj:obj options:options];
            else
                n = [self writePOJO:anSTWriter obj:obj options:options];
        }
        @catch (IOException *ioe) {
            [errMgr IOError:aWho error:WRITE_IO_ERROR e:ioe arg:obj];
        }
    }
    return n;
}

- (NSInteger) writeIterator:(Writer *)anSTWriter who:(ST *)aWho obj:(id)obj options:(AMutableArray *)options
{
    if (obj == nil )
        return 0;
    NSInteger n = 0;
    ArrayIterator *it = (ArrayIterator *)obj;
    NSString *separator = nil;
    if ( options != nil ) {
        separator = [options objectAtIndex:Interpreter.Option.SEPARATOR];
    }
    BOOL seenAValue = NO;

    id iterValue;
    while ( [it hasNext] ) {
        iterValue = [it nextObject];
        BOOL needSeparator = seenAValue &&
                             separator != nil &&
                             ( iterValue != nil ||
                               [options objectAtIndex:Interpreter.Option._NULL] != nil);
        if ( needSeparator )
            n += [anSTWriter writeSeparator:separator];
        NSInteger nw = [self writeObject:anSTWriter who:aWho obj:iterValue options:options];
        if ( nw > 0 )
            seenAValue = YES;
        n += nw;
    }
    return n;
}

- (NSInteger) writePOJO:(Writer *)anSTWriter obj:(id)obj options:(AMutableArray *)options {
    NSString *formatString = nil;
    if (options != nil)
        formatString = [options objectAtIndex:Interpreter.Option.FORMAT];
    AttributeRenderer *r = [group getAttributeRenderer:[obj class]];
    NSString *v;
    if ( r != nil )
        v = [r description:obj formatString:formatString locale:locale];
    else {
        if ( obj == nil )
            v = @"";
        else
            v = [obj description];
    }
    NSInteger n;
    if ( options != nil && [options objectAtIndex:Interpreter.Option.WRAP] != nil ) {
        n = [anSTWriter write:v wrap:[options objectAtIndex:Interpreter.Option.WRAP]];
    }
    else {
        n = [anSTWriter writeStr:v];
    }
    return n;
}

- (NSInteger) getExprStartChar:(ST *)aWho
{
    Interval *templateLocation = [aWho.impl.sourceMap objectAtIndex:current_ip];
    if ( templateLocation!=nil ) return templateLocation.a;
    return -1;
}

- (NSInteger) getExprStopChar:(ST *)aWho
{
    Interval *templateLocation = [aWho.impl.sourceMap objectAtIndex:current_ip];
    if ( templateLocation!=nil ) return templateLocation.b;
    return -1;
}

- (void) map:(ST *)awho attr:(id)attr st:(ST *)st
{
    [self rot_map:awho attr:attr prototypes:[Interpreter_Anon2 newArrayWithST:st]];
}

- (void) rot_map:(ST *)aWho attr:(id)attr prototypes:(AMutableArray *)prototypes
{
    if (attr == nil) {
        operands[++sp] = nil;
        return;
    }
    attr = [Interpreter convertAnythingIteratableToIterator:attr];
    if ([attr isKindOfClass:[ArrayIterator class]]) {
        AMutableArray *mapped = [self rot_map_iterator:aWho iter:attr proto:prototypes];
        operands[++sp] = mapped;
    }
    else {
        ST *proto = [prototypes objectAtIndex:0];
        ST *st = [group createStringTemplateInternally:proto];
        if (st != nil) {
            [self setFirstArgument:aWho st:st attr:attr];
            if (st.impl.isAnonSubtemplate) {
                [st rawSetAttribute:@"i0" value:@"0"];
                [st rawSetAttribute:@"i" value:@"1"];
            }
            operands[++sp] = st;
        }
        else {
            operands[++sp] = nil;
        }
    }
}

- (AMutableArray *) rot_map_iterator:(ST *)aWho iter:(id)attr proto:(AMutableArray *)prototypes
{
    ArrayIterator *iter = (ArrayIterator *)attr;
    AMutableArray *mapped = [AMutableArray arrayWithCapacity:5];
    NSInteger i0 = 0;
    NSInteger i = 1;
    NSInteger ti = 0;
    id iterValue;
    
    while ( [iter hasNext] ) {
        iterValue = [iter nextObject];
        if ( iterValue == nil ) {
            [mapped addObject:nil];
            continue;
        }
        NSInteger templateIndex = ti % [prototypes count];
        ti++;
        ST *proto = [prototypes objectAtIndex:templateIndex];
        ST *st = [group createStringTemplateInternally:proto];
        [self setFirstArgument:aWho st:st attr:iterValue];
        if ( st.impl.isAnonSubtemplate ) {
            [st rawSetAttribute:@"i0" value:[NSString stringWithFormat:@"%d", i0]];
            [st rawSetAttribute:@"i" value:[NSString stringWithFormat:@"%d", i]];
        }
        [mapped addObject:st];
        i0++;
        i++;
    }
    return mapped;
}

// <names,phones:{n,p | ...}> or <a,b:t()>
// todo: i, i0 not set unless mentioned? map:{k,v | ..}?
- (AttributeList *) zip_map:(ST *)aWho exprs:(AMutableArray *)exprs prototype:(ST *)prototype
{
    if (exprs == nil || prototype == nil || [exprs count] == 0) {
        return nil;
    }
    for (NSInteger i = 0; i < [exprs count]; i++) {
        id attr = [exprs objectAtIndex:i];
        if (attr != [NSNull null])
            [exprs replaceObjectAtIndex:i withObject:[Interpreter convertAnythingToIterator:attr]];
    }
    
    NSInteger numExprs = [exprs count];
    CompiledST *code = prototype.impl;
    NSMutableDictionary *formalArguments = code.formalArguments;
    if (!code.hasFormalArgs || formalArguments == nil) {
        [errMgr runTimeError:self who:aWho ip:current_ip error:MISSING_FORMAL_ARGUMENTS];
        return nil;
    }
    NSArray *formalArgumentNames = [formalArguments allKeys];
    NSInteger nformalArgs = [formalArgumentNames count];
    if ([prototype getIsAnonSubtemplate])
        nformalArgs -= [predefinedAnonSubtemplateAttributes count];
    if (nformalArgs != numExprs) {
        [errMgr runTimeError:self who:aWho ip:current_ip error:MAP_ARGUMENT_COUNT_MISMATCH arg:(id)numExprs arg2:(id)nformalArgs];
        NSInteger shorterSize = ([formalArgumentNames count] > numExprs)?[formalArgumentNames count]:numExprs;
        numExprs = shorterSize;
        NSArray *newFormalArgumentNames;
        newFormalArgumentNames = [formalArgumentNames subarrayWithRange:NSMakeRange(0,shorterSize)];
        [formalArgumentNames release];
        formalArgumentNames = newFormalArgumentNames;
    }
    AttributeList *results = [AttributeList arrayWithCapacity:5];
    NSInteger i = 0;
    
    while (YES) {
        NSInteger numEmpty = 0;
        ST *embedded = [group createStringTemplateInternally:prototype];
        [embedded rawSetAttribute:@"i0" value:[NSString stringWithFormat:@"%d", i]];
        [embedded rawSetAttribute:@"i"  value:[NSString stringWithFormat:@"%d", i + 1]];
        
        for (NSInteger a = 0; a < numExprs; a++) {
            ArrayIterator *it = (ArrayIterator *)[exprs objectAtIndex:a];
            if (it != nil && [it hasNext]) {
                NSString *argName = (NSString *)[formalArgumentNames objectAtIndex:a];
                id iteratedValue = [it nextObject];
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
        [errMgr runTimeError:self who:aWho ip:current_ip error:ARGUMENT_COUNT_MISMATCH arg:(id)1 arg2:(id)st.impl.name arg3:(id)0];
        return;
    }
    [st.locals insertObject:attr atIndex:0];
}

- (void) addToList:(AMutableArray *)list obj:(id)obj
{
    obj = [Interpreter convertAnythingIteratableToIterator:obj];
    if ([obj isKindOfClass:[ArrayIterator class]]) {
        ArrayIterator *it = (ArrayIterator *)obj;
        while ([it hasNext])
            [list addObject:[it nextObject]];
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
    if ( v == nil )
        return v;
    id r = v;
    id tmp;
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[ArrayIterator class]]) {
        ArrayIterator *it = v;
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
    if ( v == nil )
        return v;
    if ([v isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)v;
        return [array objectAtIndex:[array count] - 1];
    }
    else if ([v isKindOfClass:[AMutableArray class]]) {
        AMutableArray *elems = (AMutableArray *)v;
        return [elems objectAtIndex:[elems count]-1];
    }
    id last = v;
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[ArrayIterator class]]) {
        ArrayIterator *it = v;
        while ([it hasNext])
            last = [it nextObject];
    }
    return last;
}


/**
 * Return everything but the first attribute if multiple valued
 * or null if single-valued.
 */
- (id) rest:(id)v
{
    if ( v == nil )
        return v;
    id obj;
    if ([v isKindOfClass:[NSArray class]]) {
        NSArray *elems = (NSArray *)v;
        if ([elems count] <= 1)
            return [NSNull null];
        return [elems subarrayWithRange:NSMakeRange(1, [elems count]-1)];
    }
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[ArrayIterator class]]) {
        ArrayIterator *it = v;
        if ( ![it hasNext] )
            return nil; // if not even one value return nil
        [it nextObject]; // ignore first value
        AMutableArray *a = nil;
        if ( [it hasNext] ) { // Don't bother creating array if your not going to use it
            a = [AMutableArray arrayWithCapacity:5];
            while ([it hasNext]) {
                obj = [it nextObject];
                if ( obj != nil )
                    [a addObject:obj];
            };
        }
        return a;
    }
    return nil;
}


/**
 * Return all but the last element.  trunc(x)=null if x is single-valued.
 */
- (id) trunc:(id)v
{
    if ( v == nil )
        return v;
    if ( [v isKindOfClass:[NSArray class]] ) {
        NSArray *elems = (NSArray *)v;
        if ( [elems count] <= 1 )
            return nil;
        return [elems subarrayWithRange:NSMakeRange(0, [elems count] - 1)];
    }
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[ArrayIterator class]]) {
        ArrayIterator *it = (ArrayIterator *)v;
        NSArray *array = [it allObjects];
        NSArray *a = [array subarrayWithRange:NSMakeRange(0, [array count]-1)];
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
    if ( v == nil )
        return v;
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[ArrayIterator class]]) {
        AMutableArray *a = [AMutableArray arrayWithCapacity:5];
        ArrayIterator *it = (ArrayIterator *)v;
        
        while ((obj = [it nextObject]) != nil) {
            if ( obj != nil )
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
    if ( v == nil )
        return v;
    v = [Interpreter convertAnythingIteratableToIterator:v];
    if ([v isKindOfClass:[ArrayIterator class]]) {
        AMutableArray *a = [AMutableArray arrayWithCapacity:5];
        ArrayIterator *it = v;

        while ([it hasNext]) {
            [a insertObject:[it nextObject] atIndex:0];
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
    if ( v == nil )
        return 0;
    NSInteger i = 1;
    if ( [v isKindOfClass:[NSMutableDictionary class]] )
        i = [((NSMutableDictionary *)v) count];
    else if ( [v isKindOfClass:[AMutableArray class]] )
        i = [((AMutableArray *)v) count];
    else if ( [v isKindOfClass:[NSArray class]] )
        i = [((NSArray *)v) count];
    else if ( [v isKindOfClass:[ArrayIterator class]] ) {
        ArrayIterator *it = v;
        int i = 0;
        while ([it hasNext]) {
            [it nextObject];
            i++;
        }
    }
    return i;
}

- (NSString *) description:(id<STWriter>)wr1 who:(ST *)aWho value:(id)value
{
    Class writerClass;
    Writer *stw;
    if ( value != nil ) {
        if ([value isKindOfClass:[NSString class]])
            return (NSString *)value;
        if ([value isKindOfClass:[ST class]])
            ((ST *)value).enclosingInstance = aWho;
        StringWriter *sw = [StringWriter newWriter];
        @try {
            writerClass = [wr1 class];
            // Constructor *ctor = [writerClass  getConstructor:@"newWriter"];
            stw = [[wr1 class] newWriterWithWriter:sw];
        }
        @catch (NSException *e) {
            stw = [[wr1 class] newWriterWithWriter:sw];
            [errMgr runTimeError:self who:aWho ip:current_ip error:WRITER_CTOR_ISSUE arg:[NSString stringWithCString:class_getName([wr1 class]) encoding:NSASCIIStringEncoding]];
        }
        [self writeObjectNoOptions:[NoIndentWriter newNoIdentWriter:sw] who:aWho obj:value];
        return [sw description];
    }
    return nil;
}

- (NSString *) toString:(id<STWriter>)wr1 who:(ST *)aWho value:(id)value
{
    return [self description:wr1 who:aWho value:value];
}

+ (ArrayIterator *) convertAnythingIteratableToIterator:(id)obj
{
    ArrayIterator *iter = nil;
    if ( obj == nil )
        return nil;
    if ( [obj isKindOfClass:[AMutableArray class]] ) {
        AMutableArray *obj1 = obj;
        iter = (ArrayIterator *)[obj1 objectEnumerator];
    }
    else if ( [obj  isKindOfClass:[NSArray class]] )
        iter = (ArrayIterator *)[ArrayIterator newIterator:(NSArray *)obj];
    else if ( [obj isKindOfClass:[NSMutableDictionary class]] )
        iter = (ArrayIterator *)[ArrayIterator newIteratorForDictKey:(NSDictionary *)obj];
    else if ( [obj isKindOfClass:[ArrayIterator class]] )
        iter = (ArrayIterator *)obj;
    if ( iter == nil )
        return obj;
    return iter;
}

+ (ArrayIterator *) convertAnythingToIterator:(id)obj
{
    obj = [Interpreter convertAnythingIteratableToIterator:obj];
    if ([obj isKindOfClass:[ArrayIterator class]])
        return (ArrayIterator *)obj;
    AttributeList *singleton = [AttributeList arrayWithCapacity:1];
    [singleton addObject:obj];
    return (ArrayIterator *)[singleton objectEnumerator];
}

- (BOOL) testAttributeTrue:(id)a
{
    if (a == nil)
        return NO;
    if ([a isKindOfClass:[NSNumber class]])
        return [(NSNumber *)a boolValue];
    if ([a isKindOfClass:[NSString class]])
        return [(NSString *)a boolValue];
    if ([a isKindOfClass:[AMutableArray class]])
        return [((AMutableArray *)a) count] > 0;
    if ([a isKindOfClass:[NSMutableDictionary class]])
        return [((NSMutableDictionary *)a) count] > 0;
    if ([a isKindOfClass:[ArrayIterator class]]) {
        return [((ArrayIterator *)a) hasNext];
    }
    return YES;
}

- (id) getObjectProperty:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj property:(id)property
{
    if ( obj == nil ) {
        [errMgr runTimeError:self who:aWho ip:current_ip error:NO_SUCH_PROPERTY arg:@"null attribute"];
        return nil;
    }
    
    @try {
        id<ModelAdaptor> adap = [aWho.groupThatCreatedThisInstance getModelAdaptor:[obj class]];
        return [adap getProperty:self who:aWho obj:obj property:property propertyName:[self description:anSTWriter who:aWho value:property]];
    }
    @catch (STNoSuchPropertyException *e) {
        [errMgr runTimeError:self who:aWho ip:current_ip error:NO_SUCH_PROPERTY e:e arg:[NSString stringWithFormat:@"%@.%@", [obj className], property]];
    }
    return nil;
}


/** Find an attr via dynamic scoping up enclosing scope chain.
 *  If not found, look for a map.  So attributes sent in to a template
 *  override dictionary names.
 *
 *  return EMPTY_ATTR if found def but no value
 */
- (id) getAttribute:(ST *)aWho name:(NSString *)name
{
    InstanceScope *scope = currentScope;
    while ( scope!= nil ) {
        ST *p = scope.st;
        FormalArgument *localArg = nil;
        if ( p.impl.formalArguments != nil )
            localArg = [p.impl.formalArguments objectForKey:name];
        if ( localArg != nil ) {
            id obj = [p.locals objectAtIndex:localArg.index];
            return obj;
        }
        scope = scope.parent; // look up enclosing scope chain
    }
    // got to root scope and no definition, try dictionaries in group
    if ( [aWho.impl.nativeGroup isDictionary:name] ) {
        return [aWho.impl.nativeGroup rawGetDictionary:name];
    }

    // not found, report unknown attr
    if ( ST.cachedNoSuchPropException == nil ) {
        [ST setCachedNoSuchPropException:[STNoSuchPropertyException newException:name]];
    }
    @throw ST.cachedNoSuchPropException;
}

/** Set any default argument values that were not set by the
 *  invoking template or by setAttribute directly.  Note
 *  that the default values may be templates.
 *
 *  The evaluation context is the invokedST template itself so
 *  template default args can see other args.
 */
- (void) setDefaultArguments:(id<STWriter>)wr1 who:(ST *)invokedST
{
    ST *defaultArgST;
    if ( invokedST.impl.formalArguments == nil || invokedST.impl.numberOfArgsWithDefaultValues == 0 )
        return;

    //ArrayIterator *it = (ArrayIterator *)[ArrayIterator newIteratorForDictKey:invokedST.impl.formalArguments];
    FormalArgument *arg;
    // while (arg = [it nextObject]) {
    for ( arg in [invokedST.impl.formalArguments allValues] ) {
        if ([invokedST.locals objectAtIndex:(([arg isKindOfClass:[FormalArgument class]])? arg.index:0)] == ST.EMPTY_ATTR||
            arg.defaultValueToken == nil ) {
            continue;
        }
        if ( arg.defaultValueToken.type == ANONYMOUS_TEMPLATE ) {
            defaultArgST = [group createStringTemplate];
            // default arg template must see other args so it's enclosing
            // instance is the template we are invoking.
            defaultArgST.enclosingInstance = invokedST;
            defaultArgST.groupThatCreatedThisInstance = group;
            defaultArgST.impl = arg.compiledDefaultValue;
            // If default arg is template with single expression
            // wrapped in parens, x={<(...)>}, then eval to string
            // rather than setting x to the template for later
            // eval.
#ifdef DONTUSENOMO
            [wr1 println:[[@"setting def arg " stringByAppendingString:arg.name] stringByAppendingString:@" to "] + defaultArgST];
#endif
#pragma mark remove debugging print statements
            // [anSTWriter println:[NSString stringWithFormat:@"setting def arg %@ to %@", arg.name, defaultArgST ]];
            NSLog( @"setting def arg %@ to %@", arg.name, defaultArgST );
            // If default arg is template with single expression
            // wrapped in parens, x={<(...)>}, then eval to string
            // rather than setting x to the template for later
            // eval.
            NSString *defArgTemplate = arg.defaultValueToken.text;
            if ( [defArgTemplate hasPrefix:[NSString stringWithFormat:@"{%c(", group.delimiterStartChar]] &&
                [defArgTemplate hasSuffix:[NSString stringWithFormat:@")%c}", group.delimiterStopChar]] ) {
                [invokedST rawSetAttribute:arg.name value:[self description:wr1 who:invokedST value:defaultArgST]];
            }
            else {
                [invokedST rawSetAttribute:arg.name value:defaultArgST];
            }
        }
        else {
            [invokedST rawSetAttribute:arg.name value:defaultArgST];
        }
    }
}

- (void) popScope
{
    current_ip = currentScope.ret_ip;
    currentScope = currentScope.parent; // pop
}

- (void) pushScope:(ST *)aWho
{
    currentScope = [InstanceScope newInstanceScope:currentScope who:aWho]; // push
    if ( debug ) {
        currentScope.events = [AMutableArray arrayWithCapacity:5];
        currentScope.childEvalTemplateEvents = [AMutableArray arrayWithCapacity:5];
    }
    currentScope.ret_ip = current_ip;
}

/** If an instance of x is enclosed in a y which is in a z, return
 *  a String of these instance names in order from topmost to lowest;
 *  here that would be "[z y x]".
 */
- (NSString *)getEnclosingInstanceStackString:(InstanceScope *)scope
{
    AMutableArray *templates = [self getEnclosingInstanceStack:scope topdown:YES];
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    int i = 0;
    for (ST *st in templates) {
        if ( i > 0 ) [buf appendString:@" "];
        [buf appendString:[st getName]];
        i++;
    }
    return buf;
}

- (AMutableArray *)getEnclosingInstanceStack:(InstanceScope *)scope topdown:(BOOL)topdown
{
    AMutableArray *stack = [AMutableArray arrayWithCapacity:5];
    InstanceScope *p = scope;
    while ( p != nil ) {
        if ( topdown ) [stack insertObject:p.st atIndex:0];
        else [stack addObject:p.st];
        p = p.parent;
    }
    return stack;
}

- (AMutableArray *) getScopeStack:(InstanceScope *)scope direction:(BOOL)topdown
{
    AMutableArray *stack = [AMutableArray arrayWithCapacity:10];
    InstanceScope *p = scope;
    while ( p != nil ) {
        if ( topdown ) [stack insertObject:p atIndex:0];
        else [stack addObject:p];
        p = p.parent;
    }
    return stack;
}

- (AMutableArray *) getEvalTemplateEventStack:(InstanceScope *)scope direction:(BOOL)topdown
{
    AMutableArray *stack = [AMutableArray arrayWithCapacity:10];
    InstanceScope *p = scope;
    while ( p != nil ) {
        EvalTemplateEvent *eval = [(EvalTemplateEvent *)p.events objectAtIndex:[p.events count]-1];
        if ( topdown ) [stack insertObject:eval atIndex:0];
        else [stack addObject:eval];
        p = p.parent;
    }
    return stack;
}

- (void) trace:(ST *)aWho ip:(NSInteger)ip
{
    NSMutableString *tr = [NSMutableString stringWithCapacity:16];
    BytecodeDisassembler *dis = [BytecodeDisassembler newBytecodeDisassembler:aWho.impl];
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    [dis disassembleInstruction:buf ip:ip];
    NSString *name = [NSString stringWithFormat:@"%@:", aWho.impl.name];
    if (aWho.impl.name == ST.UNKNOWN_NAME)
        name = @"";
    [tr appendString:[NSMutableString stringWithFormat:@"%-40s%@%@\tstack=[", name, buf]];
    
    for (NSInteger i = 0; i <= sp; i++) {
        id obj = operands[i];
        [self printForTrace:tr obj:obj];
    }
    
    [tr appendFormat:@" ], calls=%@, sp=%d, nw=%d", [self getEnclosingInstanceStackString:currentScope], sp, nwline];
    NSString *s = [NSString stringWithString:tr];
    if (debug)
        [executeTrace addObject:s];
    if (trace) {
        NSLog(@"%@", s );
    }
}

- (void) printForTrace:(NSMutableString *)tr obj:(id)obj
{
    if ([obj isKindOfClass:[ST class]]) {
        if (((ST *)obj).impl == nil)
            [tr appendString:@"bad-template()"];
        else
            [tr appendFormat:@" %@()", ((ST *)obj).impl.name];
        return;
    }
    obj = [Interpreter convertAnythingIteratableToIterator:obj];
    if ([obj isKindOfClass:[ArrayIterator class]]) {
        ArrayIterator *it = (ArrayIterator *)obj;
        [tr appendString:@" ["];
        while ([it hasNext]) {
            id iterValue = [it nextObject];
            [self printForTrace:tr obj:iterValue];
        }
        
        [tr appendString:@" ]"];
    }
    else {
        [tr appendFormat:@" %@", obj];
    }
}

- (AMutableArray *) getEvents
{
    return events;
}

- (AMutableArray *) getEvents:(ST *)st
{
    if ([debugInfo objectForKey:st] == nil) {
        [debugInfo setObject:st forKey:[AMutableArray arrayWithCapacity:5]];
    }
    return [debugInfo objectForKey:st];
}

/** For every event, we track in overall list and in self's
 *  event list so that each template has a list of events used to
 *  create it.  If EvalTemplateEvent, store in parent's
 *  childEvalTemplateEvents list for STViz tree view.
 */
- (void) trackDebugEvent:(ST *)aWho event:(InterpEvent *)e
{
//  System.out.println(e);
    [self.events addObject:e];
    [currentScope.events addObject:e];
    if ( [e isKindOfClass:[EvalTemplateEvent class]] ) {
        InstanceScope *parent = currentScope.parent;
        if ( parent != nil ) {
            // System.out.println("add eval "+e.self.getName()+" to children of "+parent.getName());
            [currentScope.parent.childEvalTemplateEvents addObject:(EvalTemplateEvent *)e];
        }
    }
}

- (AMutableArray *) getExecutionTrace
{
    return executeTrace;
}


+ (NSInteger) getShort:(char *)memory index:(NSInteger)index
{
    NSInteger b1 = memory[index] & 0xFF;
    NSInteger b2 = memory[index + 1] & 0xFF;
    return b1 << (8 * 1) | b2;
}

- (void) dealloc
{
    //[operands release];
    [group release];
    [locale release];
    [errMgr release];
    [events release];
    [executeTrace release];
    [debugInfo release];
    [super dealloc];
}

@end
