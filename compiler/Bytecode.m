#import <Cocoa/Cocoa.h>
#import "Bytecode.h"

OperandType OperandTypeValueOf(NSString *text)
{
    if (text) {
        if ([text isEqualToString:@"NONE"])
            return T_NONE;
        else if ([text isEqualToString:@"STRING"])
            return T_STRING;
        else if ([text isEqualToString:@"ADDR"])
            return T_ADDR;
        else if ([text isEqualToString:@"INT"])
            return T_INT;
    }
    return -1;
}

NSString *OperandTypeDescription(NSInteger value)
{
    switch (value) {
        case T_NONE:
            return @"NONE";
        case T_STRING:
            return @"STRING";
        case T_ADDR:
            return @"ADDR";
        case T_INT:
            return @"INT";
    }
    return nil;
}

@implementation Instruction

@synthesize name;
//@synthesize type;
@synthesize nopnds;

+ (id) newInstruction:(NSString *)aName
{
    return [[Instruction alloc] init:aName];
}

+ (id) newInstruction:(NSString *)aName a:(OperandType)a
{
    return [[Instruction alloc] init:aName a:a];
}

+ (id) newInstruction:(NSString *)aName a:(OperandType)a b:(OperandType)b
{
    return [[Instruction alloc] init:aName a:a b:b];
}

- (id) init:(NSString *)aName
{
    if (self = [self init:aName a:T_NONE b:T_NONE]) {
        nopnds = 0;
    }
    return self;
}

- (id) init:(NSString *)aName a:(OperandType)a
{
    if (self = [self init:aName a:a b:T_NONE]) {
        nopnds = 1;
    }
    return self;
}

- (id) init:(NSString *)aName a:(OperandType)a b:(OperandType)b
{
    if (self = [super init]) {
        name = aName;
        type[0]=a;
        type[1]=b;
        nopnds = MAX_OPNDS;
    }
    return self;
}

- (void) dealloc
{
    [name release];
    [super dealloc];
}

// getters and setters

- (NSString *)getName
{
    return name;
}

- (void)setName:(NSString *)aName
{
    name = aName;
}

- (OperandType)getType:(NSInteger)idx
{
    if (idx >= 0 && idx < MAX_OPNDS)
        return type[idx];
    return -1;
}

- (void)setType:(OperandType)aType idx:(NSInteger)idx
{
    if (idx >= 0 && idx < MAX_OPNDS)
        type[idx] = aType;
    else
        // @throw error here
        return;
}

- (NSInteger)getNopnds
{
    return nopnds;
}

- (void)setNopnds:(NSInteger)cnt
{
    if (cnt >= 0 && cnt < MAX_OPNDS)
        nopnds = cnt;
    else
        // @throw error here
        return;
}

@end

@implementation Bytecode
static NSInteger OPND_SIZE_IN_BYTES = 2;
static short const INSTR_LOAD_STR = 1;
static short const INSTR_LOAD_ATTR = 2;
static short const INSTR_LOAD_LOCAL = 3;
static short const INSTR_LOAD_PROP = 4;
static short const INSTR_LOAD_PROP_IND = 5;
static short const INSTR_STORE_OPTION = 6;
static short const INSTR_STORE_ARG = 7;
static short const INSTR_NEW = 8;
static short const INSTR_NEW_IND = 9;
static short const INSTR_NEW_BOX_ARGS = 10;
static short const INSTR_SUPER_NEW = 11;
static short const INSTR_SUPER_NEW_BOX_ARGS = 12;
static short const INSTR_WRITE = 13;
static short const INSTR_WRITE_OPT = 14;
static short const INSTR_MAP = 15;
static short const INSTR_ROT_MAP = 16;
static short const INSTR_ZIP_MAP = 17;
static short const INSTR_BR = 18;
static short const INSTR_BRF = 19;
static short const INSTR_OPTIONS = 20;
static short const INSTR_ARGS = 21;
static short const INSTR_LIST = 22;
static short const INSTR_ADD = 23;
static short const INSTR_TOSTR = 24;
static short const INSTR_FIRST = 25;
static short const INSTR_LAST = 26;
static short const INSTR_REST = 27;
static short const INSTR_TRUNC = 28;
static short const INSTR_STRIP = 29;
static short const INSTR_TRIM = 30;
static short const INSTR_LENGTH = 31;
static short const INSTR_STRLEN = 32;
static short const INSTR_REVERSE = 33;
static short const INSTR_NOT = 34;
static short const INSTR_OR = 35;
static short const INSTR_AND = 36;
static short const INSTR_INDENT = 37;
static short const INSTR_DEDENT = 38;
static short const INSTR_NEWLINE = 39;
static short const INSTR_NOOP = 40;
static short const INSTR_POP = 41;
static short const INSTR_NULL = 42;
#define INSTR_ARRAY_SIZE 44

