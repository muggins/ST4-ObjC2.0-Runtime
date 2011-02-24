
#import "Interpreter.h"
#import "ST.h"
#import "STGroup.h"
#import "ErrorManager.h"
#import "ErrorType.h"
#import "STParser.h"

@interface Compiler_Anon1 : NSMutableDictionary {
}

- (id) init;
@end

@interface Compiler_Anon2 : NSMutableDictionary {
}

- (id) init;
@end

@interface Compiler_Anon3 : NSMutableDictionary {
}

- (id) init;
@end

@interface Compiler : NSObject {

  /**
   * The compiler needs to know how to delimit expressions.
   * The STGroup normally passes in this information, but we
   * can set some defaults.
 */
  unichar delimiterStartChar;
  unichar delimiterStopChar;
  ErrorManager *errMgr;
}

@property(getter=getDelimiterStartChar, setter=setDelimiterStartChar:) unichar delimiterStartChar;
@property(getter=getDelimiterStopChar, setter=setDelimiterStopChar:) unichar delimiterStopChar;
@property(retain, getter=getErrMgr, setter=setErrMgr:) ErrorManager *errMgr;
//@property(nonatomic, retain, readonly) NSString * newSubtemplateName;

+ (void) initialize;
+ (NSString *) SUBTEMPLATE_PREFIX;
+ (NSString *) getNewSubtemplateName;
+ (NSInteger) supportedOptions;
+ (NSMutableDictionary *) getSupportedOptions;
+ (NSInteger) NUM_OPTIONS;
+ (NSMutableDictionary *) defaultOptionValues;
+ (NSMutableDictionary *) funcs;
+ (NSInteger) subtemplateCount;
+ (CompiledST *) defineBlankRegion:(CompiledST *)outermostImpl name:(NSString *)name;

+ (Compiler *) newCompiler;
+ (Compiler *) newCompilerWithErrorManager:(ErrorManager *)anErrMgr;
+ (Compiler *) newCompiler:(unichar)aStartChar delimiterStopChar:(unichar)aStopChar;
+ (Compiler *) newCompilerWithErrorManager:(ErrorManager *)anErrMgr delimiterStartChar:(unichar)aStartChar delimiterStopChar:(unichar)aStopChar;

- (id) init;
- (id) initWithErrorManager:(ErrorManager *)anErrMgr;
- (id) init:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
- (id) initWithErrorManager:(ErrorManager *)anErrMgr delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
- (CompiledST *) compile:(NSString *)template;
- (CompiledST *) compile:(NSString *)name template:(NSString *)template;
- (CompiledST *) compile:(NSString *)srcName name:(NSString *)name args:(NSMutableArray *)args template:(NSString *)template templateToken:(ANTLRCommonToken *)templateToken;
- (void) reportMessageAndThrowSTException:(ANTLRCommonTokenStream *)tokens templateToken:(ANTLRCommonToken *)templateToken aParser:(ANTLRParser *)aParser re:(ANTLRRecognitionException *)re;
@end
