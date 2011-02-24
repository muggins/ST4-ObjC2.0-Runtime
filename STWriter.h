/**
 * Generic StringTemplate output writer filter.
 * 
 * Literals and the elements of expressions are emitted via write().
 * Separators are emitted via writeSeparator() because they must be
 * handled specially when wrapping lines (we don't want to wrap
 * in between an element and it's separator).
 */

@protocol STWriter <NSObject>
- (void) pushIndentation:(NSString *)indent;
- (NSString *) popIndentation;
- (void) pushAnchorPoint;
- (void) popAnchorPoint;
- (void) setLineWidth:(NSInteger)lineWidth;
- (NSInteger) write:(NSString *)str;
- (NSInteger) write:(NSString *)str wrap:(NSString *)wrap;
- (NSInteger) writeWrap:(NSString *)wrap;
- (NSInteger) writeSeparator:(NSString *)str;
- (NSInteger) index;
@end
