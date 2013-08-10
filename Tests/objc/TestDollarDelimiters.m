#import "TestDollarDelimiters.h"
#import "STGroupDir.h"

@implementation TestDollarDelimiters

- (void) test01Attr
{
    NSString *template = @"hi $name$!";
    ST *st = [ST newST:template delimiterStartChar:'$' delimiterStopChar:'$'];
    [st add:@"name" value:@"Ter"];
    NSString *expected = @"hi Ter!";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test02ParallelMap
{
    STGroup *group = [STGroup newSTGroup:'$' delimiterStopChar:'$'];
    [group defineTemplate:@"test" argsS:@"names,phones" template:@"hi $names,phones:{n,p | $n$:$p$;}$"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"names" value:@"Ter"];
    [st add:@"names" value:@"Tom"];
    [st add:@"names" value:@"Sumana"];
    [st add:@"phones" value:@"x5001"];
    [st add:@"phones" value:@"x5002"];
    [st add:@"phones" value:@"x5003"];
    NSString *expected = @"hi Ter:x5001;Tom:x5002;Sumana:x5003;";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test03RefToAnotherTemplateInSameGroup
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a() ::= << $b()$ >>\n";
    NSString *b = @"b() ::= <<bar>>\n";
    [self writeFile:dir fileName:@"a.st" content:a];
    [self writeFile:dir fileName:@"b.st" content:b];
    STGroup *group = [STGroupDir newSTGroupDir:dir delimiterStartChar:'$' delimiterStopChar:'$'];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @" bar ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test04DefaultArgument
{
    NSString *templates = @"method(name) ::= <<\n$stat(name)$\n>>\nstat(name,value=\"99\") ::= \"x=$value$; // $name$\"\n";
    [self writeFile:tmpdir fileName:@"group.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", tmpdir] delimiterStartChar:'$' delimiterStopChar:'$'];
    ST *b = [group getInstanceOf:@"method"];
    [b add:@"name" value:@"foo"];
    NSString *expecting = @"x=99; // foo";
    NSString *result = [b render];
    [self assertEquals:expecting result:result];
}

@end
