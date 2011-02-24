#import "MultiMap.h"

@implementation MultiMap

- (void) map:(id)key value:(id)value {
  NSMutableArray *elementsForKey = [self valueForKey:key];
  if (elementsForKey == nil) {
    elementsForKey = [NSMutableArray arrayWithCapacity:16];
    [super setObject:elementsForKey forKey:key];
  }
  [elementsForKey addObject:value];
}

@end
