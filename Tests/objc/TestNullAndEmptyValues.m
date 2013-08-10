#import "TestNullAndEmptyValues.h"
#import "StringWriter.h"
#import "AutoIndentWriter.h"

@implementation TestNullAndEmptyValues_Anon1

- (id) init
{
    self=[super initWithLen:8];
    if ( self != nil ) {
        [self put:@"foo" value:nil];
    }
    return self;
}

@end

@implementation TestNullAndEmptyValues

- (void) test01SeparatorWithNullFirstValue
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"name" template:@"hi <name; separator=\", \">!"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:nil];
    [st add:@"name" value:@"Tom"];
    [st add:@"name" value:@"Sumana"];
    NSString *expected = @"hi Tom, Sumana!";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test02TemplateAppliedToNullIsEmpty
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"name" template:@"<name:t()>"];
    [group defineTemplate:@"t" argsS:@"x" template:@"<x>"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:nil];
    NSString *expected = @"";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test03TemplateAppliedToMissingValueIsEmpty
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"name" template:@"<name:t()>"];
    [group defineTemplate:@"t" argsS:@"x" template:@"<x>"];
    ST *st = [group getInstanceOf:@"test"];
    NSString *expected = @"";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test04SeparatorWithNull2ndValue
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"name" template:@"hi <name; separator=\", \">!"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:@"Ter"];
    [st add:@"name" value:nil];
    [st add:@"name" value:@"Sumana"];
    NSString *expected = @"hi Ter, Sumana!";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test05SeparatorWithNullLastValue
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"name" template:@"hi <name; separator=\", \">!"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:@"Ter"];
    [st add:@"name" value:@"Tom"];
    [st add:@"name" value:nil];
    NSString *expected = @"hi Ter, Tom!";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test06SeparatorWithTwoNullValuesInRow
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"name" template:@"hi <name; separator=\", \">!"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:@"Ter"];
    [st add:@"name" value:@"Tom"];
    [st add:@"name" value:nil];
    [st add:@"name" value:nil];
    [st add:@"name" value:@"Sri"];
    NSString *expected = @"hi Ter, Tom, Sri!";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test07TwoNullValues
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"name" template:@"hi <name; null=\"x\">!"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:nil];
    [st add:@"name" value:nil];
    NSString *expected = @"hi xx!";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test08NullListItemNotCountedForIteratorIndex
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"name" template:@"<name:{n | <i>:<n>}>"];
    ST *st = [group getInstanceOf:@"test"];
    [st add:@"name" value:@"Ter"];
    [st add:@"name" value:nil];
    [st add:@"name" value:nil];
    [st add:@"name" value:@"Jesse"];
    NSString *expected = @"1:Ter2:Jesse";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test09SizeZeroButNonNullListGetsNoOutput
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"users" template:@"begin\n<users>\nend\n"];
    ST *t = [group getInstanceOf:@"test"];
    [t add:@"users" value:nil];
    NSString *expected = @"begin\nend";
    NSString *result = [t render];
    [self assertEquals:expected result:result];
}

- (void) test10NullListGetsNoOutput
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"users" template:@"begin\n<users:{u | name: <u>}; separator=\", \">\nend\n"];
    ST *t = [group getInstanceOf:@"test"];
    NSString *expected = @"begin\nend";
    NSString *result = [t render];
    [self assertEquals:expected result:result];
}

- (void) test11EmptyListGetsNoOutput
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"users" template:@"begin\n<users:{u | name: <u>}; separator=\", \">\nend\n"];
    ST *t = [group getInstanceOf:@"test"];
    [t add:@"users" value:[[AMutableArray alloc] init]];
    NSString *expected = @"begin\nend";
    NSString *result = [t render];
    [self assertEquals:expected result:result];
}

- (void) test12MissingDictionaryValue
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"m" template:@"<m.foo>"];
    ST *t = [group getInstanceOf:@"test"];
    [t add:@"m" value:[AMutableDictionary dictionaryWithCapacity:5]];
    NSString *expected = @"";
    NSString *result = [t render];
    [self assertEquals:expected result:result];
}

- (void) test13MissingDictionaryValue2
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"m" template:@"<if(m.foo)>[<m.foo>]<endif>"];
    ST *t = [group getInstanceOf:@"test"];
    [t add:@"m" value:[AMutableDictionary dictionaryWithCapacity:5]];
    NSString *expected = @"";
    NSString *result = [t render];
    [self assertEquals:expected result:result];
}

- (void) test14MissingDictionaryValue3
{
    STGroup *group = [STGroup newSTGroup];
    [group defineTemplate:@"test" argsS:@"m" template:@"<if(m.foo)>[<m.foo>]<endif>"];
    ST *t = [group getInstanceOf:@"test"];
    [t add:@"m" value:[[TestNullAndEmptyValues_Anon1 alloc] init]];
    NSString *expected = @"";
    NSString *result = [t render];
    [self assertEquals:expected result:result];
}

- (void) test15SeparatorEmittedForEmptyIteratorValue
{
    ST *st = [ST newSTWithTemplate:@"<values:{v|<if(v)>x<endif>}; separator=\" \">"];
    [st add:@"values" value:[NSArray arrayWithObjects:[ACNumber numberWithBool:YES], [ACNumber numberWithBool:NO], [ACNumber numberWithBool:YES], nil]];
    StringWriter *sw = [StringWriter newWriter];
    [st write:[AutoIndentWriter newWriter:sw]];
    NSString *result = [sw description];
    NSString *expected = @"x  x";
    [self assertEquals:expected result:result];
}

- (void) test16SeparatorEmittedForEmptyIteratorValue2
{
    ST *st = [ST newSTWithTemplate:@"<values; separator=\" \">"];
    [st add:@"values" value:[NSArray arrayWithObjects:@"x", @"", @"y", nil]];
    StringWriter *sw = [StringWriter newWriter];
    [st write:[AutoIndentWriter newWriter:sw]];
    NSString *result = [sw description];
    NSString *expected = @"x  y";
    [self assertEquals:expected result:result];
}

@end
