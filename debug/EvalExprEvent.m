#import "EvalExprEvent.h"
#import "ST.h"
#import "CompiledST.h"

@implementation EvalExprEvent

+ (id) newEvalExprEventWithWho:(DebugST *)aWho start:(NSInteger)aStart stop:(NSInteger)aStop exprStart:(NSInteger)anExprStart exprStop:(NSInteger)anExprStop
{
    return [[EvalExprEvent alloc] initWithWho:aWho start:aStart stop:aStop exprStart:anExprStart exprStop:anExprStop];
}

- (id) initWithWho:(DebugST *)aWho start:(NSInteger)theStart stop:(NSInteger)theStop exprStart:(NSInteger)anExprStart exprStop:(NSInteger)anExprStop
{
  if (self = [super initWithWho:aWho start:theStart stop:theStop]) {
    exprStart = anExprStart;
    exprStop = anExprStop;
    if (exprStart >= 0 && exprStop >= 0) {
      expr = [((CompiledST *)((ST *)aWho).impl).template substringWithRange:NSMakeRange(exprStart, (exprStop-exprStart) + 1)];
    }
  }
  return self;
}

- (NSString *) description
{
  return [NSString stringWithFormat:@"{self=%@, start=%d, stop=%d, expr=%@}", [self className], start, astop, expr];
}

- (void) dealloc
{
  [expr release];
  [super dealloc];
}

@end
