#import "ConstructionEvent.h"

@interface AddAttributeEvent : ConstructionEvent {
  NSString * name;
  NSObject * value;
}

- (id) init:(NSString *)aName value:(id)aValue;
- (NSString *) description;
@end
