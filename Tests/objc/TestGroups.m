#import "TestGroups.h"
#import "STGroupDir.h"
#import "STGroupString.h"
#import "STGroupFile.h"

@implementation Field_anon1
@synthesize name;
@synthesize n;

- (id) init
{
    if ( (self=[super init]) != nil ) {
        name = @"parrt";
        n = 0;
    }
    return self;
}

- (NSString *) getName
{
    return name;
}

- (NSInteger) getN
{
    return n;
}

- (NSString *) description
{
    return @"Field";
}

- (void) dealloc
{
    name = nil;
    // [super dealloc];
}

@end

@implementation Field_anon2
@synthesize name;
@synthesize n;

- (id) init
{
    if ( (self=[super init]) != nil ) {
        name = @"parrt";
        n = 0;
    }
    return self;
}

- (NSString *) description
{
    return @"Field";
}

- (void) dealloc
{
    name = nil;
    // [super dealloc];
}

@end

@implementation Field_anon3
@synthesize name;
@synthesize n;

- (id) init
{
    if ( (self=[super init]) != nil ) {
        name = @"parrt";
        n = 0;
    }
    return self;
}

- (NSString *) description
{
    return @"Field";
}

- (void) dealloc
{
    name  = nil;
    // [super dealloc];
}

@end

@implementation Counter
@synthesize n;

- (id) init
{
    if ( (self=[super init]) != nil ) {
        n = 0;
    }
    return self;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%ld", n++];
}

@end

@implementation TestGroups

- (void) test01SimpleGroup
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<foo>>";
    [self writeFile:dir fileName:@"a.st" content:a];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test02EscapeOneRightAngle
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= << > >>";
    [self writeFile:dir fileName:@"a.st" content:a];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st = [group getInstanceOf:@"a"];
    [st add:@"x" value:@"parrt"];
    NSString *expected = @" > ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test03EscapeRightShift
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= << \\>> >>";
    [self writeFile:dir fileName:@"a.st" content:a];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st = [group getInstanceOf:@"a"];
    [st add:@"x" value:@"parrt"];
    NSString *expected = @" >> ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test04EscapeRightShift2
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= << >\\> >>";
    [self writeFile:dir fileName:@"a.st" content:a];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st = [group getInstanceOf:@"a"];
    [st add:@"x" value:@"parrt"];
    NSString *expected = @" >> ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test05EscapeRightShiftAtRightEdge
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<\\>>>"; // <<\>>>
    [self writeFile:dir fileName:@"a.st" content:a];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st = [group getInstanceOf:@"a"];
    [st add:@"x" value:@"parrt"];
    NSString *expected = @"\\>";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test06EscapeRightShiftAtRightEdge2
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<>\\>>>";
    [self writeFile:dir fileName:@"a.st" content:a];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st = [group getInstanceOf:@"a"];
    [st add:@"x" value:@"parrt"];
    NSString *expected = @">>";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test07SimpleGroupFromString
{
    NSString *g = @"a(x) ::= <<foo>>\nb() ::= <<bar>>\n";
    STGroup *group = [STGroupString newSTGroupString:g];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test08GroupWithTwoTemplates
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<foo>>";
    [self writeFile:dir fileName:@"a.st" content:a];
    NSString *b = @"b() ::= \"bar\"";
    [self writeFile:dir fileName:@"b.st" content:b];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st1 = [group getInstanceOf:@"a"];
    ST *st2 = [group getInstanceOf:@"b"];
    NSString *expected = @"foobar";
    NSString *result = [NSString stringWithFormat:@"%@%@", [st1 render], [st2 render]];
    [self assertEquals:expected result:result];
    return;
}

