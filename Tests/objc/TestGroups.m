#import "TestGroups.h"

@implementation Field

- (void) init {
  if (self = [super init]) {
    name = @"parrt";
    n = 0;
  }
  return self;
}

- (NSString *) description {
  return @"Field";
}

- (void) dealloc {
  [name release];
  [super dealloc];
}

@end

@implementation Field

- (void) init {
  if (self = [super init]) {
    name = @"parrt";
    n = 0;
  }
  return self;
}

- (NSString *) description {
  return @"Field";
}

- (void) dealloc {
  [name release];
  [super dealloc];
}

@end

@implementation Field

- (void) init {
  if (self = [super init]) {
    name = @"parrt";
    n = 0;
  }
  return self;
}

- (NSString *) description {
  return @"Field";
}

- (void) dealloc {
  [name release];
  [super dealloc];
}

@end

@implementation Counter

- (void) init {
  if (self = [super init]) {
    n = 0;
  }
  return self;
}

- (NSString *) description {
  return [String valueOf:n++];
}

@end

@implementation TestGroups

- (void) testSimpleGroup {
  NSString * dir = [self randomDir];
  NSString * a = [[[@"a(x) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"foo"] + newline stringByAppendingString:@">>"] + newline;
  [self writeFile:dir arg1:@"a.st" arg2:a];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st = [group getInstanceOf:@"a"];
  NSString * expected = @"foo";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testGroupWithTwoTemplates {
  NSString * dir = [self randomDir];
  NSString * a = [[[@"a(x) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"foo"] + newline stringByAppendingString:@">>"] + newline;
  [self writeFile:dir arg1:@"a.st" arg2:a];
  NSString * b = [@"b() ::= \"bar\"" stringByAppendingString:newline];
  [self writeFile:dir arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st1 = [group getInstanceOf:@"a"];
  ST * st2 = [group getInstanceOf:@"b"];
  NSString * expected = @"foobar";
  NSString * result = [st1 render] + [st2 render];
  [self assertEquals:expected arg1:result];
}

- (void) testSubdir {
  NSString * dir = [self randomDir];
  NSString * a = [[[@"a(x) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"foo"] + newline stringByAppendingString:@">>"] + newline;
  [self writeFile:dir arg1:@"a.st" arg2:a];
  NSString * b = [@"b() ::= \"bar\"" stringByAppendingString:newline];
  [self writeFile:[dir stringByAppendingString:@"/subdir"] arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st1 = [group getInstanceOf:@"a"];
  ST * st2 = [group getInstanceOf:@"subdir/b"];
  NSString * expected = @"foobar";
  NSString * result = [st1 render] + [st2 render];
  [self assertEquals:expected arg1:result];
  st2 = [group getInstanceOf:@"subdir/b"];
  expected = @"bar";
  result = [st2 render];
  [self assertEquals:expected arg1:result];
}

- (void) testAbsoluteTemplateRef {
  NSString * dir = [self randomDir];
  NSString * a = @"a(x) ::= << <subdir/b()> >>\n";
  [self writeFile:dir arg1:@"a.st" arg2:a];
  NSString * b = @"b() ::= <<bar>>\n";
  [self writeFile:[dir stringByAppendingString:@"/subdir"] arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st = [group getInstanceOf:@"a"];
  NSString * expected = @" bar ";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testGroupFileInDir {
  NSString * dir = [self randomDir];
  NSString * a = [[@"a(x) ::= <<\n" stringByAppendingString:@"foo\n"] stringByAppendingString:@">>\n"];
  [self writeFile:dir arg1:@"a.st" arg2:a];
  NSString * groupFile = [@"b() ::= \"bar\"\n" stringByAppendingString:@"c() ::= \"duh\"\n"];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st1 = [group getInstanceOf:@"a"];
  ST * st2 = [group getInstanceOf:@"group/b"];
  ST * st3 = [group getInstanceOf:@"group/c"];
  NSString * expected = @"foobarduh";
  NSString * result = [st1 render] + [st2 render] + [st3 render];
  [self assertEquals:expected arg1:result];
}

- (void) testSubSubdir {
  NSString * dir = [self randomDir];
  NSString * a = [[[@"a(x) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"foo"] + newline stringByAppendingString:@">>"] + newline;
  [self writeFile:dir arg1:@"a.st" arg2:a];
  NSString * b = [@"b() ::= \"bar\"" stringByAppendingString:newline];
  [self writeFile:[dir stringByAppendingString:@"/sub1/sub2"] arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st1 = [group getInstanceOf:@"a"];
  ST * st2 = [group getInstanceOf:@"sub1/sub2/b"];
  NSString * expected = @"foobar";
  NSString * result = [st1 render] + [st2 render];
  [self assertEquals:expected arg1:result];
}

- (void) testGroupFileInSubDir {
  NSString * dir = [self randomDir];
  NSString * a = [[@"a(x) ::= <<\n" stringByAppendingString:@"foo\n"] stringByAppendingString:@">>\n"];
  [self writeFile:dir arg1:@"a.st" arg2:a];
  NSString * groupFile = [@"b() ::= \"bar\"\n" stringByAppendingString:@"c() ::= \"duh\"\n"];
  [self writeFile:dir arg1:@"subdir/group.stg" arg2:groupFile];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st1 = [group getInstanceOf:@"a"];
  ST * st2 = [group getInstanceOf:@"subdir/group/b"];
  ST * st3 = [group getInstanceOf:@"subdir/group/c"];
  NSString * expected = @"foobarduh";
  NSString * result = [st1 render] + [st2 render] + [st3 render];
  [self assertEquals:expected arg1:result];
}

- (void) testRefToAnotherTemplateInSameGroup {
  NSString * dir = [self randomDir];
  NSString * a = @"a() ::= << <b()> >>\n";
  NSString * b = @"b() ::= <<bar>>\n";
  [self writeFile:dir arg1:@"a.st" arg2:a];
  [self writeFile:dir arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st = [group getInstanceOf:@"a"];
  NSString * expected = @" bar ";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testRefToAnotherTemplateInSameSubdir {
  NSString * dir = [self randomDir];
  NSString * a = @"a() ::= << <subdir/b()> >>\n";
  NSString * b = @"b() ::= <<bar>>\n";
  [self writeFile:[dir stringByAppendingString:@"/subdir"] arg1:@"a.st" arg2:a];
  [self writeFile:[dir stringByAppendingString:@"/subdir"] arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st = [group getInstanceOf:@"subdir/a"];
  [st.impl dump];
  NSString * expected = @" bar ";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testDupDef {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"b() ::= \"bar\"\n" stringByAppendingString:@"b() ::= \"duh\"\n"];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STErrorListener * errors = [[[ErrorBuffer alloc] init] autorelease];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  [group setListener:errors];
  [group load];
  NSString * expected = [@"group.stg 2:0: redefinition of template b" stringByAppendingString:newline];
  NSString * result = [errors description];
  [self assertEquals:expected arg1:result];
}

- (void) testAlias {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"a() ::= \"bar\"\n" stringByAppendingString:@"b ::= a\n"];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"b"];
  NSString * expected = @"bar";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testAliasWithArgs {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"a(x,y) ::= \"<x><y>\"\n" stringByAppendingString:@"b ::= a\n"];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"b"];
  [st add:@"x" arg1:1];
  [st add:@"y" arg1:2];
  NSString * expected = @"12";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testSimpleDefaultArg {
  NSString * dir = [self randomDir];
  NSString * a = @"a() ::= << <b()> >>\n";
  NSString * b = @"b(x=\"foo\") ::= \"<x>\"\n";
  [self writeFile:dir arg1:@"a.st" arg2:a];
  [self writeFile:dir arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st = [group getInstanceOf:@"a"];
  NSString * expected = @" foo ";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testDefaultArgument {
  NSString * templates = [[[[@"method(name) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"<stat(name)>"] + newline stringByAppendingString:@">>"] + newline stringByAppendingString:@"stat(name,value=\"99\") ::= \"x=<value>; // <name>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * b = [group getInstanceOf:@"method"];
  [b add:@"name" arg1:@"foo"];
  NSString * expecting = @"x=99; // foo";
  NSString * result = [b render];
  [self assertEquals:expecting arg1:result];
}

- (void) testBooleanDefaultArguments {
  NSString * templates = [[[[@"method(name) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"<stat(name)>"] + newline stringByAppendingString:@">>"] + newline stringByAppendingString:@"stat(name,x=true,y=false) ::= \"<name>; <x> <y>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * b = [group getInstanceOf:@"method"];
  [b add:@"name" arg1:@"foo"];
  NSString * expecting = @"foo; true false";
  NSString * result = [b render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDefaultArgument2 {
  NSString * templates = [@"stat(name,value=\"99\") ::= \"x=<value>; // <name>\"" stringByAppendingString:newline];
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * b = [group getInstanceOf:@"stat"];
  [b add:@"name" arg1:@"foo"];
  NSString * expecting = @"x=99; // foo";
  NSString * result = [b render];
  [self assertEquals:expecting arg1:result];
}

- (void) testSubtemplateAsDefaultArgSeesOtherArgs {
  NSString * templates = [[[@"t(x,y={<x:{s|<s><z>}>},z=\"foo\") ::= <<\n" stringByAppendingString:@"x: <x>\n"] stringByAppendingString:@"y: <y>\n"] stringByAppendingString:@">>"] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * b = [group getInstanceOf:@"t"];
  [b add:@"x" arg1:@"a"];
  NSString * expecting = [[@"x: a" stringByAppendingString:newline] stringByAppendingString:@"y: afoo"];
  NSString * result = [b render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDefaultArgumentAsSimpleTemplate {
  NSString * templates = [@"stat(name,value={99}) ::= \"x=<value>; // <name>\"" stringByAppendingString:newline];
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * b = [group getInstanceOf:@"stat"];
  [b add:@"name" arg1:@"foo"];
  NSString * expecting = @"x=99; // foo";
  NSString * result = [b render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDefaultArgumentManuallySet {
  NSString * templates = [[[[@"method(fields) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"<fields:{f | <stat(f)>}>"] + newline stringByAppendingString:@">>"] + newline stringByAppendingString:@"stat(f,value={<f.name>}) ::= \"x=<value>; // <f.name>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * m = [group getInstanceOf:@"method"];
  [m add:@"fields" arg1:[[[Field alloc] init] autorelease]];
  NSString * expecting = @"x=parrt; // parrt";
  NSString * result = [m render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDefaultArgumentSeesVarFromDynamicScoping {
  NSString * templates = [[[[@"method(fields) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"<fields:{f | <stat()>}>"] + newline stringByAppendingString:@">>"] + newline stringByAppendingString:@"stat(value={<f.name>}) ::= \"x=<value>; // <f.name>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * m = [group getInstanceOf:@"method"];
  [m add:@"fields" arg1:[[[Field alloc] init] autorelease]];
  NSString * expecting = @"x=parrt; // parrt";
  NSString * result = [m render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDefaultArgumentImplicitlySet2 {
  NSString * templates = [[[[@"method(fields) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"<fields:{f | <f:stat()>}>"] + newline stringByAppendingString:@">>"] + newline stringByAppendingString:@"stat(f,value={<f.name>}) ::= \"x=<value>; // <f.name>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * m = [group getInstanceOf:@"method"];
  [m add:@"fields" arg1:[[[Field alloc] init] autorelease]];
  NSString * expecting = @"x=parrt; // parrt";
  NSString * result = [m render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDefaultArgumentAsTemplate {
  NSString * templates = [[[[@"method(name,size) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"<stat(name)>"] + newline stringByAppendingString:@">>"] + newline stringByAppendingString:@"stat(name,value={<name>}) ::= \"x=<value>; // <name>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * b = [group getInstanceOf:@"method"];
  [b add:@"name" arg1:@"foo"];
  [b add:@"size" arg1:@"2"];
  NSString * expecting = @"x=foo; // foo";
  NSString * result = [b render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDefaultArgumentAsTemplate2 {
  NSString * templates = [[[[@"method(name,size) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"<stat(name)>"] + newline stringByAppendingString:@">>"] + newline stringByAppendingString:@"stat(name,value={ [<name>] }) ::= \"x=<value>; // <name>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * b = [group getInstanceOf:@"method"];
  [b add:@"name" arg1:@"foo"];
  [b add:@"size" arg1:@"2"];
  NSString * expecting = @"x=[foo] ; // foo";
  NSString * result = [b render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDoNotUseDefaultArgument {
  NSString * templates = [[[[@"method(name) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"<stat(name,\"34\")>"] + newline stringByAppendingString:@">>"] + newline stringByAppendingString:@"stat(name,value=\"99\") ::= \"x=<value>; // <name>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * b = [group getInstanceOf:@"method"];
  [b add:@"name" arg1:@"foo"];
  NSString * expecting = @"x=34; // foo";
  NSString * result = [b render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDefaultArgumentInParensToEvalEarly {
  NSString * templates = [[@"A(x) ::= \"<B()>\"" stringByAppendingString:newline] stringByAppendingString:@"B(y={<(x)>}) ::= \"<y> <x> <x> <y>\""] + newline;
  [self writeFile:tmpdir arg1:@"group.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * a = [group getInstanceOf:@"A"];
  [a add:@"x" arg1:[[[Counter alloc] init] autorelease]];
  NSString * expecting = @"0 1 2 0";
  NSString * result = [a render];
  [self assertEquals:expecting arg1:result];
}

- (void) testTrueFalseArgs {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"f(x,y) ::= \"<x><y>\"\n" stringByAppendingString:@"g() ::= \"<f(true,{a})>\""];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"g"];
  NSString * expected = @"truea";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testNamedArgsInOrder {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"f(x,y) ::= \"<x><y>\"\n" stringByAppendingString:@"g() ::= \"<f(x={a},y={b})>\""];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"g"];
  NSString * expected = @"ab";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testNamedArgsOutOfOrder {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"f(x,y) ::= \"<x><y>\"\n" stringByAppendingString:@"g() ::= \"<f(y={b},x={a})>\""];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"g"];
  NSString * expected = @"ab";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testUnknownNamedArg {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"f(x,y) ::= \"<x><y>\"\n" stringByAppendingString:@"g() ::= \"<f(x={a},z={b})>\""];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ErrorBuffer * errors = [[[ErrorBuffer alloc] init] autorelease];
  [group setListener:errors];
  ST * st = [group getInstanceOf:@"g"];
  [st render];
  NSString * expected = [@"context [g] 1:1 attribute z isn't defined" stringByAppendingString:newline];
  NSString * result = [errors description];
  [self assertEquals:expected arg1:result];
}

- (void) testMissingNamedArg {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"f(x,y) ::= \"<x><y>\"\n" stringByAppendingString:@"g() ::= \"<f(x={a},{b})>\""];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ErrorBuffer * errors = [[[ErrorBuffer alloc] init] autorelease];
  [group setListener:errors];
  [group load];
  NSString * expected = [@"group.stg 2:28: mismatched input '{' expecting ID" stringByAppendingString:newline];
  NSString * result = [errors description];
  [self assertEquals:expected arg1:result];
}

- (void) testNamedArgsNotAllowInIndirectInclude {
  NSString * dir = [self randomDir];
  NSString * groupFile = [@"f(x,y) ::= \"<x><y>\"\n" stringByAppendingString:@"g(name) ::= \"<(name)(x={a},y={b})>\""];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroupFile * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/group.stg"]] autorelease];
  ErrorBuffer * errors = [[[ErrorBuffer alloc] init] autorelease];
  [group setListener:errors];
  [group load];
  NSString * expected = [@"group.stg 2:22: '=' came as a complete surprise to me" stringByAppendingString:newline];
  NSString * result = [errors description];
  [self assertEquals:expected arg1:result];
}

- (void) testCantSeeGroupDirIfGroupFileOfSameName {
  NSString * dir = [self randomDir];
  NSString * a = @"a() ::= <<dir1 a>>\n";
  [self writeFile:dir arg1:@"group/a.st" arg2:a];
  NSString * groupFile = @"b() ::= \"group file b\"\n";
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroup * group1 = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st = [group1 getInstanceOf:@"group/a"];
  [self assertEquals:nil arg1:st];
}

- (void) testFullyQualifiedGetInstanceOf {
  NSString * dir = [self randomDir];
  NSString * a = [[[@"a(x) ::= <<" stringByAppendingString:newline] stringByAppendingString:@"foo"] + newline stringByAppendingString:@">>"] + newline;
  [self writeFile:dir arg1:@"a.st" arg2:a];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st = [group getInstanceOf:@"a"];
  NSString * expected = @"foo";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testFullyQualifiedTemplateRef {
  NSString * dir = [self randomDir];
  NSString * a = @"a() ::= << <subdir/b()> >>\n";
  NSString * b = @"b() ::= <<bar>>\n";
  [self writeFile:[dir stringByAppendingString:@"/subdir"] arg1:@"a.st" arg2:a];
  [self writeFile:[dir stringByAppendingString:@"/subdir"] arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st = [group getInstanceOf:@"subdir/a"];
  NSString * expected = @" bar ";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testFullyQualifiedTemplateRef2 {
  NSString * dir = [self randomDir];
  NSString * a = @"a(x) ::= << <group/b()> >>\n";
  [self writeFile:dir arg1:@"a.st" arg2:a];
  NSString * groupFile = [@"b() ::= \"bar\"\n" stringByAppendingString:@"c() ::= \"<a()>\"\n"];
  [self writeFile:dir arg1:@"group.stg" arg2:groupFile];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  ST * st1 = [group getInstanceOf:@"a"];
  ST * st2 = [group getInstanceOf:@"group/c"];
  NSString * expected = @" bar  bar ";
  NSString * result = [st1 render] + [st2 render];
  [self assertEquals:expected arg1:result];
}

- (void) testUnloadingSimpleGroup {
  NSString * dir = [self randomDir];
  NSString * a = @"a(x) ::= <<foo>>\n";
  NSString * b = @"b() ::= <<bar>>\n";
  [self writeFile:dir arg1:@"a.st" arg2:a];
  [self writeFile:dir arg1:@"b.st" arg2:b];
  STGroup * group = [[[STGroupDir alloc] init:dir] autorelease];
  [group load];
  ST * st = [group getInstanceOf:@"a"];
  int originalHashCode = [System identityHashCode:st];
  [group unload];
  st = [group getInstanceOf:@"a"];
  int newHashCode = [System identityHashCode:st];
  [self assertEquals:originalHashCode == newHashCode arg1:NO];
  NSString * expected = @"foo";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
  st = [group getInstanceOf:@"b"];
  expected = @"bar";
  result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testUnloadingGroupFile {
  NSString * dir = [self randomDir];
  NSString * a = [@"a(x) ::= <<foo>>\n" stringByAppendingString:@"b() ::= <<bar>>\n"];
  [self writeFile:dir arg1:@"a.stg" arg2:a];
  STGroup * group = [[[STGroupFile alloc] init:[dir stringByAppendingString:@"/a.stg"]] autorelease];
  [group load];
  ST * st = [group getInstanceOf:@"a"];
  int originalHashCode = [System identityHashCode:st];
  [group unload];
  st = [group getInstanceOf:@"a"];
  int newHashCode = [System identityHashCode:st];
  [self assertEquals:originalHashCode == newHashCode arg1:NO];
  NSString * expected = @"foo";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
  st = [group getInstanceOf:@"b"];
  expected = @"bar";
  result = [st render];
  [self assertEquals:expected arg1:result];
}

@end
