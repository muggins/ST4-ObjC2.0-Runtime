#import "TestLineWrap.h"
#import "STGroupFile.h"
#import "StringWriter.h"
#import "AutoIndentWriter.h"

@implementation TestLineWrap_Anon1

- (id) init
{
    if ( (self=[super init]) != nil ) {
        [self addObject:@"a"];
        [self addObject:@"x"];
        [self addObject:@"b"];
    }
    return self;
}

@end

@implementation TestLineWrap

- (void) test01LineWrap
{
    int aa[57] = { 3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 2, 1, 6, 32, 5, 6, 77, 4, 9, 20, 2, 1, 4, 63, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 6, 32, 5, 6, 77, 3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 1, 6, 32, 5 };
    NSString *templates = @"array(values) ::= <<int[] a = { <values; wrap=\"\\n\", separator=\",\"> };>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"array"];
    AMutableArray *aaObj = [AMutableArray arrayWithCapacity:60];
    for ( int i = 0; i < 57; i++ ) {
        [aaObj addObject:[ACNumber numberWithInt:aa[i]]];
    }
    [a add:@"values" value:aaObj];

/*
    [a add:@"values" value:[NSArray arrayWithObjects:3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 2, 1, 6, 32, 5, 6, 77, 4, 9, 20, 2, 1, 4, 63, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 6, 32, 5, 6, 77, 3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 1, 6, 32, 5, nil]];
  */
    NSString *expected = @"int[] a = { 3,9,20,2,1,4,6,32,5,6,77,888,\n2,1,6,32,5,6,77,4,9,20,2,1,4,63,9,20,2,1,\n4,6,32,5,6,77,6,32,5,6,77,3,9,20,2,1,4,6,\n32,5,6,77,888,1,6,32,5 };";
    StringWriter *sw = [StringWriter newWriter];
    AutoIndentWriter *stw = [AutoIndentWriter newWriter:sw newline:@"\n"];
    stw.lineWidth = 40;
    [a write:stw];
    NSString *result = [sw description];
    [self assertEquals:expected result:result];
}

- (void) test02LineWrapAnchored
{
    int aa[57] = { 3,9,20,2,1,4,6,32,5,6,77,888,2,1,6,32,5,6,77,4,9,20,2,1,4,63,9,20,2,1,4,6,32,5,6,77,6,32,5,6,77,3,9,20,2,1,4,6,32,5,6,77,888,1,6,32,5 };
    NSString *templates = @"array(values) ::= <<int[] a = { <values; anchor, wrap, separator=\",\"> };>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"array"];
    AMutableArray *aaObj = [AMutableArray arrayWithCapacity:60];
    for ( int i = 0; i < 57; i++ ) {
        [aaObj addObject:[ACNumber numberWithInt:aa[i]]];
    }
    [a add:@"values" value:aaObj];
    
/*
    [a add:@"values" value:[NSArray arrayWithObjects:3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 2, 1, 6, 32, 5, 6, 77, 4, 9, 20, 2, 1, 4, 63, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 6, 32, 5, 6, 77, 3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 1, 6, 32, 5, nil]];
 */
    NSString *expected = @"int[] a = { 3,9,20,2,1,4,6,32,5,6,77,888,\n            2,1,6,32,5,6,77,4,9,20,2,1,4,\n            63,9,20,2,1,4,6,32,5,6,77,6,\n            32,5,6,77,3,9,20,2,1,4,6,32,\n            5,6,77,888,1,6,32,5 };";
    NSString *result = [a renderWithLineWidth:40];
    [self assertEquals:expected result:result];
}

- (void) test03SubtemplatesAnchorToo
{
    NSString *templates = @"array(values) ::= <<{ <values; anchor, separator=\", \"> }>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *x = [ST newSTWithTemplate:@"<\\n>{ <stuff; anchor, separator=\",\\n\"> }<\\n>"];
    x.groupThatCreatedThisInstance = group;
    [x add:@"stuff" value:@"1"];
    [x add:@"stuff" value:@"2"];
    [x add:@"stuff" value:@"3"];
    ST *a = [group getInstanceOf:@"array"];
    NSArray *t = [NSArray arrayWithObjects:@"a", x, @"b", nil];
    [a add:@"values" value:t];
    NSString *expected = @"{ a, \n  { 1,\n    2,\n    3 }\n  , b }";
    NSString *result = [a renderWithLineWidth:40];
    [self assertEquals:expected result:result];
}

