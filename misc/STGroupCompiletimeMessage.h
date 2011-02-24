//#import "ANTLRRecognitionException.h"
//#import "Token.h"
#import <ANTLR/ANTLR.h>
#import "STMessage.h"
#import "ErrorType.h"
/**
 * 
 */

@interface STGroupCompiletimeMessage : STMessage {
  ANTLRCommonToken *token;
  NSString * srcName;
}

- (id) init:(ErrorTypeEnum)error srcName:(NSString *)srcName t:(ANTLRCommonToken *)t cause:(NSException *)aCause;
- (id) init:(ErrorTypeEnum)error srcName:(NSString *)srcName t:(ANTLRCommonToken *)t cause:(NSException *)aCause arg:(id)arg;
- (id) init:(ErrorTypeEnum)error srcName:(NSString *)srcName t:(ANTLRCommonToken *)t cause:(NSException *)aCause arg:(id)arg arg2:(id)arg2;
- (NSString *) description;
@end
