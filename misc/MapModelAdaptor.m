#import "MapModelAdaptor.h"

@implementation MapModelAdaptor

- (id) getProperty:(ST *)aWho obj:(id)obj property:(id)aProperty propertyName:(NSString *)aPropertyName
{
    id value;
    NSMutableDictionary *map = (NSMutableDictionary *)obj;
    if (aProperty == nil)
        value = [map objectForKey:STGroup.DEFAULT_KEY];
    else if ([aProperty isEqualTo:@"keys"])
        value = [map allKeys];
    else if ([aProperty isEqualTo:@"values"])
        value = [map allValues];
    else if ([map objectForKey:aProperty])
        value = [map objectForKey:aProperty];
    else if ([map objectForKey:aPropertyName]) {
        value = [map objectForKey:aPropertyName];
    }
    else
        value = [map objectForKey:STGroup.DEFAULT_KEY];
    if (value == STGroup.DICT_KEY) {
        value = aProperty;
    }
    return value;
}

@end
