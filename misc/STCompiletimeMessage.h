//#import "RecognitionException.h"
//#import "Token.h"
#import "GroupParser.h"

/**
 * Used for semantic errors that occur at compile time not during
 * interpretation. For ST parsing ONLY not group parsing.
 */

@interface STCompiletimeMessage : STMessage {
  ANTLRCommonToken * templateToken;
  ANTLRCommonToken * token;
  NSString * srcName;
}

- (id) init:(ErrorTypeEnum)error srcName:(NSString *)srcName templateToken:(ANTLRCommonToken *)templateToken t:(ANTLRCommonToken *)t;
- (id) init:(ErrorTypeEnum)error srcName:(NSString *)srcName templateToken:(ANTLRCommonToken *)templateToken t:(ANTLRCommonToken *)t cause:(NSException *)aCause;
- (id) init:(ErrorTypeEnum)error srcName:(NSString *)srcName templateToken:(ANTLRCommonToken *)templateToken t:(ANTLRCommonToken *)t cause:(NSException *)aCause arg:(id)arg;
- (id) init:(ErrorTypeEnum)error srcName:(NSString *)srcName templateToken:(ANTLRCommonToken *)templateToken t:(ANTLRCommonToken *)t cause:(NSException *)aCause arg:(id)arg arg2:(id)arg2;
- (NSString *) description;
@end
