#import "EvalTemplateEvent.h"

@implementation EvalTemplateEvent

+ (id) newEvalTemplateEventWithWho:(DebugST *)aWho start:(NSInteger)aStartIdx stop:(NSInteger)aStopIdx
{
    return [[EvalTemplateEvent alloc] initWithWho:aWho start:aStartIdx stop:aStopIdx];
}

- (id) initWithWho:(DebugST *)aWho start:(NSInteger)aStartIdx stop:(NSInteger)aStopIdx {
    if (self = [super initWithWho:aWho start:aStartIdx stop:aStopIdx]) {
    }
    return self;
}

@end
