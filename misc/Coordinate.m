#import "Coordinate.h"

@implementation Coordinate

@synthesize line;
@synthesize charPosition;

+ (id) newCoordinate:(NSInteger)a b:(NSInteger)b
{
    return [[Coordinate alloc] init:(NSInteger)a b:(NSInteger)b];
}

- (id) init:(NSInteger)a b:(NSInteger)b {
    if (self = [super init]) {
        line = a;
        charPosition = b;
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%d:%d", line, charPosition];
}

@end
