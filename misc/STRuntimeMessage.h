#import "STMessage.h"
#import "ST.h"
#import "ErrorType.h"
/**
 * Used to track errors that occur in the ST interpreter.
 */

@interface STRuntimeMessage : STMessage {

  /**
   * Where error occurred in bytecode memory
 */
  NSInteger ip;
}

@property(assign, getter=getIp, setter=setIp:) NSInteger ip;

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp;
+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho;
+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho arg:(id)anArg;
+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg;
+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2;
+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2 arg3:(id)anArg3;

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp;
- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho;
- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho arg:(id)anArg;
- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg;
- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2;
- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2 arg3:(id)anArg3;

- (NSString *) getSourceLocation;
- (NSString *) description;
@end
