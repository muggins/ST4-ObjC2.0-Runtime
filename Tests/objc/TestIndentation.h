#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ST.h"
#import "STGroup.h"
#import "STGroupFile.h"

@interface TestIndentation : BaseTest {
}

- (void) test01IndentInFrontOfTwoExpr;
- (void) test02SimpleIndentOfAttributeList;
- (void) test03IndentOfMultilineAttributes;
- (void) test04IndentOfMultipleBlankLines;
- (void) test05IndentBetweenLeftJustifiedLiterals;
- (void) test06NestedIndent;
- (void) test07IndentedIFWithValueExpr;
- (void) test08IndentedIFWithElse;
- (void) test09IndentedIFWithElse2;
- (void) test10IndentedIFWithNewlineBeforeText;
- (void) test11IndentedIFWithEndifNextLine;
- (void) test12IFWithIndentOnMultipleLines;
- (void) test13IFWithIndentAndExprOnMultipleLines;
- (void) test14IFWithIndentAndExprWithIndentOnMultipleLines;
- (void) test15NestedIFWithIndentOnMultipleLines;
- (void) test16IFInSubtemplate;
@end
