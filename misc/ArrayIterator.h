//#import "NSArray.h"
//#import "NSEnumerator.h"
//#import "STException.h"

/**
 * Iterator for an array so I don't have to copy the array to a List
 * just to make it iteratable.
 */

@interface ArrayIterator : NSObject {

  /**
   * Index into the data array
 */
  NSInteger i;
  NSArray *array;

  /**
   * Arrays are fixed size; precompute.
 */
  NSInteger n;
}

- (id) initWithArray:(id)anArray;
- (BOOL) hasNext;
- (id) next;
- (void) remove;
@end
