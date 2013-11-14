#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import <SenTestingKit/SenTestingKit.h>
#import "STGroup.h"
#import "STGroupFile.h"
#import "InterpEvent.h"
#import "Misc.h"
#import <ANTLR/AMutableArray.h>

@interface TestDebugEvents : SenTestCase {
}

- (void) testString;
- (void) testAttribute;
- (void) testTemplateCall;
@end