- (void) test09Subdir
{
    NSString *dir = [self getRandomDir];
    [self writeFile:dir fileName:@"a.st" content:@"a(x) ::= <<foo>>"];
    [self writeFile:[NSString stringWithFormat:@"%@/subdir", dir] fileName:@"b.st" content:@"b() ::= \"bar\""];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st1 = [group getInstanceOf:@"a"];
    NSString *expected = @"foo";
    NSString *result = [st1 render];
    [self assertEquals:expected result:result];
    expected = @"bar";
    ST *st2 = [group getInstanceOf:@"subdir/b"];
    result = [st2 render];
    [self assertEquals:expected result:result];
    ST *st3 = [group getInstanceOf:@"/subdir/b"];
    result = [st3 render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test10SubdirWithSubtemplate
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= \"<x:{y|<y>}>\"";
    [self writeFile:[NSString stringWithFormat:@"%@/subdir", dir] fileName:@"a.st" content:a];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st = [group getInstanceOf:@"/subdir/a"];
    [st.impl dump];
    [st add:@"x" value:[AMutableArray arrayWithObjects:@"a", @"b", nil]];
//    [[st add:@"x" value:@"a"] add:@"x" value:@"b"];
    NSString *expected = @"ab";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test11GroupFileInDir
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<\nfoo\n>>\n";
    [self writeFile:dir fileName:@"a.st" content:a];
    NSString *groupFile = @"b() ::= \"bar\"\nc() ::= \"duh\"\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st1 = [group getInstanceOf:@"a"];
    ST *st2 = [group getInstanceOf:@"group/b"];
    ST *st3 = [group getInstanceOf:@"group/c"];
    NSString *expected = @"foobarduh";
    NSString *result = [NSString stringWithFormat:@"%@%@%@", [st1 render], [st2 render], [st3 render]];
    [self assertEquals:expected result:result];
    return;
}

- (void) test12SubSubdir
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<\nfoo\n>>\n";
    [self writeFile:dir fileName:@"a.st" content:a];
    NSString *b = @"b() ::= \"bar\"\n";
    [self writeFile:[NSString stringWithFormat:@"%@/sub1/sub2", dir] fileName:@"b.st" content:b];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st1 = [group getInstanceOf:@"a"];
    ST *st2 = [group getInstanceOf:@"sub1/sub2/b"];
    NSString *expected = @"foobar";
    NSString *result = [NSString stringWithFormat:@"%@%@", [st1 render], [st2 render]];
    [self assertEquals:expected result:result];
    return;
}

- (void) test13GroupFileInSubDir
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<\nfoo\n>>\n";
    [self writeFile:dir fileName:@"a.st" content:a];
    NSString *groupFile = [@"b() ::= \"bar\"\n" stringByAppendingString:@"c() ::= \"duh\"\n"];
    [self writeFile:[NSString stringWithFormat:@"%@/subdir", dir] fileName:@"group.stg" content:groupFile];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st1 = [group getInstanceOf:@"a"];
    ST *st2 = [group getInstanceOf:@"subdir/group/b"];
    ST *st3 = [group getInstanceOf:@"subdir/group/c"];
    NSString *expected = @"foobarduh";
    NSString *result = [NSString stringWithFormat:@"%@%@%@", [st1 render], [st2 render], [st3 render]];
    [self assertEquals:expected result:result];
    return;
}

- (void) test14DupDef
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"b() ::= \"bar\"\nb() ::= \"duh\"\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    id<STErrorListener>errors = [ErrorBuffer newErrorBuffer];
    STGroupFile *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", dir]];
    [group setListener:errors];
    [group load];
    NSString *expected = @"group.stg 2:0: redefinition of template b\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
    return;
}

