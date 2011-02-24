#import "STErrorListener.h"
#import "Misc.h"

/**
 * Used during tests to track all errors
 */

@interface ErrorBuffer : NSObject <STErrorListener> {
  NSMutableArray * errors;
}

- (id) init;
- (void) compileTimeError:(STMessage *)msg;
- (void) runTimeError:(STMessage *)msg;
- (void) IOError:(STMessage *)msg;
- (void) internalError:(STMessage *)msg;
- (NSString *) description;
@end
