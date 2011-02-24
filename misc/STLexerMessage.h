#import <ANTLR/ANTLR.h>
//#import "Token.h"
#import "GroupParser.h"

/**
 * 
 */

@interface STLexerMessage : STMessage {
  NSString *msg;
  ANTLRCommonToken *templateToken;
  NSString *srcName;
}

@property (retain, getter=getMsg, setter=setMsg:) NSString *msg;
@property (retain, getter=getTemplateToken, setter=setTemplateToken:) ANTLRCommonToken *templateToken;
@property (retain, getter=getSrcName, setter=setSrcName:) NSString *srcName;

+ (id) newSTLexerMessage:(NSString *)aSrcName msg:(NSString *)aMsg templateToken:(ANTLRCommonToken *)aTemplateToken cause:(NSException *)aCause;

- (id) init:(NSString *)aSrcName msg:(NSString *)aMsg templateToken:(ANTLRCommonToken *)aTemplateToken cause:(NSException *)aCause;

- (NSString *) description;
@end