/**
 * Used for assembly/disassembly; describes instruction set
 */
static Instruction *instructions[INSTR_ARRAY_SIZE];

+ (void) initialize
{
    instructions[0]                         = [Instruction newInstruction:@"nil"];
    instructions[INSTR_LOAD_STR]            = [Instruction newInstruction:@"load_str" a:T_STRING];
    instructions[INSTR_LOAD_ATTR]           = [Instruction newInstruction:@"load_attr" a:T_STRING];
    instructions[INSTR_LOAD_LOCAL]          = [Instruction newInstruction:@"load_local" a:T_INT],
    instructions[INSTR_LOAD_PROP]           = [Instruction newInstruction:@"load_prop" a:T_STRING];
    instructions[INSTR_LOAD_PROP_IND]       = [Instruction newInstruction:@"load_prop_ind"];
    instructions[INSTR_STORE_OPTION]        = [Instruction newInstruction:@"store_option" a:T_INT];
    instructions[INSTR_STORE_ARG]           = [Instruction newInstruction:@"store_arg" a:T_STRING];
    instructions[INSTR_NEW]                 = [Instruction newInstruction:@"new" a:T_STRING b:T_INT];
    instructions[INSTR_NEW_IND]             = [Instruction newInstruction:@"new_ind" a:T_INT];
    instructions[INSTR_NEW_BOX_ARGS]        = [Instruction newInstruction:@"new_box_args" a:T_STRING];
    instructions[INSTR_SUPER_NEW]           = [Instruction newInstruction:@"super_new" a:T_STRING b:T_INT];
    instructions[INSTR_SUPER_NEW_BOX_ARGS]  = [Instruction newInstruction:@"super_new_box_args" a:T_STRING];
    instructions[INSTR_WRITE]               = [Instruction newInstruction:@"write"];
    instructions[INSTR_WRITE_OPT]           = [Instruction newInstruction:@"write_opt"];
    instructions[INSTR_MAP]                 = [Instruction newInstruction:@"map"];
    instructions[INSTR_ROT_MAP]             = [Instruction newInstruction:@"rot_map" a:T_INT];
    instructions[INSTR_ZIP_MAP]             = [Instruction newInstruction:@"zip_map" a:T_INT];
    instructions[INSTR_BR]                  = [Instruction newInstruction:@"br" a:T_ADDR];
    instructions[INSTR_BRF]                 = [Instruction newInstruction:@"brf" a:T_ADDR];
    instructions[INSTR_OPTIONS]             = [Instruction newInstruction:@"options"];
    instructions[INSTR_ARGS]                = [Instruction newInstruction:@"args"];
    instructions[INSTR_LIST]                = [Instruction newInstruction:@"list"];
    instructions[INSTR_ADD]                 = [Instruction newInstruction:@"add"];
    instructions[INSTR_TOSTR]               = [Instruction newInstruction:@"tostr"];
    instructions[INSTR_FIRST]               = [Instruction newInstruction:@"first"];
    instructions[INSTR_LAST]                = [Instruction newInstruction:@"last"];
    instructions[INSTR_REST]                = [Instruction newInstruction:@"rest"];
    instructions[INSTR_TRUNC]               = [Instruction newInstruction:@"trunc"];
    instructions[INSTR_STRIP]               = [Instruction newInstruction:@"strip"];
    instructions[INSTR_TRIM]                = [Instruction newInstruction:@"trim"];
    instructions[INSTR_LENGTH]              = [Instruction newInstruction:@"length"];
    instructions[INSTR_STRLEN]              = [Instruction newInstruction:@"strlen"];
    instructions[INSTR_REVERSE]             = [Instruction newInstruction:@"reverse"];
    instructions[INSTR_NOT]                 = [Instruction newInstruction:@"not"];
    instructions[INSTR_OR]                  = [Instruction newInstruction:@"or"];
    instructions[INSTR_AND]                 = [Instruction newInstruction:@"and"];
    instructions[INSTR_INDENT]              = [Instruction newInstruction:@"indent" a:T_STRING];
    instructions[INSTR_DEDENT]              = [Instruction newInstruction:@"dedent"];
    instructions[INSTR_NEWLINE]             = [Instruction newInstruction:@"newline"];
    instructions[INSTR_NOOP]                = [Instruction newInstruction:@"noop"];
    instructions[INSTR_POP]                 = [Instruction newInstruction:@"pop"];
    instructions[INSTR_NULL]                = [Instruction newInstruction:@"null"];
    instructions[INSTR_ARRAY_SIZE-1]        = nil;
    
}

