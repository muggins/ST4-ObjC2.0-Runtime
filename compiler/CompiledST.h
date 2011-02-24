#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "ST.h"
#import "STGroup.h"
#import "MemBuffer.h"
#import "FormalArgument.h"
#import "Compiler.h"
#import "Interval.h"

/**
 * The result of compiling an ST.  Contains all the bytecode instructions,
 * string table, bytecode address to source code map, and other bookkeeping
 * info.  It's the implementation of an ST you might say.  All instances
 * of the same template share a single implementation (impl field).
 */

@interface CompiledST : NSObject {
  NSString *name;

  /**
   * The original, immutable pattern (not really used again after
   * initial "compilation"). Useful for debugging.  Even for
   * subtemplates, this is entire overall template.
 */
  NSString *template;

  /**
   * Overall token stream for template (debug only)
 */
  ANTLRCommonTokenStream *tokens;

  /**
   * How do we interpret syntax of template? (debug only)
 */
  ANTLRCommonTree *ast;

  /**
   * Must be non null map if !noFormalArgs
 */
  NSMutableDictionary *formalArguments;
  BOOL hasFormalArgs;

  /**
   * A list of all regions and subtemplates
 */
  NSMutableArray *implicitlyDefinedTemplates;

  /**
   * The group that physically defines this ST definition.  We use it to initiate
   * interpretation via ST.toString().  From there, it becomes field 'group'
   * in interpreter and is fixed until rendering completes.
 */
  STGroup *nativeGroup;

  /**
   * Does this template come from a <@region>...<@end> embedded in
   * another template?
 */
  BOOL isRegion;

  /**
   * If someone refs <@r()> in template t, an implicit
   * 
   * @t.r() ::= ""
   * 
   * is defined, but you can overwrite this def by defining your
   * own.  We need to prevent more than one manual def though.  Between
   * this var and isEmbeddedRegion we can determine these cases.
 */
  RegionTypeEnum regionDefType;
  BOOL isAnonSubtemplate;
  NSMutableArray *strings;
  MemBuffer *instrs;
  NSInteger codeSize;
  NSMutableArray *sourceMap;
}

@property (retain, getter=getName, setter=setName:) NSString *name;
@property (retain, getter=getTemplate, setter=setTemplate:) NSString *template;
@property (retain, getter=getTokens, setter=setTokens:) ANTLRCommonTokenStream *tokens;
@property (retain, getter=getAst, setter=setAst:) ANTLRCommonTree *ast;
@property (retain, getter=getFormalArguments, setter=setFormalArguments:) NSMutableDictionary *formalArguments;
@property (assign, getter=getHasFormalArgs, setter=setHasFormalArgs:) BOOL hasFormalArgs;
@property (retain, getter=getImplicitlyDefinedTemplates, setter=setImplicitlyDefinedTemplates:) NSMutableArray *implicitlyDefinedTemplates;
@property (retain, getter=getNativeGroup, setter=setNativeGroup:) STGroup *nativeGroup;
@property (assign, getter=getIsRegion, setter=setIsRegion:) BOOL isRegion;
//@property(nonatomic, readonly) NSInteger numberOfArgsWithDefaultValues;
//@property(nonatomic, retain, readonly) NSString *templateSource;
//@property(nonatomic, retain, readonly) Interval *templateRange;
@property (assign, getter=getRegionDefType, setter=setRegionDefType:) RegionTypeEnum regionDefType;
@property (assign, getter=getIsAnonSubtemplate, setter=setIsAnonSubtemplate:) BOOL isAnonSubtemplate;
@property (retain, getter=getStrings, setter=setStrings:) NSMutableArray *strings;
@property (retain, getter=getInstrs, setter=setInstrs:) MemBuffer *instrs;
@property (assign, getter=getCodeSize, setter=setCodeSize:) NSInteger codeSize;
@property (retain, getter=getSourceMap, setter=setSourceMap:) NSMutableArray *sourceMap;

+ (id) newCompiledST;
- (id) init;
- (void) addImplicitlyDefinedTemplate:(CompiledST *)sub;
- (void) defineArgDefaultValueTemplates:(STGroup *)group;
- (void) defineFormalArgs:(NSMutableArray *)args;
- (void) addArg:(FormalArgument *)a;
- (void) defineImplicitlyDefinedTemplates:(STGroup *)group;
- (NSString *) templateSource;
- (Interval *) templateRange;
- (MemBuffer *) instrs;
- (void) dump;
- (NSString *) disasm;

// getters and setters
- (NSString *) getName;
- (void) setName:(NSString *)name;
- (NSString *) getTemplate;
- (void) setTemplate:(NSString *)template;
- (ANTLRCommonTokenStream *) getTokens;
- (void) setTokens:(ANTLRCommonTokenStream *)tokens;
- (ANTLRCommonTree *) getAst;
- (void) setAst:(ANTLRCommonTree *)ast;
- (NSMutableDictionary *) getFormalArguments;
- (void) setFormalArguments:(NSMutableDictionary *)formalArguments;
- (BOOL) getHasFormalArgs;
- (void) setHasFormalArgs:(BOOL)hasFormalArgs;
- (NSMutableArray *) getImplicitlyDefinedTemplates;
- (void) setImplicitlyDefinedTemplates:(NSMutableArray *)implicitlyDefinedTemplates;
- (STGroup *) getNativeGroup;
- (void) setNativeGroup:(STGroup *)nativeGroup;
- (BOOL) getIsRegion;
- (void) setIsRegion:(BOOL)isRegion;
- (NSInteger) getNumberOfArgsWithDefaultValues;
//@property(nonatomic, readonly(NSInteger numberOfArgsWithDefaultValues;
//@property(nonatomic, retain, readonly(NSString *templateSource;
//@property(nonatomic, retain, readonly(Interval *templateRange;
- (RegionTypeEnum) getRegionDefType;
- (void) setRegionDefType:(RegionTypeEnum)regionDefType;
- (BOOL) getIsAnonSubtemplate;
- (void) setIsAnonSubtemplate:(BOOL)isAnonSubtemplate;
- (NSMutableArray *) getStrings;
- (void) setStrings:(NSMutableArray *)strings;
- (MemBuffer *) getInstrs;
- (void) setInstrs:(MemBuffer *)instrs;
- (NSInteger) getCodeSize;
- (void) setCodeSize:(NSInteger)codeSize;
- (NSMutableArray *) getSourceMap;
- (void) setSourceMap:(NSMutableArray *)sourceMap;
@end
