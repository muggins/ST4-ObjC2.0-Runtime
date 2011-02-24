#import "InterpEvent.h"
@class DebugST;

@interface EvalTemplateEvent : InterpEvent {
}

+ (id) newEvalTemplateEventWithWho:(DebugST *)aWho start:(NSInteger)aStartIdx stop:(NSInteger)aStopIdx;
- (id) initWithWho:(DebugST *)self start:(NSInteger)start stop:(NSInteger)stop;
@end
