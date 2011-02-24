#import "STDump.h"
#import "ST.h"
#import "CompiledST.h"
#import "Misc.h"

NSInteger compare(NSString *s1, NSString *s2, void *context);

@implementation STDump_Anon1

+ (id) newSTDump_Anon1
{
    return [[STDump_Anon1 alloc] init];
}

- (id) init
{
    if (self = [super init]) {
    }
    return self;
}

- (NSInteger) compare:(NSString *)s1 s2:(NSString *)s2 {
    return [s1 length] - [s2 length];
}

@end

@implementation STDump

@synthesize who;

+ (id) newSTDumpWithWho:(ST *) aWho
{
    return [[STDump alloc] initWithWho:(ST *)aWho];
}

+ (NSString *) description:(ST *)aWho {
    STDump *d = [STDump newSTDumpWithWho:aWho];
    return [d description];
}

- (id) initWithWho:(ST *)aWho {
    if (self = [super init]) {
        who = aWho;
    }
    return self;
}

- (NSString *) description {
    return [self description:0];
}

- (NSString *) description:(NSInteger)n {
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    [buf appendFormat:@"%@:", [self templateDeclaratorString]];
    n++;
    if ([who attributeList] != nil) {
        NSMutableArray * attrNames = [NSMutableArray arrayWithCapacity:16];
        [attrNames addObjectsFromArray:[[who getAttributes] allKeys]];
        [attrNames sortedArrayUsingFunction:compare context:nil];
//        NSString *longestName = [NSMutableDictionary max:attrNames param1:[STDump_Anon1 newSTDump_Anon1]];
        NSString *longestName = [attrNames objectAtIndex:0];
        NSInteger w = [longestName length];

        NSString *fmtStr;
        fmtStr = [NSString stringWithFormat:@"\%-%d$\@= \%\@", w];
        for (id attrName in attrNames) {
            NSString * name = (NSString *)attrName;
            [buf appendString:@"\n"];
            [self indent:buf n:n];
            [buf appendFormat:fmtStr, name];
            id value = [[who getAttributes] objectForKey:name];
            [buf appendString:[self getValueDebugString:value n:n]];
        }
        
    }
    [buf appendString:[Misc newline]];
    n--;
    [self indent:buf n:n];
    [buf appendString:@"]"];
    return [buf description];
}

- (NSString *) getValueDebugString:(id)value n:(NSInteger)n {
    NSMutableString * buf = [NSMutableString stringWithCapacity:16];
    value = [Interpreter convertAnythingIteratableToIterator:value];
    if ([value isKindOfClass:[ST class]]) {
        STDump * d = [[STDump alloc] initWithWho:(ST *)value];
        [buf appendString:[d description:n]];
    }
    else if ([value isKindOfClass:[NSEnumerator class]]) {
        NSEnumerator * it = (NSEnumerator *)[value objectEnumerator];
        NSInteger na = 0;
        id obj;
        
        while (obj = [it nextObject]) {
            NSString * v = [self getValueDebugString:obj n:n];
            if (na > 0)
                [buf appendString:@", "];
            [buf appendString:v];
            na++;
        }
        
    }
    else {
        [buf appendString:value];
    }
    return [buf description];
}

- (NSString *) getTemplateDeclaratorString {
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    [buf appendFormat:@"<%@(", [who getName]];
    if (((CompiledST *)who.impl).formalArguments != nil)
        [buf appendString:[((CompiledST *)who.impl).formalArguments allKeys]];
    [buf appendString:@")@"];
    [buf appendFormat:@"%d", [self hash]];
    [buf appendString:@">"];
    return [buf description];
}

- (void) indent:(NSMutableString *)buf n:(NSInteger)n {
    
    for (NSInteger i = 1; i <= n; i++)
        [buf appendString:@"   "];
    
}

- (void) dealloc {
    [self release];
    [super dealloc];
}

@end

NSInteger compare(NSString *s1, NSString *s2, void *context)
{
    int v1 = [s1 length];
    int v2 = [s2 length];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    return NSOrderedSame;
}


