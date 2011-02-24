#import "STCompiletimeMessage.h"

@implementation STCompiletimeMessage

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t {
    if (self = [super init:anError who:nil cause:nil]) {
        templateToken = aTemplateToken;
        token = t;
        srcName = aSrcName;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t cause:(NSException *)aCause {
    if (self = [super init:anError who:nil cause:aCause]) {
        templateToken = aTemplateToken;
        token = t;
        srcName = aSrcName;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t cause:(NSException *)aCause arg:(id)anArg {
    if (self = [super init:anError who:nil cause:aCause arg:anArg]) {
        templateToken = aTemplateToken;
        token = t;
        srcName = aSrcName;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t cause:(NSException *)aCause arg:(id)anArg arg2:(id)anArg2 {
    if (self = [super init:anError who:nil cause:aCause arg:anArg arg2:anArg2]) {
        templateToken = aTemplateToken;
        token = t;
        srcName = aSrcName;
    }
    return self;
}

- (NSString *) description
{
    ANTLRRecognitionException * re = (ANTLRRecognitionException *)cause;
    NSInteger line = 0;
    NSInteger charPos = -1;
    if (token != nil) {
        line = [token getLine];
        charPos = [token getCharPositionInLine];
        if (templateToken != nil) {
            NSInteger templateDelimiterSize = 1;
            if ([templateToken getType] == BIGSTRING) {
                templateDelimiterSize = 2;
            }
            line += [templateToken getLine] - 1;
            charPos += [templateToken getCharPositionInLine] + templateDelimiterSize;
        }
    }
    NSString *filepos = [NSString stringWithFormat:@"%d:%d", line, charPos];
    if (srcName != nil) {
        return [srcName stringByAppendingFormat:@" %@:%@", filepos, [NSString stringWithFormat:[ErrorType ErrorNum:error], arg, arg2]];
    }
    return [NSString stringWithFormat:@"%@: %@", filepos, [NSString stringWithFormat:[ErrorType ErrorNum:error], arg, arg2]];
}
                  
                  - (void) dealloc {
                      [templateToken release];
                      [token release];
                      [srcName release];
                      [super dealloc];
                  }
                  
                  @end
