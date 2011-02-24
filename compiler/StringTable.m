#import "StringTable.h"

@implementation StringTable

- (id) init
{
    if (self = [super init]) {
        table = [NSMutableDictionary dictionaryWithCapacity:10];
        i = -1;
    }
    return self;
}

- (NSInteger) addObject:(NSString *)s
{
    NSNumber *I = [table objectForKey:s];
    if (I != nil)
        return [I integerValue];
    i++;
    [table setObject:[NSNumber numberWithInteger:i] forKey:s];
    return i;
}

- (NSMutableArray *) toArray
{
    NSMutableArray *a = [NSMutableArray arrayWithCapacity:10];
    
    for (NSString *s in [table allKeys])
        [a addObject:s];
    
    return a;
}

- (void) dealloc
{
    [table release];
    [super dealloc];
}

@end
