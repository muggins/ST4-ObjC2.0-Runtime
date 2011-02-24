#import "ModelAdaptor.h"
#import "ST.h"
#import "STGroup.h"
//#import "NSMutableDictionary.h"

@interface MapModelAdaptor : NSObject <ModelAdaptor> {
}

- (id) getProperty:(ST *)who obj:(id)obj property:(id)property propertyName:(NSString *)propertyName;
@end
