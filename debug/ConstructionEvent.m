#import "ConstructionEvent.h"

@implementation StackTraceElement

@synthesize msg;

- (id) newStackTraceElement:(NSString *)aMsg
{
    return [[StackTraceElement alloc] initWithMessage:(NSString *)aMsg];
}

- (id) initWithMessage:(NSString *)aMsg
{
    if (self = [super init]) {
        msg = aMsg;
    }
    return self;
}

- (NSString *) description
{
    return msg;
}

@end

@implementation ConstructionEvent

@synthesize fileName;
@synthesize line;
@synthesize stack;
@synthesize sTEntryPoint;

- (id) init {
    if (self = [super init]) {
        stack = [[NSException alloc] init];
    }
    return self;
}

- (NSString *) fileName {
    return [[self sTEntryPoint] fileName];
}

- (NSInteger) line {
    return [[self sTEntryPoint] lineNumber];
}

- (StackTraceElement *) sTEntryPoint {
    NSArray *addrs = [stack callStackReturnAddresses];
    NSArray *trace = [stack callStackSymbols];
    
    for (StackTraceElement * e in trace) {
        NSString * name = [e description];
        // TODO: remove special after testing
        if ([name hasPrefix:@"main("] > 0)
            return e;
        if (![name hasPrefix:@"org.stringtemplate"])
            return e;
    }
    
    return trace;
}

- (void) dealloc {
    [stack release];
    [super dealloc];
}

@end
