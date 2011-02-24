
/**
 * An event that happens when building ST trees, adding attributes etc...
 */

@interface StackTraceElement : NSObject
{
    NSString *msg;
}

@property (retain, getter=getMsg, setter=setMsg:) NSString *msg;

- (id) newStackTraceElement:(NSString *)aMsg;
- (id) initWithMessage:(NSString *)aMsg;
- (NSString *) description;

@end


@interface ConstructionEvent : NSObject {
    NSString *fileName;
    NSInteger line;
    NSException *stack;
    StackTraceElement *sTEntryPoint;
}

@property (retain, getter=fileName, setter=setFileName:) NSString *fileName;
@property (assign, getter=line, setter=setLine:) NSInteger line;
@property (retain, getter=getStack, setter=setStack:) NSException *stack;
@property (retain, getter=getSTEntryPoint, setter=setSTEntryPoint:) StackTraceElement *sTEntryPoint;

- (id) init;
- (NSString *) fileName;
- (NSInteger) line;
- (StackTraceElement *) sTEntryPoint;
@end
