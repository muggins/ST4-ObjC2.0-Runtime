#import "NumberRenderer.h"

@implementation NumberRenderer

- (NSString *) description:(id)obj formatString:(NSString *)formatString locale:(NSLocale *)locale {
    if (formatString == nil)
        return [obj description];
    //Formatter *f = [[Formatter alloc] init:locale];
    //[f format:formatString param1:obj];
    //return [f description];
    if ([obj isKindOfClass:[NSString class]] )
        return [NSString stringWithFormat:formatString, obj];
    return nil;
}

@end
