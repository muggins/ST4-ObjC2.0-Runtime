#import "Interval.h"

@implementation Interval

@synthesize a;
@synthesize b;

+ (id) newInterval:(NSInteger)x b:(NSInteger)y
{
    return [[Interval alloc] init:x b:y];
}

- (id) init:(NSInteger)x b:(NSInteger)y {
  if (self = [super init]) {
    a = x;
    b = y;
  }
  return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%d..%d", a, b];
}

@end