- (void) test15Alias
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"a() ::= \"bar\"\nb ::= a\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroupFile *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", dir]];
    ST *st = [group getInstanceOf:@"b"];
    NSString *expected = @"bar";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test16AliasWithArgs
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"a(x,y) ::= \"<x><y>\"\nb ::= a\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroupFile *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", dir]];
    ST *st = [group getInstanceOf:@"b"];
    [st addInt:@"x" value:1];
    [st addInt:@"y" value:2];
    NSString *expected = @"12";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test17SimpleDefaultArg
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a() ::= << <b()> >>\n";
    NSString *b = @"b(x=\"foo\") ::= \"<x>\"\n";
    [self writeFile:dir fileName:@"a.st" content:a];
    [self writeFile:dir fileName:@"b.st" content:b];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    ST *st = [group getInstanceOf:@"a"];
    [st.impl dump];
    NSString *expected = @" foo ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test18DefaultArgument
{
    NSString *templates = @"method(name) ::= <<\n<stat(name)>\n>>\nstat(name,value=\"99\") ::= \"x=<value>; // <name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"method"];
    [st add:@"name" value:@"foo"];
    NSString *expected = @"x=99; // foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test19BooleanDefaultArguments
{
    NSString *templates = @"method(name) ::= <<\n<stat(name)>\n>>\nstat(name,x=true,y=false) ::= \"<name>; <x> <y>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"method"];
    [st add:@"name" value:@"foo"];
    [st.impl dump];
    NSString *expected = @"foo; true false";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test20DefaultArgument2
{
    NSString *templates = @"stat(name,value=\"99\") ::= \"x=<value>; // <name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"stat"];
    [st add:@"name" value:@"foo"];
    NSString *expected = @"x=99; // foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test21SubtemplateAsDefaultArgSeesOtherArgs
{
    NSString *templates =@"t(x,y={<x:{s|<s><z>}>},z=\"foo\") ::= <<\nx: <x>\ny: <y>\n>>\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"t"];
    [st add:@"x" value:@"a"];
    NSString *expected = @"x: a\ny: afoo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test22EarlyEvalOfDefaultArgs
{
    NSString *templates = @"s(x,y={<(x)>}) ::= \"<x><y>\"\n"; // should see x in def arg
    STGroup *group = [STGroupString newSTGroupString:templates];
    ST *st = [group getInstanceOf:@"s"];
    [st add:@"x" value:@"a"];
    NSString *expected = @"aa";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test23DefaultArgumentAsSimpleTemplate
{
    NSString *templates = @"stat(name,value={99}) ::= \"x=<value>; // <name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *b = [group getInstanceOf:@"stat"];
    [b add:@"name" value:@"foo"];
    NSString *expected = @"x=99; // foo";
    NSString *result = [b render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test24DefaultArgumentManuallySet
{
    NSString *templates = @"method(fields) ::= <<\n<fields:{f | <stat(f)>}>\n>>\nstat(f,value={<f.name>}) ::= \"x=<value>; // <f.name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"method"];
    [st add:@"fields" value:[[Field_anon1 alloc] init]];
    [st.impl dump];
    NSString *expected = @"x=parrt; // parrt";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test25DefaultArgumentSeesVarFromDynamicScoping
{
    NSString *templates = @"method(fields) ::= <<\n<fields:{f | <stat()>}>\n>>\nstat(value={<f.name>}) ::= \"x=<value>; // <f.name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"method"];
    [st add:@"fields" value:[[Field_anon2 alloc] init]];
    NSString *expected = @"x=parrt; // parrt";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test26DefaultArgumentImplicitlySet2
{
    NSString *templates = @"method(fields) ::= <<\n<fields:{f | <f:stat()>}>\n>>\nstat(f,value={<f.name>}) ::= \"x=<value>; // <f.name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"method"];
    [st add:@"fields" value:[[Field_anon3 alloc] init]];
    NSString *expected = @"x=parrt; // parrt";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test27DefaultArgumentAsTemplate
{
    NSString *templates = @"method(name,size) ::= <<\n<stat(name)>\n>>\nstat(name,value={<name>}) ::= \"x=<value>; // <name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"method"];
    [st add:@"name" value:@"foo"];
    [st add:@"size" value:@"2"];
    NSString *expected = @"x=foo; // foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test28DefaultArgumentAsTemplate2
{
    NSString *templates = @"method(name,size) ::= <<\n<stat(name)>\n>>\nstat(name,value={ [<name>] }) ::= \"x=<value>; // <name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"method"];
    [st add:@"name" value:@"foo"];
    [st add:@"size" value:@"2"];
    NSString *expected = @"x=[foo] ; // foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test29DoNotUseDefaultArgument
{
    NSString *templates = @"method(name) ::= <<\n<stat(name,\"34\")>\n>>\nstat(name,value=\"99\") ::= \"x=<value>; // <name>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"method"];
    [st add:@"name" value:@"foo"];
    NSString *expected = @"x=34; // foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test30DefaultArgumentInParensToEvalEarly
{
    NSString *templates = @"A(x) ::= \"<B()>\"\nB(y={<(x)>}) ::= \"<y> <x> <x> <y>\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"A"];
    [st add:@"x" value:[[Counter alloc] init]];
    NSString *expected = @"0 1 2 0";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test31TrueFalseArgs
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"f(x,y) ::= \"<x><y>\"\ng() ::= \"<f(true,{a})>\"";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroupFile *group = [STGroupFile newSTGroupFile:[dir stringByAppendingString:@"/group.stg"]];
    ST *st = [group getInstanceOf:@"g"];
    NSString *expected = @"truea";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test32NamedArgsInOrder
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"f(x,y) ::= \"<x><y>\"\ng() ::= \"<f(x={a},y={b})>\"";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroupFile *group = [STGroupFile newSTGroupFile:[dir stringByAppendingString:@"/group.stg"]];
    ST *st = [group getInstanceOf:@"g"];
    NSString *expected = @"ab";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test33NamedArgsOutOfOrder
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"f(x,y) ::= \"<x><y>\"\ng() ::= \"<f(y={b},x={a})>\"";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroupFile *group = [STGroupFile newSTGroupFile:[dir stringByAppendingString:@"/group.stg"]];
    ST *st = [group getInstanceOf:@"g"];
    NSString *expected = @"ab";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test34UnknownNamedArg
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"f(x,y) ::= \"<x><y>\"\ng() ::= \"<f(x={a},z={b})>\"";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroupFile *group = [STGroupFile newSTGroupFile:[dir stringByAppendingString:@"/group.stg"]];
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"g"];
    [st render];
    NSString *expected = @"context [/g] 1:1 attribute z isn't defined\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
    return;
}

- (void) test35MissingNamedArg
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"f(x,y) ::= \"<x><y>\"\ng() ::= \"<f(x={a},{b})>\"";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroupFile *group = [STGroupFile newSTGroupFile:[dir stringByAppendingString:@"/group.stg"]];
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [group setListener:errors];
    [group load];
    NSString *expected = @"group.stg 2:18: mismatched input '{' expecting ELLIPSIS\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
    return;
}

- (void) test36NamedArgsNotAllowInIndirectInclude
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"f(x,y) ::= \"<x><y>\"\ng(name) ::= \"<(name)(x={a},y={b})>\"";
                          //01234567890 1234567 8 9012345678901 2345678901234567890123 4
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroupFile *group = [STGroupFile newSTGroupFile:[dir stringByAppendingString:@"/group.stg"]];
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [group setListener:errors];
    [group load];
    NSString *expected = @"group.stg 2:22: '=' came as a complete surprise to me\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
    return;
}

- (void) test37CantSeeGroupDirIfGroupFileOfSameName
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a() ::= <<dir1 a>>\n";
    [self writeFile:dir fileName:@"group/a.st" content:a];
    NSString *groupFile = @"b() ::= \"group file b\"\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroup *group1 = [STGroupDir newSTGroupDir:dir];
    ST *st = [group1 getInstanceOf:@"group/a"];
    STAssertTrue( (st == nil), @"Expected nil BUT GOT \"%@\"", [st description] );
    return;
}

- (void) test38UnloadingSimpleGroup
{
    NSLog( @"test%@UnloadingSimpleGroup", [ACNumber numberWithInteger:33] );
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<foo>>\n";
    NSString *b = @"b() ::= <<bar>>\n";
    [self writeFile:dir fileName:@"a.st" content:a];
    [self writeFile:dir fileName:@"b.st" content:b];
    STGroup *group = [STGroupDir newSTGroupDir:dir];
    [group load];
    ST *st = [group getInstanceOf:@"a"];
    NSUInteger originalHashCode = [st hash];
    [group unload];
    st = [group getInstanceOf:@"a"];
    NSUInteger newHashCode = [st hash];
    //    STAssertTrue( (originalHashCode == newHashCode), @"Expected \"YES\" BUT GOT \"NO\"" );
    NSString *expected = @"foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    st = [group getInstanceOf:@"b"];
    expected = @"bar";
    result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test39UnloadingGroupFile
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a(x) ::= <<foo>>\nb() ::= <<bar>>\n";
    [self writeFile:dir fileName:@"a.stg" content:a];
    STGroup *group = [STGroupFile newSTGroupFile:[dir stringByAppendingString:@"/a.stg"]];
    [group load];
    ST *st = [group getInstanceOf:@"a"];
    NSInteger originalHashCode = [st hash];
    [group unload];
    st = [group getInstanceOf:@"a"];
    NSInteger newHashCode = [st hash];
    //STAssertTrue( (originalHashCode == newHashCode), @"Expected \"YES\" BUT GOT \"NO\"" );
    NSString *expected = @"foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    st = [group getInstanceOf:@"b"];
    expected = @"bar";
    result = [st render];
    [self assertEquals:expected result:result];
    return;
}

- (void) test40GroupFileImport
{
    // /randomdir/group1.stg (a template) and /randomdir/group2.stg with b.
    // group1 imports group2, a includes b
    NSString *dir = [self getRandomDir];
    NSString *groupFile1 = @"import \"group2.stg\"\na(x) ::= <<\nfoo<b()>\n>>\n";
    [self writeFile:dir fileName:@"group1.stg" content:groupFile1];
    NSString *groupFile2 = @"b() ::= \"bar\"\n";
    [self writeFile:dir fileName:@"group2.stg" content:groupFile2];
    STGroup *group1 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group1.stg", dir]];
    
    // Is the imported template b found?
    ST *stb = [group1 getInstanceOf:@"b"];
    NSString *expected = @"bar";
    NSString *result = [stb render];
    [self assertEquals:expected result:result];
    
    // Is the include of b() resolved?
    ST *sta = [group1 getInstanceOf:@"a"];
    expected = @"foobar";
    result = [sta render];
    [self assertEquals:expected result:result];
    
    // Are the correct "ThatCreatedThisInstance" groups assigned
    expected = @"group1";
    result = [[sta groupThatCreatedThisInstance] getName];
    [self assertEquals:expected result:result];
    result = [[stb groupThatCreatedThisInstance] getName];
    [self assertEquals:expected result:result];
    
    // Are the correct (native) groups assigned for the templates
    expected = @"group1";
    result = [sta.impl.nativeGroup getName];
    [self assertEquals:expected result:result];
    expected = @"group2";
    result = [stb.impl.nativeGroup getName];
    [self assertEquals:expected result:result];
}

- (void) test41GetTemplateNames
{
    NSString *templates = @"t() ::= \"foo\"\nmain() ::= \"<t()>\"";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    // try to get an undefined template.
    // This will add an entry to the "templates" field in STGroup, however
    // this should not be returned.
    [group lookupTemplate:@"t2"];
    
    AMutableArray *names = [group getTemplateNames];
    
    // Should only contain "t" and "main" (not "t2")
    NSString *expected = @"2";
    NSString *result = [NSString stringWithFormat:@"%ld", [names count]];
    [self assertEquals:expected result:result];
    STAssertTrue( [names containsObject:@"/t"], @"Expected \"YES\" BUT GOT \"NO\"" );
    STAssertTrue( [names containsObject:@"/main"], @"Expected \"YES\" BUT GOT \"NO\"" );
}

- (void) test42UnloadWithImports
{
    [self writeFile:tmpdir fileName:@"t.stg" content:@"import \"g1.stg\"\n\nmain() ::= <<\nv1-<f()>\n>>"];
    [self writeFile:tmpdir fileName:@"g1.stg" content:@"f() ::= \"g1\""];
    [self writeFile:tmpdir fileName:@"g2.stg" content:@"f() ::= \"g2\"\nf2() ::= \"f2\"\n"];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    ST *st = [group getInstanceOf:@"main"];
    NSString *expected = @"v1-g1";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    
    // Change the text of group t, including the imports.
    [self writeFile:tmpdir fileName:@"t.stg" content:@"import \"g2.stg\"\n\nmain() ::= <<\nv2-<f()>;<f2()>\n>>"];
    [group unload];
    st = [group getInstanceOf:@"main"];
    expected = @"v2-g2;f2";
    result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test43LineBreakInGroup
{
    NSString *templates = @"t() ::= <<\nFoo <\\\\>\n  \t  bar\n>>";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@%ct.stg", tmpdir, '/' /* File.separatorChar */]];
    ST *st = [group getInstanceOf:@"t"];
    [self assertNotNil:st msg:@"st"];
    NSString *expected = @"Foo bar";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test44LineBreakInGroup2
{
    NSString *templates = @"t() ::= <<\nFoo <\\\\>       \n  \t  bar\n>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@%ct.stg", tmpdir, '/' /* File.separatorChar */]];
    ST *st = [group getInstanceOf:@"t"];
    [self assertNotNil:st msg:@"st"];
    NSString *expected = @"Foo bar";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test45LineBreakMissingTrailingNewline
{
    NSString *templates = @"a(x) ::= <<<\\\\>\r\n>>"; // that is <<<\\>>> not an escaped >>
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"t.stg 1:15: Missing newline after newline escape <\\\\>\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
    [st add:@"x" value:@"parrt"];
    expected = @"";
    st = [group getInstanceOf:@"t"];
    result = (st==nil?@"":[st render]);
    [self assertEquals:expected result:result];
}

- (void) test46LineBreakWithScarfedTrailingNewline
{
    NSString *templates = @"a(x) ::= <<<\\\\>\r\n>>"; // \r\n removed as trailing whitespace
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"t.stg 1:15: Missing newline after newline escape <\\\\>\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
    [st add:@"x" value:@"parrt"];
    expected = @"";
    result = (st==nil?@"":[st render]);
    [self assertEquals:expected result:result];
}

@end
