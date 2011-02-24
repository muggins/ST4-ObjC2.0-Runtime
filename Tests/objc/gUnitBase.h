#import "TreeAdaptor.h"
#import "Constructor.h"
#import "Method.h"

@interface gUnitBase : NSObject {
  NSString * lexerClassName;
  NSString * parserClassName;
  NSString * adaptorClassName;
}

- (NSObject *) execParser:(NSString *)ruleName input:(NSString *)input scriptLine:(int)scriptLine;
@end
