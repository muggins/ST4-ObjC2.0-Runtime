
/**
 * A line number and char position within a line.  Used by the source
 * mapping stuff to map address to range within a template.
 */

@interface Coordinate : NSObject {
  NSInteger line;
  NSInteger charPosition;
}

@property (assign, getter=line, setter=setLine:) NSInteger line;
@property (assign, getter=charPosition, setter=setCharPosition:) NSInteger charPosition;

+ (id) newCoordinate:(NSInteger)a b:(NSInteger)b;

- (id) init:(NSInteger)a b:(NSInteger)b;
- (NSString *) description;
@end
