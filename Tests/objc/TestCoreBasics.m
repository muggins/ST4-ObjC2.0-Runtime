#import <Cocoa/Cocoa.h>
#import <SenTestingKit/SenTestingKit.h>
#import "TestCoreBasics.h"

@implementation TestCoreBasics_Anon1

- (void) init {
  if (self = [super init]) {
    [self add:@"Ter"];
    [self add:@"Tom"];
  }
  return self;
}

@end

@implementation TestCoreBasics_Anon2

- (void) init {
  if (self = [super init]) {
    [self put:@"a" arg1:@"b"];
  }
  return self;
}

@end

@implementation TestCoreBasics_Anon3

- (void) init {
  if (self = [super init]) {
    [self add:@"Ter"];
    [self add:@"Tom"];
  }
  return self;
}

@end

@implementation TestCoreBasics

- (void) testNullAttr {
  NSString * template = @"hi <name>!";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = @"hi !";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testAttr {
  NSString * template = @"hi <name>!";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"hi Ter!";
  NSString * result = [st render];
  STAssertTrue( [self assertEquals:expected arg1:result] );
}

- (void) testSetUnknownAttr {
  NSString * templates = @"t() ::= <<hi <name>!>>\n";
  ErrorBuffer * errors = [[[ErrorBuffer alloc] init] autorelease];
  [self writeFile:tmpdir arg1:@"t.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"t.stg"]] autorelease];
  [group setListener:errors];
  ST * st = [group getInstanceOf:@"t"];
  NSString * result = nil;

  @try {
    [st add:@"name" arg1:@"Ter"];
  }
  @catch (IllegalArgumentException * iae) {
    result = [iae message];
  }
  NSString * expected = @"no such attribute: name";
  [self assertEquals:expected arg1:result];
}

- (void) testMultiAttr {
  NSString * template = @"hi <name>!";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  NSString * expected = @"hi TerTom!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testAttrIsList {
  NSString * template = @"hi <name>!";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSMutableArray * names = [[[TestCoreBasics_Anon1 alloc] init] autorelease];
  [st add:@"name" arg1:names];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi TerTomSumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
  [self assertTrue:[names count] == 2];
}

- (void) testAttrIsArray {
  NSString * template = @"hi <name>!";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSArray * names = [NSArray arrayWithObjects:@"Ter", @"Tom", nil];
  [st add:@"name" arg1:names];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi TerTomSumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testProp {
  NSString * template = @"<u.id>: <u.name>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"u" arg1:[[[User alloc] init:1 arg1:@"parrt"] autorelease]];
  NSString * expected = @"1: parrt";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testPropWithNoAttr {
  NSString * template = @"<foo.a>: <ick>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"foo" arg1:[[[TestCoreBasics_Anon2 alloc] init] autorelease]];
  NSString * expected = @"b: ";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testSTProp {
  NSString * template = @"<t.x>";
  ST * st = [[[ST alloc] init:template] autorelease];
  ST * t = [[[ST alloc] init:@"<x>"] autorelease];
  [t add:@"x" arg1:@"Ter"];
  [st add:@"t" arg1:t];
  NSString * expected = @"Ter";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testBooleanISProp {
  NSString * template = @"<t.manager>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"t" arg1:[[[User alloc] init:32 arg1:@"Ter"] autorelease]];
  NSString * expected = @"true";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testBooleanHASProp {
  NSString * template = @"<t.parkingSpot>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"t" arg1:[[[User alloc] init:32 arg1:@"Ter"] autorelease]];
  NSString * expected = @"true";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testNullAttrProp {
  NSString * template = @"<u.id>: <u.name>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = @": ";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testNoSuchProp {
  ErrorBufferAllErrors * errors = [[[ErrorBufferAllErrors alloc] init] autorelease];
  NSString * template = @"<u.qqq>";
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group setListener:errors];
  ST * st = [[[ST alloc] init:group arg1:template] autorelease];
  [st add:@"u" arg1:[[[User alloc] init:1 arg1:@"parrt"] autorelease]];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
  STRuntimeMessage * msg = (STRuntimeMessage *)[errors.errors get:0];
  STNoSuchPropertyException * e = (STNoSuchPropertyException *)msg.cause;
  [self assertEquals:@"org.stringtemplate.v4.test.BaseTest$User.qqq" arg1:e.propertyName];
}

- (void) testNullIndirectProp {
  ErrorBufferAllErrors * errors = [[[ErrorBufferAllErrors alloc] init] autorelease];
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group setListener:errors];
  NSString * template = @"<u.(qqq)>";
  ST * st = [[[ST alloc] init:group arg1:template] autorelease];
  [st add:@"u" arg1:[[[User alloc] init:1 arg1:@"parrt"] autorelease]];
  [st add:@"qqq" arg1:nil];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
  STRuntimeMessage * msg = (STRuntimeMessage *)[errors.errors get:0];
  STNoSuchPropertyException * e = (STNoSuchPropertyException *)msg.cause;
  [self assertEquals:@"org.stringtemplate.v4.test.BaseTest$User.null" arg1:e.propertyName];
}

- (void) testPropConvertsToString {
  ErrorBufferAllErrors * errors = [[[ErrorBufferAllErrors alloc] init] autorelease];
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group setListener:errors];
  NSString * template = @"<u.(name)>";
  ST * st = [[[ST alloc] init:group arg1:template] autorelease];
  [st add:@"u" arg1:[[[User alloc] init:1 arg1:@"parrt"] autorelease]];
  [st add:@"name" arg1:100];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
  STRuntimeMessage * msg = (STRuntimeMessage *)[errors.errors get:0];
  STNoSuchPropertyException * e = (STNoSuchPropertyException *)msg.cause;
  [self assertEquals:@"org.stringtemplate.v4.test.BaseTest$User.100" arg1:e.propertyName];
}

- (void) testInclude {
  NSString * template = @"load <box()>;";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st.impl.nativeGroup defineTemplate:@"box" arg1:[[@"kewl" stringByAppendingString:newline] stringByAppendingString:@"daddy"]];
  NSString * expected = [[@"load kewl" stringByAppendingString:newline] stringByAppendingString:@"daddy;"];
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testIncludeWithArg {
  NSString * template = @"load <box(\"arg\")>;";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st.impl.nativeGroup defineTemplate:@"box" arg1:@"x" arg2:@"kewl <x> daddy"];
  [st.impl dump];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"load kewl arg daddy;";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testIncludeWithArg2 {
  NSString * template = @"load <box(\"arg\", foo())>;";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st.impl.nativeGroup defineTemplate:@"box" arg1:@"x,y" arg2:@"kewl <x> <y> daddy"];
  [st.impl.nativeGroup defineTemplate:@"foo" arg1:@"blech"];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"load kewl arg blech daddy;";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testIncludeWithNestedArgs {
  NSString * template = @"load <box(foo(\"arg\"))>;";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st.impl.nativeGroup defineTemplate:@"box" arg1:@"y" arg2:@"kewl <y> daddy"];
  [st.impl.nativeGroup defineTemplate:@"foo" arg1:@"x" arg2:@"blech <x>"];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"load kewl blech arg daddy;";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testDefineTemplate {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"inc" arg1:@"x" arg2:@"<x>+1"];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi TerTomSumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMap {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"inc" arg1:@"x" arg2:@"[<x>]"];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name:inc()>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi [Ter][Tom][Sumana]!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testIndirectMap {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"inc" arg1:@"x" arg2:@"[<x>]"];
  [group defineTemplate:@"test" arg1:@"t,name" arg2:@"<name:(t)()>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"t" arg1:@"inc"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"[Ter][Tom][Sumana]!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMapWithExprAsTemplateName {
  NSString * templates = [[@"d ::= [\"foo\":\"bold\"]\n" stringByAppendingString:@"test(name) ::= \"<name:(d.foo)()>\"\n"] stringByAppendingString:@"bold(x) ::= <<*<x>*>>\n"];
  [self writeFile:tmpdir arg1:@"t.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"t.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"*Ter**Tom**Sumana*";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testParallelMap {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names,phones" arg2:@"hi <names,phones:{n,p | <n>:<p>;}>"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  [st add:@"phones" arg1:@"x5001"];
  [st add:@"phones" arg1:@"x5002"];
  [st add:@"phones" arg1:@"x5003"];
  NSString * expected = @"hi Ter:x5001;Tom:x5002;Sumana:x5003;";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testParallelMapWith3Versus2Elements {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names,phones" arg2:@"hi <names,phones:{n,p | <n>:<p>;}>"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  [st add:@"phones" arg1:@"x5001"];
  [st add:@"phones" arg1:@"x5002"];
  NSString * expected = @"hi Ter:x5001;Tom:x5002;Sumana:;";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testParallelMapThenMap {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"bold" arg1:@"x" arg2:@"[<x>]"];
  [group defineTemplate:@"test" arg1:@"names,phones" arg2:@"hi <names,phones:{n,p | <n>:<p>;}:bold()>"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  [st add:@"phones" arg1:@"x5001"];
  [st add:@"phones" arg1:@"x5002"];
  NSString * expected = @"hi [Ter:x5001;][Tom:x5002;][Sumana:;]";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMapThenParallelMap {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"bold" arg1:@"x" arg2:@"[<x>]"];
  [group defineTemplate:@"test" arg1:@"names,phones" arg2:@"hi <[names:bold()],phones:{n,p | <n>:<p>;}>"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  [st add:@"phones" arg1:@"x5001"];
  [st add:@"phones" arg1:@"x5002"];
  NSString * expected = @"hi [Ter]:x5001;[Tom]:x5002;[Sumana]:;";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMapIndexes {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"inc" arg1:@"x,i" arg2:@"<i>:<x>"];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"<name:{n|<inc(n,i)>}; separator=\", \">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:nil];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"1:Ter, 2:Tom, 3:Sumana";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMapIndexes2 {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"<name:{n | <i>:<n>}; separator=\", \">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:nil];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"1:Ter, 2:Tom, 3:Sumana";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMapSingleValue {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"a" arg1:@"x" arg2:@"[<x>]"];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name:a()>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"hi [Ter]!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMapNullValue {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"a" arg1:@"x" arg2:@"[<x>]"];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name:a()>!"];
  ST * st = [group getInstanceOf:@"test"];
  NSString * expected = @"hi !";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMapNullValueInList {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"<name; separator=\", \">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:nil];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"Ter, Tom, Sumana";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testRepeatedMap {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"a" arg1:@"x" arg2:@"[<x>]"];
  [group defineTemplate:@"b" arg1:@"x" arg2:@"(<x>)"];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name:a():b()>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi ([Ter])([Tom])([Sumana])!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testRoundRobinMap {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"a" arg1:@"x" arg2:@"[<x>]"];
  [group defineTemplate:@"b" arg1:@"x" arg2:@"(<x>)"];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name:a(),b()>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi [Ter](Tom)[Sumana]!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testTrueCond {
  NSString * template = @"<if(name)>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testEmptyIFTemplate {
  NSString * template = @"<if(x)>fail<elseif(name)><endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testCondParens {
  NSString * template = @"<if(!(x||y)&&!z)>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testFalseCond {
  NSString * template = @"<if(name)>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testFalseCond2 {
  NSString * template = @"<if(name)>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:nil];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testFalseCondWithFormalArgs {
  NSString * dir = [self randomDir];
  NSString * groupFile = [[[[[@"a(scope) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"foo"] + newline stringByAppendingString:@"    <if(scope)>oops<endif>"] + newline stringByAppendingString:@"bar"] + newline stringByAppendingString:@">>"];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"a"];
  [st.impl dump];
  NSString * expected = [[@"foo" stringByAppendingString:newline] stringByAppendingString:@"bar"];
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testElseIf2 {
  NSString * template = @"<if(x)>fail1<elseif(y)>fail2<elseif(z)>works<else>fail3<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"z" arg1:@"blort"];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testElseIf3 {
  NSString * template = @"<if(x)><elseif(y)><elseif(z)>works<else><endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"z" arg1:@"blort"];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testNotTrueCond {
  NSString * template = @"<if(!name)>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testNotFalseCond {
  NSString * template = @"<if(!name)>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testParensInConditonal {
  NSString * template = @"<if((a||b)&&(c||d))>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"a" arg1:YES];
  [st add:@"b" arg1:YES];
  [st add:@"c" arg1:YES];
  [st add:@"d" arg1:YES];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testParensInConditonal2 {
  NSString * template = @"<if((!a||b)&&!(c||d))>broken<else>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"a" arg1:YES];
  [st add:@"b" arg1:YES];
  [st add:@"c" arg1:YES];
  [st add:@"d" arg1:YES];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testTrueCondWithElse {
  NSString * template = @"<if(name)>works<else>fail<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testFalseCondWithElse {
  NSString * template = @"<if(name)>fail<else>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testElseIf {
  NSString * template = @"<if(name)>fail<elseif(id)>works<else>fail<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"id" arg1:@"2DF3DF"];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testElseIfNoElseAllFalse {
  NSString * template = @"<if(name)>fail<elseif(id)>fail<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testElseIfAllExprFalse {
  NSString * template = @"<if(name)>fail<elseif(id)>fail<else>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testOr {
  NSString * template = @"<if(name||notThere)>works<else>fail<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMapConditionAndEscapeInside {
  NSString * template = @"<if(m.name)>works \\\\<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSMutableDictionary * m = [[[NSMutableDictionary alloc] init] autorelease];
  [m setObject:@"name" arg1:@"Ter"];
  [st add:@"m" arg1:m];
  NSString * expected = @"works \\";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testAnd {
  NSString * template = @"<if(name&&notThere)>fail<else>works<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testAndNot {
  NSString * template = @"<if(name&&!notThere)>works<else>fail<endif>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"works";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testCharLiterals {
  ST * st = [[[ST alloc] init:@"Foo <\\n><\\n><\\t> bar\n"] autorelease];
  StringWriter * sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\n"] autorelease]];
  NSString * result = [sw description];
  NSString * expecting = @"Foo \n\n\t bar\n";
  [self assertEquals:expecting arg1:result];
  st = [[[ST alloc] init:[@"Foo <\\n><\\t> bar" stringByAppendingString:newline]] autorelease];
  sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\n"] autorelease]];
  expecting = @"Foo \n\t bar\n";
  result = [sw description];
  [self assertEquals:expecting arg1:result];
  st = [[[ST alloc] init:@"Foo<\\ >bar<\\n>"] autorelease];
  sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\n"] autorelease]];
  result = [sw description];
  expecting = @"Foo bar\n";
  [self assertEquals:expecting arg1:result];
}

- (void) testUnicodeLiterals {
  ST * st = [[[ST alloc] init:@"Foo <\\uFEA5><\\n><\\u00C2> bar\n"] autorelease];
  NSString * expecting = [[@"Foo ?" stringByAppendingString:newline] stringByAppendingString:@"å bar"] + newline;
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
  st = [[[ST alloc] init:[@"Foo <\\uFEA5><\\n><\\u00C2> bar" stringByAppendingString:newline]] autorelease];
  expecting = [[@"Foo ?" stringByAppendingString:newline] stringByAppendingString:@"å bar"] + newline;
  result = [st render];
  [self assertEquals:expecting arg1:result];
  st = [[[ST alloc] init:@"Foo<\\ >bar<\\n>"] autorelease];
  expecting = [@"Foo bar" stringByAppendingString:newline];
  result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testSubtemplateExpr {
  NSString * template = @"<{name\n}>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSString * expected = [@"name" stringByAppendingString:newline];
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testSeparator {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names" arg2:@"<names:{n | case <n>}; separator=\", \">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  NSString * expected = @"case Ter, case Tom";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testSeparatorInList {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names" arg2:@"<names:{n | case <n>}; separator=\", \">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:[[[TestCoreBasics_Anon3 alloc] init] autorelease]];
  NSString * expected = @"case Ter, case Tom";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}


/**
 * (...) forces early eval to string. early eval <(x)> using new
 * STWriter derived from type of current STWriter. e.g., AutoIndentWriter.
 */
- (void) testEarlyEvalIndent {
  NSString * templates = [[[[[[@"t() ::= <<  abc>>\n" stringByAppendingString:@"main() ::= <<\n"] stringByAppendingString:@"<t()>\n"] stringByAppendingString:@"<(t())>\n"] stringByAppendingString:@"  <t()>\n"] stringByAppendingString:@"  <(t())>\n"] stringByAppendingString:@">>\n"];
  [self writeFile:tmpdir arg1:@"t.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"t.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"main"];
  NSString * result = [st render];
  NSString * expected = [[[@"  abc\n" stringByAppendingString:@"  abc\n"] stringByAppendingString:@"    abc\n"] stringByAppendingString:@"    abc"];
  [self assertEquals:expected arg1:result];
}

- (void) testEarlyEvalNoIndent {
  NSString * templates = [[[[[[@"t() ::= <<  abc>>\n" stringByAppendingString:@"main() ::= <<\n"] stringByAppendingString:@"<t()>\n"] stringByAppendingString:@"<(t())>\n"] stringByAppendingString:@"  <t()>\n"] stringByAppendingString:@"  <(t())>\n"] stringByAppendingString:@">>\n"];
  [self writeFile:tmpdir arg1:@"t.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"t.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"main"];
  StringWriter * sw = [[[StringWriter alloc] init] autorelease];
  NoIndentWriter * w = [[[NoIndentWriter alloc] init:sw] autorelease];
  [st write:w];
  NSString * result = [sw description];
  NSString * expected = [[[@"abc\n" stringByAppendingString:@"abc\n"] stringByAppendingString:@"abc\n"] stringByAppendingString:@"abc"];
  [self assertEquals:expected arg1:result];
}

- (void) playing {
  NSString * template = @"<a:t(x,y),u()>";
  ST * st = [[[ST alloc] init:template] autorelease];
  [st.impl dump];
}

@end
