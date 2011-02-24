//#import "Token.h"
#import "ST.h"
#import "ModelAdaptor.h"
#import "ErrorType.h"
#import "PrintWriter.h"
#import "StringWriter.h"
#import "ErrorType.h"

/**
 * Upon error, ST creates an STMessage or subclass instance and notifies
 * the listener.  This root class is used for IO and internal errors.
 * 
 * @see STRuntimeMessage
 * @see STCompiletimeMessage
 */

@interface STMessage : NSObject {

  /**
   * if in debug mode, has created instance, add attr events and eval
   * template events.
 */
  ST *who;
  ErrorTypeEnum error;
  id arg;
  id arg2;
  id arg3;
  NSException *cause;
}

@property (retain, getter=getWho, setter=setWho:) ST *who;
@property (assign, getter=getError, setter=setError:) ErrorTypeEnum error;
@property (retain, getter=getArg, setter=setArg:) id arg;
@property (retain, getter=getArg2, setter=setArg2:) id arg2;
@property (retain, getter=getArg3, setter=setArg3:) id arg3;
@property (retain, getter=getCause, setter=setCause:) NSException *cause;

+ (id) newMessage:(ErrorTypeEnum)anError;
+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho;
+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause;
+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg;
+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause where:(ANTLRCommonToken *)where  arg:(id)arg;
+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg arg2:(id)arg2;
+ (id) newMessage:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg arg2:(id)arg2 arg3:(id)arg3;

- (id) init:(ErrorTypeEnum)anError;
- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho;
- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause;
- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg;
- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause where:(ANTLRCommonToken *)where arg:(id)arg;
- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg arg2:(id)arg2;
- (id) init:(ErrorTypeEnum)anError who:(ST *)aWho cause:(NSException *)aCause arg:(id)arg arg2:(id)arg2 arg3:(id)arg3;
- (NSString *) description;
@end
