#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "Interpreter.h"
#import "ErrorManager.h"
// #import "ErrorType.h"
#import "Interpreter.h"
#import "Interval.h"
#import "Bytecode.h"
#import "StringTable.h"
#import "CompiledST.h"

/**
 * temp data used during construction and functions that fill it / use it.
 * Result is impl CompiledST object.
 */

@interface CompilationState : NSObject {

  /**
   * The compiled code implementation to fill in.
 */
  CompiledST *impl;

  /**
   * Track unique strings; copy into CompiledST's String[] after compilation
 */
  StringTable *stringtable;

  /**
   * Track instruction location within code.instrs array; this is
   * next address to write to.  Byte-addressable memory.
 */
  NSInteger ip;
  ANTLRCommonTokenStream *tokens;
  ErrorManager *errMgr;
}

@property (retain, getter=getImpl, setter=setImpl:) CompiledST *impl;
@property (retain, getter=getStringTable, setter=setStringTable:) StringTable *stringtable;
@property (assign, getter=getIp, setter=setIp:) NSInteger ip;
@property (retain, getter=getTokens, setter=setTokens:) ANTLRCommonTokenStream *tokens;
@property (retain, getter=getErrMgr, setter=setErrMgr:) ErrorManager *errMgr;

+ (id) newCompilationState:(ErrorManager *)anErrMgr
                      name:(NSString *)name
                    stream:(ANTLRCommonTokenStream *)tokens;

- (id) init:(ErrorManager *)errMgr
       name:(NSString *)name
     stream:(ANTLRCommonTokenStream *)tokens;
     
- (NSInteger) defineString:(NSString *)s;
- (void) refAttr:(ANTLRCommonToken *)templateToken tree:(ANTLRCommonTree *)id;
- (void) setOption:(ANTLRCommonTree *)id;
- (void) func:(ANTLRCommonToken *)templateToken tree:(ANTLRCommonTree *)id;
- (void) emit:(short)opcode;
- (void) emit:(ANTLRCommonTree *)opAST opcode:(short)opcode;
- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)opcode arg:(NSInteger)arg;
- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)opcode s:(NSString *)s;
- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)opcode arg:(NSInteger)arg arg2:(NSInteger)arg2;
- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)opcode s:(NSString *)s arg2:(NSInteger)arg2;
- (void) insert:(NSInteger)addr opcode:(short)opcode s:(NSString *)s;
- (void) write:(NSInteger)addr value:(short)value;
- (void) ensureCapacity:(NSInteger)n;
- (void) indent:(NSString *)indent;
+ (void) writeShort:(char *)memory index:(NSInteger)index value:(short)value;
@end
