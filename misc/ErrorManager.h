#import <ANTLR/ANTLR.h>

//#import "RecognitionException.h"
//#import "Token.h"
#import "ST.h"
#import "ErrorType.h"
#import "STErrorListener.h"
#import "STLexerMessage.h"
#import "STRuntimeMessage.h"
#import "STGroupCompiletimeMessage.h"
#import "STCompiletimeMessage.h"

@interface ErrorManager_Anon1 : NSObject <STErrorListener> {
}

+ (id) newErrorManager_Anon1;
- (id) init;

- (void) compileTimeError:(STMessage *)msg;
- (void) runTimeError:(STMessage *)msg;
- (void) IOError:(STMessage *)msg;
- (void) internalError:(STMessage *)msg;
- (void) error:(NSString *)s;
- (void) error:(NSString *)s e:(NSException *)e;
@end

/**
 * Track errors per thread; e.g., one server transaction's errors
 * will go in one grouping since each has it's own thread.
 */

@interface ErrorManager : NSObject {
  STErrorListener *listener;
}

+ (void) initialize;
+ (STErrorListener *) DEFAULT_ERROR_LISTENER;

+ (id) newErrorManager;
+ (id) newErrorManagerWithListerner:(STErrorListener *)aListener;

- (id) init;
- (id) initWithListener:(STErrorListener *)listener;
- (void) compileTimeError:(ErrorTypeEnum)error templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t;
- (void) compileTimeError:(ErrorTypeEnum)error templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t arg:(id)arg;
- (void) compileTimeError:(ErrorTypeEnum)error templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t arg:(id)arg arg2:(id)arg2;
- (void) lexerError:(NSString *)srcName msg:(NSString *)msg templateToken:(ANTLRCommonToken *)aTemplateToken e:(ANTLRRecognitionException *)e;
- (void) groupSyntaxError:(ErrorTypeEnum)error srcName:(NSString *)srcName e:(ANTLRRecognitionException *)e msg:(NSString *)msg;
- (void) groupLexerError:(ErrorTypeEnum)error srcName:(NSString *)srcName e:(ANTLRRecognitionException *)e msg:(NSString *)msg;
- (void) runTimeError:(ST *)who ip:(NSInteger)ip error:(ErrorTypeEnum)error;
- (void) runTimeError:(ST *)who ip:(NSInteger)ip error:(ErrorTypeEnum)error arg:(id)arg;
- (void) runTimeError:(ST *)who ip:(NSInteger)ip error:(ErrorTypeEnum)error e:(NSException *)e arg:(id)arg;
- (void) runTimeError:(ST *)who ip:(NSInteger)ip error:(ErrorTypeEnum)error arg:(id)arg arg2:(id)arg2;
- (void) runTimeError:(ST *)who ip:(NSInteger)ip error:(ErrorTypeEnum)error arg:(id)arg arg2:(id)arg2 arg3:(id)arg3;
- (void) IOError:(ST *)who error:(ErrorTypeEnum)error e:(NSException *)e;
- (void) IOError:(ST *)who error:(ErrorTypeEnum)error e:(NSException *)e arg:(id)arg;
- (void) internalError:(ST *)who msg:(NSString *)msg e:(NSException *)e;
@end
