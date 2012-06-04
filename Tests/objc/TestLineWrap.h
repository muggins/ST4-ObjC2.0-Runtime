#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "StringWriter.h"

@interface TestLineWrap_Anon1 : AMutableArray {
}

- (id) init;
@end

@interface TestLineWrap : BaseTest {
}

- (void) test01LineWrap;
- (void) test02LineWrapAnchored;
- (void) test03SubtemplatesAnchorToo;
- (void) test04FortranLineWrap;
- (void) test05LineWrapWithDiffAnchor;
- (void) test06LineWrapEdgeCase;
- (void) test07LineWrapLastCharIsNewline;
- (void) test08LineWrapCharAfterWrapIsNewline;
- (void) test09LineWrapForList;
- (void) test10LineWrapForAnonTemplate;
- (void) test11LineWrapForAnonTemplateAnchored;
- (void) test12LineWrapForAnonTemplateComplicatedWrap;
- (void) test13IndentBeyondLineWidth;
- (void) test14IndentedExpr;
- (void) test15NestedIndentedExpr;
- (void) test16NestedWithIndentAndTrackStartOfExpr;
- (void) test17LineDoesNotWrapDueToLiteral;
- (void) test18SingleValueWrap;
- (void) test19LineWrapInNestedExpr;
@end
