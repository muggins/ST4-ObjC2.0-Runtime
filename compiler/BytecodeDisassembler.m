#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "BytecodeDisassembler.h"
#import "Bytecode.h"
#import "Interval.h"
#import "Misc.h"
#import "CompiledST.h"


@implementation BytecodeDisassembler

+ (NSInteger) getShort:(char *)memory index:(NSInteger)index
{
    NSInteger b1 = memory[index] & 0xFF;
    NSInteger b2 = memory[index + 1] & 0xFF;
    NSInteger word = b1 << (8 * 1) | b2;
    return word;
}

+ (id) newBytecodeDisassembler:(CompiledST *)aCode
{
    return [[BytecodeDisassembler alloc] initWithCode:aCode];
}

- (id) initWithCode:(CompiledST *)aCode
{
    if (self = [super init]) {
        code = aCode;
    }
    return self;
}

- (NSString *) instrs
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    NSInteger ip = 0;

    while (ip < code.codeSize) {
        if (ip > 0)
            [buf appendString:@", "];
        NSInteger opcode = (NSInteger) [code.instrs charAtIndex:ip];
        Instruction *I = Bytecode.instructions[opcode];
        [buf appendString:I.name];
        ip++;

        for (NSInteger opnd = 0; opnd < I.nopnds; opnd++) {
            [buf appendString:@" "];
            [buf appendFormat:@"%d", [code.instrs shortAtIndex:ip]];
            ip += Bytecode.OPND_SIZE_IN_BYTES;
        }
    }
    return [buf description];
}

- (NSString *) disassemble
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    NSInteger i = 0;

    while (i < code.codeSize) {
        i = [self disassembleInstruction:buf ip:i];
        [buf appendString:@"\n"];
    }
    return [buf description];
}

- (NSInteger) disassembleInstruction:(NSMutableString *)buf ip:(NSInteger)ip
{
    NSInteger opcode = [code.instrs charAtIndex:ip];
    if (ip >= code.codeSize) {
        @throw [ANTLRRuntimeException newANTLRIllegalArgumentException:[NSString stringWithFormat:@"ip out of range: %d", ip]];
    }
    Instruction *I = Bytecode.instructions[opcode];
    if (I == nil) {
        @throw [ANTLRRuntimeException newANTLRIllegalArgumentException:[NSString stringWithFormat:@"no such instruction %d at address %d", opcode, ip]];
    }
    NSString * instrName = I.name;
    [buf appendFormat:@"%04d:\t%-14@", ip, instrName];
    ip++;
    if (I.nopnds == 0) {
        [buf appendString:@"  "];
        return ip;
    }
    NSMutableArray *operands = [NSMutableArray arrayWithCapacity:16];

    for (NSInteger i = 0; i < I.nopnds; i++) {
        NSInteger opnd = [code.instrs shortAtIndex:ip];
        ip += Bytecode.OPND_SIZE_IN_BYTES;

        switch ([I getType:i]) {
        case T_STRING:
            [operands addObject:[self showConstPoolOperand:opnd]];
            break;
        case T_ADDR:
        case T_INT:
            [operands addObject:[NSString stringWithFormat:@"%d", opnd]];
            break;
        default:
            [operands addObject:[NSString stringWithFormat:@"%d", opnd]];
            break;
        }
    }

    for (NSInteger i = 0; i < [operands count]; i++) {
        NSString * s = [operands objectAtIndex:i];
        if (i > 0)
            [buf appendString:@", "];
        [buf appendString:s];
    }
    return ip;
}

- (NSString *) showConstPoolOperand:(NSInteger)poolIndex
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    [buf appendFormat:@"#%d", poolIndex];
    NSString * s = @"<bad string index>";
    if (poolIndex < [code.strings count]) {
        if ( [code.strings objectAtIndex:poolIndex] == nil)
            s = @"null";
        else {
            s = [[code.strings objectAtIndex:poolIndex] description];
            if ([[code.strings objectAtIndex:poolIndex] isKindOfClass:[NSString class]]) {
                s = [Misc replaceEscapes:s];
                s = [NSString stringWithFormat:@"%@", s];
            }
        }
    }
    [buf appendString:@":"];
    [buf appendString:s];
    return [buf description];
}

- (NSString *) strings
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    NSInteger addr = 0;
    if (code.strings != nil) {

        for (id obj in code.strings) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString * s = (NSString *)obj;
                s = [Misc replaceEscapes:s];
                [buf appendString:[NSString stringWithFormat:@"%04d: \"%@\"\n", addr, s]];
            }
             else {
                [buf appendString:[NSString stringWithFormat:@"%04d: %@\n", addr, obj]];
            }
            addr++;
        }
    }
    return [buf description];
}

- (NSString *) sourceMap
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    NSInteger addr = 0;

    for (Interval * I in code.sourceMap) {
        if (I != nil) {
            NSString * chunk = [code.template substringWithRange:NSMakeRange(I.a, (I.b + 1)-I.a)];
            [buf appendString:[NSString stringWithFormat:@"%04d: %@\t\"%@\"\n", addr, I, chunk]];
        }
        addr++;
    }
    return [buf description];
}

- (void) dealloc
{
    [code release];
    [super dealloc];
}

@end
