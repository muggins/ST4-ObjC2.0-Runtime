#import "STGroupCompiletimeMessage.h"

@implementation STGroupCompiletimeMessage

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName t:(ANTLRCommonToken *)t cause:(NSException *)aCause {
    if (self = [super init:anError who:nil cause:aCause arg:nil]) {
        token = t;
        srcName = srcName;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName t:(ANTLRCommonToken *)t cause:(NSException *)aCause arg:(id)anArg {
    if (self = [super init:anError who:nil cause:aCause arg:anArg arg2:nil]) {
        token = t;
        srcName = srcName;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName t:(ANTLRCommonToken *)t cause:(NSException *)aCause arg:(id)anArg arg2:(id)anArg2 {
    if (self = [super init:anError who:nil cause:aCause arg:anArg arg2:anArg2]) {
        token = t;
        srcName = srcName;
    }
    return self;
}

- (NSString *) description {
    ANTLRRecognitionException *re = (ANTLRRecognitionException *)cause;
    NSInteger line = 0;
    NSInteger charPos = -1;
    if (token != nil) {
        line = [token getLine];
        charPos = [token getCharPositionInLine];
    }
    else if (re != nil) {
        line = re.line;
        charPos = re.charPositionInLine;
    }
    NSString *filepos = [NSString stringWithFormat:@"%d:%d", line, charPos];
    if (srcName != nil) {
        return [NSString stringWithFormat:@"%@ %@: %@", srcName, filepos, [NSString stringWithFormat:[ErrorType ErrorNum:error], arg, arg2]];
    }
    return [NSString stringWithFormat:@"%d: %@",filepos , [NSString stringWithFormat:[ErrorType ErrorNum:error], arg, arg2]];
}

- (void) dealloc {
    [token release];
    [srcName release];
    [super dealloc];
}

@end
