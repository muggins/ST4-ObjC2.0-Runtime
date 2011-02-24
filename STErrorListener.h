#import "STMessage.h"

@class STMessage;
/**
 * How to handle messages
 */

@protocol STErrorListener <NSObject>
- (void) compileTimeError:(STMessage *)msg;
- (void) runTimeError:(STMessage *)msg;
- (void) IOError:(STMessage *)msg;
- (void) internalError:(STMessage *)msg;
@end
