#import "ErrorBuffer.h"

@implementation ErrorBuffer

- (id) init {
  if (self = [super init]) {
    errors = [NSMutableArray arrayWithCapacity:16];
  }
  return self;
}

- (void) compileTimeError:(STMessage *)msg {
  [errors addObject:msg];
}

- (void) runTimeError:(STMessage *)msg {
  if (msg.error != NO_SUCH_PROPERTY) {
    [errors addObject:msg];
  }
}

- (void) IOError:(STMessage *)msg {
  [errors addObject:msg];
}

- (void) internalError:(STMessage *)msg {
  [errors addObject:msg];
}

- (NSString *) description {
  NSMutableString *buf = [NSMutableString stringWithCapacity:16];

  for (STMessage * m in errors) {
    [buf appendFormat:@"%@%@", [m description], Misc.newline];
  }

  return [buf description];
}

- (void) dealloc {
  [errors release];
  [super dealloc];
}

@end
