#import "STModelAdaptor.h"

@implementation STModelAdaptor

- (id) getProperty:(ST *)aWho obj:(id)obj property:(id)property propertyName:(NSString *)propertyName {
  ST *st = (ST *)obj;
  return [st getAttribute:propertyName];
}

@end
