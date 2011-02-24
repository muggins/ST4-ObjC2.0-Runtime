
#define MAX_OPNDS 2
#ifdef DONTUSENOMO
extern static short const INSTR_LOAD_STR;
extern static short const INSTR_LOAD_ATTR;
extern static short const INSTR_LOAD_LOCAL;
extern static short const INSTR_LOAD_PROP;
extern static short const INSTR_LOAD_PROP_IND;
extern static short const INSTR_STORE_OPTION;
extern static short const INSTR_STORE_ARG;
extern static short const INSTR_NEW;
extern static short const INSTR_NEW_IND;
extern static short const INSTR_NEW_BOX_ARGS;
extern static short const INSTR_SUPER_NEW;
extern static short const INSTR_SUPER_NEW_BOX_ARGS;
extern static short const INSTR_WRITE;
extern static short const INSTR_WRITE_OPT;
extern static short const INSTR_MAP;
extern static short const INSTR_ROT_MAP;
extern static short const INSTR_ZIP_MAP;
extern static short const INSTR_BR;
extern static short const INSTR_BRF;
extern static short const INSTR_OPTIONS;
extern static short const INSTR_ARGS;
extern static short const INSTR_LIST;
extern static short const INSTR_ADD;
extern static short const INSTR_TOSTR;
extern static short const INSTR_FIRST;
extern static short const INSTR_LAST;
extern static short const INSTR_REST;
extern static short const INSTR_TRUNC;
extern static short const INSTR_STRIP;
extern static short const INSTR_TRIM;
extern static short const INSTR_LENGTH;
extern static short const INSTR_STRLEN;
extern static short const INSTR_REVERSE;
extern static short const INSTR_NOT;
extern static short const INSTR_OR;
extern static short const INSTR_AND;
extern static short const INSTR_INDENT;
extern static short const INSTR_DEDENT;
extern static short const INSTR_NEWLINE;
extern static short const INSTR_NOOP;
extern static short const INSTR_POP;
extern static short const INSTR_NULL;
#endif

typedef enum {
    T_NONE,
    T_STRING,
    T_ADDR,
    T_INT
} OperandType;

OperandType OperandTypeValueOf(NSString *text);
NSString *OperandTypeDescription(NSInteger value);

@interface Instruction : NSObject {
    NSString *name;
    NSInteger type[MAX_OPNDS];
    NSInteger nopnds;
}

@property (retain, getter=getName, setter=setName:) NSString *name;
//@property (retain, getter=getType:(NSInteger), setter=setType:(OperandType) idx:(NSInteger)) NSInteger type[MAX_OPNDS];
@property (assign, getter=getNopnds, setter=setNopnds:) NSInteger nopnds;

+ (id) newInstruction:(NSString *)aName;
+ (id) newInstruction:(NSString *)aName a:(OperandType)a;
+ (id) newInstruction:(NSString *)aName a:(OperandType)a b:(OperandType)b;

- (id) init:(NSString *)aName;
- (id) init:(NSString *)aName a:(OperandType)a;
- (id) init:(NSString *)aName a:(OperandType)a b:(OperandType)b;

- (NSString *)getName;
- (void)setName:(NSString *)aName;
- (OperandType)getType:(NSInteger)idx;
- (void)setType:(OperandType)aType idx:(NSInteger)idx;
- (NSInteger)getNopnds;
- (void)setNopnds:(NSInteger)cnt;

@end

/**
 * Used for assembly/disassembly; describes instruction set
 */
@interface Bytecode : NSObject {
}

+ (NSInteger)OPND_SIZE_IN_BYTES;
+ (Instruction **)instructions;
+ (void) initialize;
+ (short) INSTR_LOAD_STR;
+ (short) INSTR_LOAD_ATTR;
+ (short) INSTR_LOAD_LOCAL;
+ (short) INSTR_LOAD_PROP;
+ (short) INSTR_LOAD_PROP_IND;
+ (short) INSTR_STORE_OPTION;
+ (short) INSTR_STORE_ARG;
+ (short) INSTR_NEW;
+ (short) INSTR_NEW_IND;
+ (short) INSTR_NEW_BOX_ARGS;
+ (short) INSTR_SUPER_NEW;
+ (short) INSTR_SUPER_NEW_BOX_ARGS;
+ (short) INSTR_WRITE;
+ (short) INSTR_WRITE_OPT;
+ (short) INSTR_MAP;
+ (short) INSTR_ROT_MAP;
+ (short) INSTR_ZIP_MAP;
+ (short) INSTR_BR;
+ (short) INSTR_BRF;
+ (short) INSTR_OPTIONS;
+ (short) INSTR_ARGS;
+ (short) INSTR_LIST;
+ (short) INSTR_ADD;
+ (short) INSTR_TOSTR;
+ (short) INSTR_FIRST;
+ (short) INSTR_LAST;
+ (short) INSTR_REST;
+ (short) INSTR_TRUNC;
+ (short) INSTR_STRIP;
+ (short) INSTR_TRIM;
+ (short) INSTR_LENGTH;
+ (short) INSTR_STRLEN;
+ (short) INSTR_REVERSE;
+ (short) INSTR_NOT;
+ (short) INSTR_OR;
+ (short) INSTR_AND;
+ (short) INSTR_INDENT;
+ (short) INSTR_DEDENT;
+ (short) INSTR_NEWLINE;
+ (short) INSTR_NOOP;
+ (short) INSTR_POP;
+ (short) INSTR_NULL;

+ (Instruction **)instructions;


@end
