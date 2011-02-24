@class DebugST;

@interface InterpEvent : NSObject {
  DebugST *who;
  NSInteger start;
  NSInteger astop;
}

- (id) initWithWho:(DebugST *)aWho start:(NSInteger)theStart stop:(NSInteger)theStop;
- (NSString *) description;
@end
