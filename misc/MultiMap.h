//#import "NSMutableDictionary.h"

/**
 * A hash table that maps a key to a list of elements not just a single.
 */

@interface MultiMap : NSMutableDictionary {
}

- (void) map:(id)key value:(id)value;
@end