+ (short) INSTR_LOAD_STR
{
    return INSTR_LOAD_STR;
}

+ (short) INSTR_LOAD_ATTR
{
    return INSTR_LOAD_ATTR;
}

+ (short) INSTR_LOAD_LOCAL
{
    return INSTR_LOAD_LOCAL;
}

+ (short) INSTR_LOAD_PROP
{
    return INSTR_LOAD_PROP;
}

+ (short) INSTR_LOAD_PROP_IND
{
    return INSTR_LOAD_PROP_IND;
}

+ (short) INSTR_STORE_OPTION
{
    return INSTR_STORE_OPTION;
}

+ (short) INSTR_STORE_ARG
{
    return INSTR_STORE_ARG;
}

+ (short) INSTR_NEW
{
    return INSTR_NEW;
}

+ (short) INSTR_NEW_IND
{
    return INSTR_NEW_IND;
}

+ (short) INSTR_NEW_BOX_ARGS
{
    return INSTR_NEW_BOX_ARGS;
}

+ (short) INSTR_SUPER_NEW
{
    return INSTR_SUPER_NEW;
}

+ (short) INSTR_SUPER_NEW_BOX_ARGS
{
    return INSTR_SUPER_NEW_BOX_ARGS;
}

+ (short) INSTR_WRITE
{
    return INSTR_WRITE;
}

+ (short) INSTR_WRITE_OPT
{
    return INSTR_WRITE_OPT;
}

+ (short) INSTR_MAP
{
    return INSTR_MAP;
}

+ (short) INSTR_ROT_MAP
{
    return INSTR_ROT_MAP;
}

+ (short) INSTR_ZIP_MAP
{
    return INSTR_ZIP_MAP;
}

+ (short) INSTR_BR
{
    return INSTR_BR;
}

+ (short) INSTR_BRF
{
    return INSTR_BRF;
}

+ (short) INSTR_OPTIONS
{
    return INSTR_OPTIONS;
}

+ (short) INSTR_ARGS
{
    return INSTR_ARGS;
}

+ (short) INSTR_LIST
{
    return INSTR_LIST;
}

+ (short) INSTR_ADD
{
    return INSTR_ADD;
}

+ (short) INSTR_TOSTR
{
    return INSTR_TOSTR;
}

+ (short) INSTR_FIRST
{
    return INSTR_FIRST;
}

+ (short) INSTR_LAST
{
    return INSTR_LAST;
}

+ (short) INSTR_REST
{
    return INSTR_REST;
}

+ (short) INSTR_TRUNC
{
    return INSTR_TRUNC;
}

+ (short) INSTR_STRIP
{
    return INSTR_STRIP;
}

+ (short) INSTR_TRIM
{
    return INSTR_TRIM;
}

+ (short) INSTR_LENGTH
{
    return INSTR_LENGTH;
}

+ (short) INSTR_STRLEN
{
    return INSTR_STRLEN;
}

+ (short) INSTR_REVERSE
{
    return INSTR_REVERSE;
}

+ (short) INSTR_NOT
{
    return INSTR_NOT;
}

+ (short) INSTR_OR
{
    return INSTR_OR;
}

+ (short) INSTR_AND
{
    return INSTR_AND;
}

+ (short) INSTR_INDENT
{
    return INSTR_INDENT;
}

+ (short) INSTR_DEDENT
{
    return INSTR_DEDENT;
}

+ (short) INSTR_NEWLINE
{
    return INSTR_NEWLINE;
}

+ (short) INSTR_NOOP
{
    return INSTR_NOOP;
}

+ (short) INSTR_POP
{
    return INSTR_POP;
}

+ (short) INSTR_NULL
{
    return INSTR_NULL;
}

+ (NSInteger)OPND_SIZE_IN_BYTES
{
    return OPND_SIZE_IN_BYTES;
}

+ (Instruction **)instructions
{
    return instructions;
}


@end
