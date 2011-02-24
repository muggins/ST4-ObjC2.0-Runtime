#import "NoIndentWriter.h"

@implementation NoIndentWriter

+ (id) newNoIdentWriterWithWriter:(Writer *)aWriter
{
    return [[NoIndentWriter alloc] initWithWriter:(Writer *)aWriter];
}

- (id) initWithWriter:(Writer *)aWriter {
  if (self = [super initWithWriter:aWriter]) {
  }
  return self;
}

- (NSInteger) writeStr:(NSString *)str {
  [writer writeStr:str];
  return [str length];
}

@end
