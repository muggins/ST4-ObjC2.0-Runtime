
/**
 * An inclusive interval a..b.  Used to track ranges in output and
 * template patterns (for debugging).
 */

@interface Interval : NSObject {
  NSInteger a;
  NSInteger b;
}

@property (assign, getter=getA, setter=setA:) NSInteger a;
@property (assign, getter=getB, setter=setB:) NSInteger b;

+ (id) newInterval:(NSInteger)x b:(NSInteger)y;

- (id) init:(NSInteger)x b:(NSInteger)y;
- (NSString *) description;
@end
