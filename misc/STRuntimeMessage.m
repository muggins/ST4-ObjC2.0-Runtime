#import "STRuntimeMessage.h"
#import "Interval.h"
#import "Coordinate.h"
#import "Misc.h"
#import "ST.h"
#import "CompiledST.h"

@implementation STRuntimeMessage

@synthesize ip;

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp;
{
    return [[STRuntimeMessage alloc] init:anError ip:anIp];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho;
{
    return [[STRuntimeMessage alloc] init:anError ip:anIp who:aWho];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho arg:(id)anArg;
{
    return [[STRuntimeMessage alloc] init:anError ip:anIp who:aWho arg:anArg];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg;
{
    return [[STRuntimeMessage alloc] init:anError ip:anIp who:aWho cause:e arg:anArg];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2;
{
    return [[STRuntimeMessage alloc] init:anError ip:anIp who:aWho cause:e arg:anArg arg2:anArg2];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2 arg3:(id)anArg3;
{
    return [[STRuntimeMessage alloc] init:anError ip:anIp who:aWho cause:e arg:anArg arg2:anArg2 arg3:anArg3];
}


- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp
{
    if (self = [super init:anError]) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho
{
    if (self = [super init:anError who:aWho]) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho arg:(NSObject *)anArg
{
    if (self = [super init:anError who:aWho cause:nil arg:anArg]) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg
{
    if (self = [super init:anError who:aWho cause:e arg:anArg]) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2
{
    if (self = [super init:anError who:aWho cause:e arg:anArg arg2:anArg2]) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2 arg3:(id)anArg3
{
    if (self = [super init:anError who:aWho cause:e arg:anArg arg2:anArg2 arg3:anArg3]) {
        ip = anIp;
    }
    return self;
}


/**
 * Given an ip (code location), get it's range in source template then
 * return it's template line:col.
 */
- (NSString *) getSourceLocation
{
    if (ip < 0)
        return nil;
    Interval *I = [[((ST *)who).impl getSourceMap] objectAtIndex:ip];
    if (I == nil)
        return nil;
    NSInteger i = I.a;
    Coordinate *loc = [Misc getLineCharPosition:[((ST *)who).impl getTemplate] index:i];
    return [loc description];
}

- (NSString *) description
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    NSString * loc = [self getSourceLocation];
    if (who != nil) {
        [buf appendFormat:@"context [%@]", [who getEnclosingInstanceStackString]];
    }
    if (loc != nil)
        [buf appendFormat:@" %@", loc];
    [buf appendFormat:@" %@", [super description]];
    return [buf description];
}

@end
