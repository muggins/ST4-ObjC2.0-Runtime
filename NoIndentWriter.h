//#import "IOException.h"
#import "AutoIndentWriter.h"
#import "Writer.h"

/**
 * Just pass through the text
 */

@interface NoIndentWriter : AutoIndentWriter {
}

+ (id) newNoIdentWriterWithWriter:(Writer *)aWriter;
- (id) initWithWriter:(Writer *)aWriter;
- (NSInteger) writeStr:(NSString *)str;
@end