- (void) test04FortranLineWrap
{
    NSString *templates = @"func(args) ::= <<       FUNCTION line( <args; wrap=\"\\n      c\", separator=\",\"> )>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"func"];
    [a add:@"args" value:[NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", nil]];
    NSString *expected = @"       FUNCTION line( a,b,c,d,\n      ce,f )";
    NSString *result = [a renderWithLineWidth:30];
    [self assertEquals:expected result:result];
}

- (void) test05LineWrapWithDiffAnchor
{
    int aa[32] = { 3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 2, 1, 6, 32, 5, 6, 77, 4, 9, 20, 2, 1, 4, 63, 9, 20, 2, 1, 4, 6 };
    NSString *templates = @"array(values) ::= <<int[] a = { <{1,9,2,<values; wrap, separator=\",\">}; anchor> };>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"array"];
    AMutableArray *aaObj = [AMutableArray arrayWithCapacity:60];
    for ( int i = 0; i < 32; i++ ) {
        [aaObj addObject:[ACNumber numberWithInt:aa[i]]];
    }
    [a add:@"values" value:aaObj];
    
/*
    [a add:@"values" value:[NSArray arrayWithObjects:3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 2, 1, 6, 32, 5, 6, 77, 4, 9, 20, 2, 1, 4, 63, 9, 20, 2, 1, 4, 6, nil]];
 */
    NSString *expected = @"int[] a = { 1,9,2,3,9,20,2,1,4,\n            6,32,5,6,77,888,2,\n            1,6,32,5,6,77,4,9,\n            20,2,1,4,63,9,20,2,\n            1,4,6 };";
    NSString *result = [a renderWithLineWidth:30];
    [self assertEquals:expected result:result];
}

- (void) test06LineWrapEdgeCase
{
    NSString *templates = @"duh(chars) ::= <<<chars; wrap=\"\\n\"\\>>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"duh"];
    [a add:@"chars" value:[NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", nil]];
    NSString *expected = @"abc\nde";
    NSString *result = [a renderWithLineWidth:3];
    [self assertEquals:expected result:result];
}

- (void) test07LineWrapLastCharIsNewline
{
    NSString *templates = @"duh(chars) ::= <<<chars; wrap=\"\\n\"\\>>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"duh"];
    [a add:@"chars" value:[NSArray arrayWithObjects:@"a", @"b", @"\n", @"d", @"e", nil]];
    NSString *expected = @"ab\nde";
    [self assertEquals:expected result:[a renderWithLineWidth:3]];
}

- (void) test08LineWrapCharAfterWrapIsNewline
{
    NSString *templates = @"duh(chars) ::= <<<chars; wrap=\"\\n\"\\>>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"duh"];
    [a add:@"chars" value:[NSArray arrayWithObjects:@"a", @"b", @"c", @"\n", @"d", @"e", nil]];
    NSString *expected = @"abc\n\nde";
    NSString *result = [a renderWithLineWidth:3];
    [self assertEquals:expected result:result];
}

- (void) test09LineWrapForList
{
    int aa[9] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    NSString *templates = @"duh(data) ::= <<!<data; wrap>!>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"duh"];
    AMutableArray *aaObj = [AMutableArray arrayWithCapacity:10];
    for ( int i = 0; i < 9; i++ ) {
        [aaObj addObject:[ACNumber numberWithInt:aa[i]]];
    }
    [a add:@"data" value:aaObj];
    
/*
    [a add:@"data" value:[NSArray arrayWithObjects:1, 2, 3, 4, 5, 6, 7, 8, 9, nil]];
 */
    NSString *expected = @"!123\n4567\n89!";
    NSString *result = [a renderWithLineWidth:4];
    [self assertEquals:expected result:result];
}

- (void) test10LineWrapForAnonTemplate
{
    int aa[9] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    NSString *templates = @"duh(data) ::= <<!<data:{v|[<v>]}; wrap>!>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"duh"];
    AMutableArray *aaObj = [AMutableArray arrayWithCapacity:10];
    for ( int i = 0; i < 9; i++ ) {
        [aaObj addObject:[ACNumber numberWithInt:aa[i]]];
    }
    [a add:@"data" value:aaObj];
    
/*
     [a add:@"data" value:[NSArray arrayWithObjects:1, 2, 3, 4, 5, 6, 7, 8, 9, nil]];
 */
    NSString *expected = @"![1][2][3]\n[4][5][6]\n[7][8][9]!";
    NSString *result = [a renderWithLineWidth:9];
    [self assertEquals:expected result:result];
}

- (void) test11LineWrapForAnonTemplateAnchored
{
    int aa[9] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    NSString *templates = @"duh(data) ::= <<!<data:{v|[<v>]}; anchor, wrap>!>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"duh"];
    AMutableArray *aaObj = [AMutableArray arrayWithCapacity:10];
    for ( int i = 0; i < 9; i++ ) {
        [aaObj addObject:[ACNumber numberWithInt:aa[i]]];
    }
    [a add:@"data" value:aaObj];
    
/*
     [a add:@"data" value:[NSArray arrayWithObjects:1, 2, 3, 4, 5, 6, 7, 8, 9, nil]];
 */
    NSString *expected = @"![1][2][3]\n [4][5][6]\n [7][8][9]!";
    NSString *result = [a renderWithLineWidth:9];
    [self assertEquals:expected result:result];
}

- (void) test12LineWrapForAnonTemplateComplicatedWrap
{
    int aa[9] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    NSString *templates = @"top(s) ::= <<  <s>.>>str(data) ::= <<!<data:{v|[<v>]}; wrap=\"!+\\n!\">!>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *t = [group getInstanceOf:@"top"];
    ST *s = [group getInstanceOf:@"str"];
    AMutableArray *aaObj = [AMutableArray arrayWithCapacity:10];
    for ( int i = 0; i < 9; i++ ) {
        [aaObj addObject:[ACNumber numberWithInt:aa[i]]];
    }
    [s add:@"data" value:aaObj];
    
/*
     [s add:@"data" value:[NSArray arrayWithObjects:1, 2, 3, 4, 5, 6, 7, 8, 9, nil]];
 */
    [t add:@"s" value:s];
    NSString *expected = @"  ![1][2]!+\n  ![3][4]!+\n  ![5][6]!+\n  ![7][8]!+\n  ![9]!.";
    NSString *result = [t renderWithLineWidth:9];
    [self assertEquals:expected result:result];
}

- (void) test13IndentBeyondLineWidth
{
    NSString *templates = @"duh(chars) ::= <<    <chars; wrap=\"\\n\"\\>>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"duh"];
    [a add:@"chars" value:[NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", nil]];
    NSString *expected = @"    a\n    b\n    c\n    d\n    e";
    NSString *result = [a renderWithLineWidth:2];
    [self assertEquals:expected result:result];
}

- (void) test14IndentedExpr
{
    NSString *templates = @"duh(chars) ::= <<    <chars; wrap=\"\\n\"\\>>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"duh"];
    [a add:@"chars" value:[NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", nil]];
    NSString *expected = @"    ab\n    cd\n    e";
    NSString *result = [a renderWithLineWidth:6];
    [self assertEquals:expected result:result];
}

- (void) test15NestedIndentedExpr
{
    NSString *templates = @"top(d) ::= <<  <d>!>>\nduh(chars) ::= <<  <chars; wrap=\"\\n\"\\>>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *top = [group getInstanceOf:@"top"];
    ST *duh = [group getInstanceOf:@"duh"];
    [duh add:@"chars" value:[NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", nil]];
    [top add:@"d" value:duh];
    NSString *expected = @"    ab\n    cd\n    e!";
    NSString *result = [top renderWithLineWidth:6];
    [self assertEquals:expected result:result];
}

- (void) test16NestedWithIndentAndTrackStartOfExpr
{
    NSString *templates = @"top(d) ::= <<  <d>!>>\nduh(chars) ::= <<x: <chars; anchor, wrap=\"\\n\"\\>>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *top = [group getInstanceOf:@"top"];
    ST *duh = [group getInstanceOf:@"duh"];
    [duh add:@"chars" value:[NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", nil]];
    [top add:@"d" value:duh];
    NSString *expected = @"  x: ab\n     cd\n     e!";
    NSString *result = [top renderWithLineWidth:7];
    [self assertEquals:expected result:result];
}

- (void) test17LineDoesNotWrapDueToLiteral
{
    NSString *templates = @"m(args,body) ::= <<@Test public voidfoo(<args; wrap=\"\\n\",separator=\", \">) throws Ick { <body> }>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *a = [group getInstanceOf:@"m"];
    [a add:@"args" value:[NSArray arrayWithObjects:@"a", @"b", @"c", nil]];
    [a add:@"body" value:@"i=3;"];
    NSInteger n = [@"@Test public voidfoo(a, b, c" length];
    NSString *expected = @"@Test public voidfoo(a, b, c) throws Ick { i=3; }";
    NSString *result = [a renderWithLineWidth:n];
    [self assertEquals:expected result:result];
}

- (void) test18SingleValueWrap
{
    NSString *templates = @"m(args,body) ::= <<{ <body; anchor, wrap=\"\\n\"> }>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *m = [group getInstanceOf:@"m"];
    [m add:@"body" value:@"i=3;"];
    NSString *expected = @"{ \n  i=3; }";
    NSString *result = [m renderWithLineWidth:2];
    [self assertEquals:expected result:result];
}

- (void) test19LineWrapInNestedExpr
{
    int aa[57] = { 3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 2, 1, 6, 32, 5, 6, 77, 4, 9, 20, 2, 1, 4, 63, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 6, 32, 5, 6, 77, 3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 1, 6, 32, 5 };
/*
 String templates = "top(arrays) ::= <<Arrays: <arrays>done>>"+newline+
 "array(values) ::= <<int[] a = { <values; anchor, wrap=\"\\n\", separator=\",\"> };<\\n\\>>>"+newline;
 */
    NSString *templates = @"top(arrays) ::= <<Arrays: <arrays>done>>\narray(values) ::= <<int[] a = { <values; anchor, wrap=\"\\n\", separator=\",\"> };<\\n\\>>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *top = [group getInstanceOf:@"top"];
    ST *a = [group getInstanceOf:@"array"];
    AMutableArray *aaObj = [AMutableArray arrayWithCapacity:10];
    for ( int i = 0; i < 57; i++ ) {
        [aaObj addObject:[ACNumber numberWithInt:aa[i]]];
    }
    [a add:@"values" value:aaObj];
    
    /*
     [a add:@"values" value:[NSArray arrayWithObjects:3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 2, 1, 6, 32, 5, 6, 77, 4, 9, 20, 2, 1, 4, 63, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 6, 32, 5, 6, 77, 3, 9, 20, 2, 1, 4, 6, 32, 5, 6, 77, 888, 1, 6, 32, 5, nil]];
     */
    [top add:@"arrays" value:a];
    [top add:@"arrays" value:a];
    NSString *expected = @"Arrays: int[] a = { 3,9,20,2,1,4,6,32,5,\n                    6,77,888,2,1,6,32,5,\n                    6,77,4,9,20,2,1,4,63,\n                    9,20,2,1,4,6,32,5,6,\n                    77,6,32,5,6,77,3,9,20,\n                    2,1,4,6,32,5,6,77,888,\n                    1,6,32,5 };\nint[] a = { 3,9,20,2,1,4,6,32,5,6,77,888,\n            2,1,6,32,5,6,77,4,9,20,2,1,4,\n            63,9,20,2,1,4,6,32,5,6,77,6,\n            32,5,6,77,3,9,20,2,1,4,6,32,\n            5,6,77,888,1,6,32,5 };\ndone";
    NSString *result = [top renderWithLineWidth:40];
    NSLog(@"Expected = %@", expected);
    NSLog(@"Result   = %@", result);
    [self assertEquals:expected result:result];
}

@end
