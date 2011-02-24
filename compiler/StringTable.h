//#import "LinkedHashMap.h"
#import <ANTLR/ANTLR.h>

/**
 * A unique set of strings where we can get a string's index.
 * We can also get them back out in original order.
 */

@interface StringTable : NSObject {
  NSMutableDictionary *table;
  NSInteger i;
}

- (id) init;
- (NSInteger) addObject:(NSString *)s;
- (NSMutableArray *) toArray;
@end
