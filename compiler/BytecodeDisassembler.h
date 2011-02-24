#import "MemBuffer.h"
@class CompiledST;

@interface BytecodeDisassembler : NSObject {
  CompiledST *code;
}

+ (id) newBytecodeDisassembler:(CompiledST *)aCode;
- (id) initWithCode:(CompiledST *)aCode;
- (NSString *) instrs;
- (NSString *) disassemble;
- (NSInteger) disassembleInstruction:(NSMutableString *)buf ip:(NSInteger)ip;
- (NSString *) showConstPoolOperand:(NSInteger)poolIndex;
// + (NSInteger) getShort:(char *)memory index:(NSInteger)index;
- (NSString *) strings;
- (NSString *) sourceMap;
@end
