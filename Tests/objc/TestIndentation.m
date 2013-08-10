#import "TestIndentation.h"

@implementation TestIndentation

- (void) test01IndentInFrontOfTwoExpr
{
  NSString *templates = @"list(a,b) ::= <<  <a><b>\n>>\n";
  [self writeFile:tmpdir fileName:@"t.stg" content:templates];
  STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
  ST *st = [group getInstanceOf:@"list"];
  [st.impl dump];
  [st add:@"a" value:@"Terence"];
  [st add:@"b" value:@"Jim"];
  NSString *expecting = @"  TerenceJim";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test02SimpleIndentOfAttributeList
{
  NSString *templates = @"list(names) ::= <<  <names; separator=\"\\n\">\n>>\n";
  [self writeFile:tmpdir fileName:@"t.stg" content:templates];
  STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
  ST *st = [group getInstanceOf:@"list"];
  [st add:@"names" value:@"Terence"];
  [st add:@"names" value:@"Jim"];
  [st add:@"names" value:@"Sriram"];
  NSString *expecting = @"  Terence\n  Jim\n  Sriram";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test03IndentOfMultilineAttributes
{
  NSString *templates = @"list(names) ::= <<  <names; separator=\"\n\">\n>>\n";
  [self writeFile:tmpdir fileName:@"t.stg" content:templates];
  STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
  ST *st = [group getInstanceOf:@"list"];
  [st add:@"names" value:@"Terence\nis\na\nmaniac"];
  [st add:@"names" value:@"Jim"];
  [st add:@"names" value:@"Sriram\nis\ncool"];
  NSString *expecting = @"  Terence\n  is\n  a\n  maniac\n  Jim\n  Sriram\n  is\n  cool";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test04IndentOfMultipleBlankLines
{
  NSString *templates = @"list(names) ::= <<  <names>\n>>\n";
  [self writeFile:tmpdir fileName:@"t.stg" content:templates];
  STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
  ST *st = [group getInstanceOf:@"list"];
  [st add:@"names" value:@"Terence\n\nis a maniac"];
  NSString *expecting = @"  Terence\n\n  is a maniac";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test05IndentBetweenLeftJustifiedLiterals
{
  NSString *templates = @"list(names) ::= <<Before:\n  <names; separator=\"\\n\">\nafter\n>>\n";
  [self writeFile:tmpdir fileName:@"t.stg" content:templates];
  STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
  ST *st = [group getInstanceOf:@"list"];
  [st add:@"names" value:@"Terence"];
  [st add:@"names" value:@"Jim"];
  [st add:@"names" value:@"Sriram"];
  NSString *expecting = @"Before:\n  Terence\n  Jim\n  Sriram\nafter";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test06NestedIndent
{
  NSString *templates = @"method(name,stats) ::= <<void <name>() {\n\t<stats; separator=\"\\n\">\n}\n>>\nifstat(expr,stats) ::= <<\nif (<expr>) {\n  <stats; separator=\"\\n\">\n}>>\nassign(lhs,expr) ::= <<<lhs>=<expr>;>>\n";
  [self writeFile:tmpdir fileName:@"t.stg" content:templates];
  STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
  ST *st = [group getInstanceOf:@"method"];
  [st add:@"name" value:@"foo"];
  ST *s1 = [group getInstanceOf:@"assign"];
  [s1 add:@"lhs" value:@"x"];
  [s1 add:@"expr" value:@"0"];
  ST *s2 = [group getInstanceOf:@"ifstat"];
  [s2 add:@"expr" value:@"x>0"];
  ST *s2a = [group getInstanceOf:@"assign"];
  [s2a add:@"lhs" value:@"y"];
  [s2a add:@"expr" value:@"x+y"];
  ST *s2b = [group getInstanceOf:@"assign"];
  [s2b add:@"lhs" value:@"z"];
  [s2b add:@"expr" value:@"4"];
  [s2 add:@"stats" value:s2a];
  [s2 add:@"stats" value:s2b];
  [st add:@"stats" value:s1];
  [st add:@"stats" value:s2];
  NSString *expecting = @"void foo() {\n\tx=0;\n\tif (x>0) {\n\t  y=x+y;\n\t  z=4;\n\t}\n}";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test07IndentedIFWithValueExpr
{
  ST *st = [ST newSTWithTemplate:@"begin\n    <if(x)>foo<endif>\nend\n"];
  [st add:@"x" value:@"x"];
  NSString *expecting = @"begin\n    foo\nend\n";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test08IndentedIFWithElse
{
  ST *st = [ST newSTWithTemplate:@"begin\n    <if(x)>foo<else>bar<endif>\nend\n"];
  [st add:@"x" value:@"x"];
  NSString *expecting = @"begin\n    foo\nend\n";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test09IndentedIFWithElse2
{
  ST *st = [ST newSTWithTemplate:@"begin\n    <if(x)>foo<else>bar<endif>\nend\n"];
  [st add:@"x" value:NO];
  NSString *expecting = @"begin\n    bar\nend\n";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test10IndentedIFWithNewlineBeforeText
{
  STGroup *group = [STGroup newSTGroup];
  [group defineTemplate:@"t" argsS:@"x" template:@"begin\n    <if(x)>\nfoo\n    <endif>\nend\n"];
  ST *st = [group getInstanceOf:@"t"];
  [st add:@"x" value:@"x"];
  NSString *expecting = @"begin\nfoo\nend";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test11IndentedIFWithEndifNextLine
{
  STGroup *group = [STGroup newSTGroup];
  [group defineTemplate:@"t" argsS:@"x" template:@"begin\n    <if(x)>foo\n    <endif>\nend\n"];
  ST *st = [group getInstanceOf:@"t"];
  [st add:@"x" value:@"x"];
  NSString *expecting = @"begin\n    foo\nend";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test12IFWithIndentOnMultipleLines
{
  ST *st = [ST newSTWithTemplate:@"begin\n   <if(x)>\n   foo\n   <else>\n   bar\n   <endif>\nend\n"];
  NSString *expecting = @"begin\n   bar\nend\n";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test13IFWithIndentAndExprOnMultipleLines
{
  ST *st = [ST newSTWithTemplate:@"begin\n   <if(x)>\n   <x>\n   <else>\n   <y>\n   <endif>\nend\n"];
  [st add:@"y" value:@"y"];
  NSString *expecting = @"begin\n   y\nend\n";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test14IFWithIndentAndExprWithIndentOnMultipleLines
{
  ST *st = [ST newSTWithTemplate:@"begin\n   <if(x)>\n     <x>\n   <else>\n     <y>\n   <endif>\nend\n"];
  [st add:@"y" value:@"y"];
  NSString *expecting = @"begin\n     y\nend\n";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test15NestedIFWithIndentOnMultipleLines
{
  ST *st = [ST newSTWithTemplate:@"begin\n   <if(x)>\n      <if(y)>\n      foo\n      <endif>\n   <else>\n      <if(z)>\n      foo\n      <endif>\n   <endif>\nend\n"];
  [st add:@"x" value:@"x"];
  [st add:@"y" value:@"y"];
  NSString *expecting = @"begin\n      foo\nend\n";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

- (void) test16IFInSubtemplate
{
  ST *st = [ST newSTWithTemplate:@"<names:{n |\n   <if(x)>\n   <x>\n   <else>\n   <y>\n   <endif>\n}>\n"];
  [st add:@"names" value:@"Ter"];
  [st add:@"y" value:@"y"];
  NSString *expecting = @"   y\n\n";
  NSString *result = [st render];
  [self assertEquals:expecting result:result];
}

@end
