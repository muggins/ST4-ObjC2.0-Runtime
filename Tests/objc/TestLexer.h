#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "STLexer.h"
#import "STToken.h"

@interface TestLexer : BaseTest {
}

- (void)setUp;
- (void)tearDown;

- (void) checkTokens:(NSString *)template expected:(NSString *)expected;
- (void) checkTokens:(NSString *)template expected:(NSString *)expected delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;

- (void) test01OneExpr;
- (void) test02OneExprSurrounded;
- (void) test03EscDelim;
- (void) test04EscEsc;
- (void) test05EscDelimHasCorrectStartChar;
- (void) test06EscChar;
- (void) test07String;
- (void) test08EscInString;
- (void) test09Subtemplate;
- (void) test10SubtemplateNoArg;
- (void) test11SubtemplateMultiArgs;
- (void) test12NestedSubtemplate;
- (void) test13NestedList;
- (void) test14IF;
- (void) test15IFNot;
- (void) test16IFELSE;
- (void) test17ELSEIF;
- (void) test18EmbeddedRegion;
- (void) test19Region;
@end
