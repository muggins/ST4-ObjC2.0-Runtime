#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "ST.h"
#import "FormalArgument.h"
#import "CompiledST.h"

@implementation FormalArgument

@synthesize cardinality;
@synthesize name;
@synthesize index;
@synthesize defaultValueToken;
@synthesize compiledDefaultValue;

static NSInteger OPTIONAL = 1;     // a?
static NSInteger REQUIRED = 2;     // a
static NSInteger ZERO_OR_MORE = 4; // a*
static NSInteger ONE_OR_MORE = 8;  // a+
static NSString *suffixes[] = {
    nil,
    @"?",
    @"",
    nil,
    @"*",
    nil,
    nil,
    nil,
    @"+"
};

+ (void) initialize
{
}

+ (NSInteger) OPTIONAL
{
    return OPTIONAL;
}

+ (NSInteger) REQUIRED
{
    return REQUIRED;
}

+ (NSInteger) ZERO_OR_MORE
{
    return ZERO_OR_MORE;
}

+ (NSInteger) ONE_OR_MORE
{
    return ONE_OR_MORE;
}

+ (NSString *) suffixes:(NSInteger)idx
{
    if (idx < 9)
        return suffixes[idx];
    return nil;
}

+ (id) newFormalArgument:(NSString *)aName
{
    return [[FormalArgument alloc] initWithName:aName];
}

+ (id) newFormalArgument:(NSString *)aName token:(ANTLRCommonToken *)aToken
{
    return [[FormalArgument alloc] init:aName token:aToken];
}

- (id) init:(NSString *)aName
{
    if (self = [super init]) {
        name = aName;
        cardinality = REQUIRED;
    }
    return self;
}

- (id) init:(NSString *)aName token:(ANTLRCommonToken *)aToken
{
    if (self = [super init]) {
        name = aName;
        cardinality = REQUIRED;
        defaultValueToken = aToken;
    }
    return self;
}

- (NSInteger) hash {
    return [name hash] + [defaultValueToken hash];
}

- (BOOL) isEqualTo:(NSString *)obj
{
    if (obj == nil || !([obj isKindOfClass:[FormalArgument class]])) {
        return NO;
    }
    FormalArgument *other = (FormalArgument *)obj;
    if (![name isEqualTo:other.name]) {
        return NO;
    }
    return !((defaultValueToken != nil && other.defaultValueToken == nil) || (defaultValueToken == nil && other.defaultValueToken != nil));
}

- (NSString *) description
{
    if (defaultValueToken != nil)
        return [name stringByAppendingFormat:@"=%@", [defaultValueToken getText]];
    return name;
}

- (void) dealloc {
    [name release];
    [defaultValueToken release];
    [compiledDefaultValue release];
    [super dealloc];
}

// getters and setters
- (NSString *)getName
{
    return name;
}

- (void) setName:(NSString *)aName
{
    name = aName;
}

- (NSInteger) getIndex
{
    return index;
}

- (void) setIndex:(NSInteger) idx
{
    index = idx;
}

- (ANTLRCommonToken *)getDefaultValueToken
{
    return defaultValueToken;
}

- (void) setDefaultValueToken:(ANTLRCommonToken *)aToken
{
    defaultValueToken = aToken;
}

- (CompiledST *)getCompiledDefaultValue
{
    return compiledDefaultValue;
}

- (void) setCompiledDefaultValue:(CompiledST *)aVal
{
    compiledDefaultValue = aVal;
}

@end
