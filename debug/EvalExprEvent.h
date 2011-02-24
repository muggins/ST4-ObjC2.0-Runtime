#import "InterpEvent.h"

@interface EvalExprEvent : InterpEvent {
  NSInteger exprStart;
  NSInteger exprStop;
  NSString *expr;
}

+ (id) newEvalExprEventWithWho:(DebugST *)who start:(NSInteger)aStart stop:(NSInteger)aStop exprStart:(NSInteger)anExprStart exprStop:(NSInteger)anExprStop;
- (id) initWithWho:(DebugST *)who start:(NSInteger)aStart stop:(NSInteger)aStop exprStart:(NSInteger)anExprStart exprStop:(NSInteger)anExprStop;
- (NSString *) description;
@end
