#import "InterpEvent.h"

@implementation InterpEvent

- (id) initWithWho:(DebugST *)aWho start:(NSInteger)theStart stop:(NSInteger)theStop {
  if (self = [super init]) {
    who = aWho;
    start = theStart;
    astop = theStop;
  }
  return self;
}

- (NSString *) description {
  return [NSString stringWithFormat:@"{self=%@, start=%d, stop=%d}", NSStringFromClass ([self class]), start, astop];
}

- (void) dealloc {
  [self release];
  [super dealloc];
}

@end
