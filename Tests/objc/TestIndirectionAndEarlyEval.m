#import "TestIndirectionAndEarlyEval.h"

@implementation TestIndirectionAndEarlyEval

- (void) test01EarlyEval
{
    NSString *template = @"<(name)>";
    ST *st = [[ST newSTWithTemplate:template] autorelease];
    [st add:@"name" value:@"Ter"];
    NSString *expected = @"Ter";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test02IndirectTemplateInclude
{
    STGroup *group = [[STGroup newSTGroup] autorelease];
    [group defineTemplate:@"foo" template:@"bar"];
    NSString *template = @"<(name)()>";
    [group defineTemplate:@"test" argsS:@"name" template:template];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:@"foo"];
    NSString *expected = @"bar";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test03IndirectTemplateIncludeWithArgs
{
    STGroup *group = [[STGroup newSTGroup] autorelease];
    [group defineTemplate:@"foo" argsS:@"x,y" template:@"<x><y>"];
    NSString *template = @"<(name)({1},{2})>";
    [group defineTemplate:@"test" argsS:@"name" template:template];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:@"foo"];
    NSString *expected = @"12";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test04IndirectTemplateIncludeViaTemplate
{
    STGroup *group = [[STGroup newSTGroup] autorelease];
    [group defineTemplate:@"foo" template:@"bar"];
    [group defineTemplate:@"tname" template:@"foo"];
    NSString *template = @"<(tname())()>";
    [group defineTemplate:@"test" argsS:@"name" template:template];
    ST *st = [group getInstanceOf:@"test"];
    NSString *expected = @"bar";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test05IndirectProp
{
    NSString *template = @"<u.(propname)>: <u.name>";
    ST *st = [[ST newSTWithTemplate:template] autorelease];
    [st add:@"u" value:[[User newUser:1 name:@"parrt"] autorelease]];
    [st add:@"propname" value:@"num"]; // changed 'id' to 'num' because id reserved word
    NSString *expected = @"1: parrt";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test06IndirectMap
{
    STGroup *group = [[STGroup newSTGroup] autorelease];
    [group defineTemplate:@"a" argsS:@"x" template:@"[<x>]"];
    [group defineTemplate:@"test" argsS:@"names,templateName" template:@"hi <names:(templateName)()>!"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"names" value:@"Ter"];
    [st add:@"names" value:@"Tom"];
    [st add:@"names" value:@"Sumana"];
    [st add:@"templateName" value:@"a"];
    NSString *expected = @"hi [Ter][Tom][Sumana]!";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test07NonStringDictLookup
{
    NSString *template = @"<m.(intkey)>";
    ST *st = [[ST newSTWithTemplate:template] autorelease];
    LinkedHashMap *m = [[LinkedHashMap newLinkedHashMap:3] autorelease];
    [m put:[ACNumber numberWithInteger:36] value:@"foo"];
    [st add:@"m" value:m];
    [st add:@"intkey" value:[ACNumber numberWithInteger:36]];
    NSString *expected = @"foo";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

@end
