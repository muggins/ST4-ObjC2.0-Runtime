#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "ArrayIterator.h"

@implementation ArrayIterator

- (id) initWithArray:(id)anArray {
  if (self = [super init]) {
    i = -1;
    array = anArray;
    n = [array count];
  }
  return self;
}

- (BOOL) hasNext {
  return (i + 1) < n && n > 0;
}

- (id) next {
  i++;
  if (i >= n) {
      @throw [ANTLRRuntimeException newANTLRNoSuchElementException:@"Iterator error"];
      return nil;
  }
  return [array objectAtIndex:i];
}

- (void) remove {
    @throw [ANTLRRuntimeException newException:@"UnsupportedOperationException" reason:@"can't remove in iterator"];
}

- (void) dealloc {
  [array release];
  [super dealloc];
}

@end
