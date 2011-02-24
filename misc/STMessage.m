#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "STMessage.h"

@implementation STMessage

+ (id) newMessage:(ErrorTypeEnum)anError
{
    return [[STMessage alloc] init:anError];
}

+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho;
{
    return [[STMessage alloc] init:anError who:aWho];
}

+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause;
{
    return [[STMessage alloc] init:anError who:aWho cause:aCause];
}

+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg;
{
    return [[STMessage alloc] init:anError who:aWho cause:aCause arg:arg];
}

+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause where:(ANTLRCommonToken *)where  arg:(id)arg;
{
    return [[STMessage alloc] init:anError who:aWho cause:aCause arg:arg];
}

+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg arg2:(id)arg2;
{
    return [[STMessage alloc] init:anError who:aWho cause:aCause arg:arg arg2:arg2];
}

+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg arg2:(id)arg2 arg3:(id)arg3
{
    return [[STMessage alloc] init:anError who:aWho cause:aCause arg:arg arg2:arg2 arg3:arg3];
}

- (id) init:(ErrorTypeEnum)anError
{
    if (self = [super init]) {
        error = anError;
        who = nil;
        cause = nil;
        arg = nil;
        arg2 = nil;
        arg3 = nil;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho
{
    if (self = [super init]) {
        error = anError;
        who = aWho;
        cause = nil;
        arg = nil;
        arg2 = nil;
        arg3 = nil;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause
{
    if (self = [super init]) {
        error = anError;
        who = aWho;
        cause = aCause;
        arg = nil;
        arg2 = nil;
        arg3 = nil;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)anArg
{
    if (self = [super init]) {
        error = anError;
        who = aWho;
        cause = aCause;
        arg = anArg;
        arg2 = nil;
        arg3 = nil;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause where:(ANTLRCommonToken *)where arg:(id)anArg
{
    if (self = [super init]) {
        error = anError;
        who = aWho;
        cause = aCause;
        arg = anArg;
        arg2 = nil;
        arg3 = nil;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)anArg arg2:(id)anArg2
{
    if (self = [super init]) {
        error = anError;
        who = aWho;
        cause = aCause;
        arg = anArg;
        arg2 = anArg2;
        arg3 = nil;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)anArg arg2:(id)anArg2 arg3:(id)anArg3
{
    if (self = [super init]) {
        error = anError;
        who = aWho;
        cause = aCause;
        arg = anArg;
        arg2 = anArg2;
        arg3 = anArg3;
    }
    return self;
}

- (NSString *) description {
    StringWriter *sw = [StringWriter stringWithCapacity:16];
    PrintWriter *pw = [[PrintWriter alloc] initWithCapacity:16];
    NSMutableString *msg = [NSMutableString stringWithFormat:@"%@%@%@%@", [ErrorType ErrorNum:error], arg, arg2, arg3];
    [pw print:msg];
    if (cause != nil) {
        [pw print:@"\nCaused by: "];
        [cause printStackTrace:pw];
    }
    return [sw description];
}

- (void) dealloc {
    [self release];
    if (arg != nil) [arg release];
    if (arg2 != nil) [arg2 release];
    if (arg3 != nil) [arg3 release];
    if (cause != nil) [cause release];
    [super dealloc];
}

@end
