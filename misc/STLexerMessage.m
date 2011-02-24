#import "STLexerMessage.h"

@implementation STLexerMessage

@synthesize msg;
@synthesize templateToken;
@synthesize srcName;

+ (id) newSTLexerMessage:(NSString *)aSrcName msg:(NSString *)aMsg templateToken:(ANTLRCommonToken *)aTemplateToken cause:(NSException *)aCause
{
    return [[STLexerMessage alloc] init:(NSString *)aSrcName msg:(NSString *)aMsg templateToken:(ANTLRCommonToken *)aTemplateToken cause:(NSException *)aCause];
}

- (id) init:(NSString *)aSrcName msg:(NSString *)aMsg templateToken:(ANTLRCommonToken *)aTemplateToken cause:(NSException *)aCause
{
    if (self = [super init:LEXER_ERROR who:nil cause:aCause arg:nil]) {
        msg = aMsg;
        if (msg == nil) msg = @"nil";
        templateToken = aTemplateToken;
        srcName = aSrcName;
    }
    return self;
}

- (NSString *) description
{
    ANTLRRecognitionException *re = (ANTLRRecognitionException *)cause;
    NSInteger line = re.line;
    NSInteger charPos = re.charPositionInLine;
    if (templateToken != nil) {
        NSInteger templateDelimiterSize = 1;
        if ([templateToken getType] == BIGSTRING) {
            templateDelimiterSize = 2;
        }
        line += [templateToken getLine] - 1;
        charPos += [templateToken getCharPositionInLine] + templateDelimiterSize;
    }
    NSString *filepos = [NSString stringWithFormat:@"%d:%d", line, charPos];
    if (srcName != nil) {
        return [srcName stringByAppendingFormat:@" %d:%@", filepos, [NSString stringWithFormat:[ErrorType ErrorNum:error], msg]];
    }
    return [filepos stringByAppendingFormat:@": %@", [NSString stringWithFormat:[ErrorType ErrorNum:error], msg]];
}

- (void) dealloc
{
    [msg release];
    [templateToken release];
    [srcName release];
    [super dealloc];
}

@end
