#import "ModelAdaptor.h"
#import "ST.h"

@interface STModelAdaptor : NSObject <ModelAdaptor> {
}

- (id) getProperty:(ST *)self obj:(id)obj property:(id)property propertyName:(NSString *)propertyName;
@end
