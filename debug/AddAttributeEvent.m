#import "AddAttributeEvent.h"

@implementation AddAttributeEvent

- (id) init:(NSString *)aName value:(id)aValue {
  if (self = [super init]) {
    name = aName;
    value = aValue;
  }
  return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"addEvent{, name='%@', value=%@, location=%@:%d}", name, value, [self fileName], [self line]];
}

- (void) dealloc {
  [name release];
  [value release];
  [super dealloc];
}

@end
