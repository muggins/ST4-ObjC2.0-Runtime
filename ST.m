#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "Interpreter.h"
#import "ErrorType.h"
#import "FormalArgument.h"
#import "ErrorManager.h"
#import "STException.h"
#import "STWriter.h"
#import "Writer.h"
#import "StringWriter.h"
#import "AutoIndentWriter.h"
#import "AttributeRenderer.h"
#import "ModelAdaptor.h"
#import "STGroup.h"
#import "ST.h"
#import "CompiledST.h"

#ifdef DONTUSENOMO
RegionTypeEnum RegionTypeValueOf(NSString *text)
{
    if (text) {
        if ([text isEqualToString:@"IMPLICIT"])
            return IMPLICIT;
        else if ([text isEqualToString:@"EMBEDDED"])
            return EMBEDDED;
        else if ([text isEqualToString:@"EXPLICIT"])
            return EXPLICIT;
    }
    return -1;
}

(NSString *)RegionTypeDescription(RegionTypeEnum value)
{
    switch (value) {
        case IMPLICIT:
            return @"IMPLICIT";
        case EMBEDDED:
            return @"EMBEDDED";
        case EXPLICIT:
            return @"EXPLICIT";
    }
    return nil;
}
#endif

@implementation AttributeList

+ (id) arrayWithCapacity:(NSInteger)size
{
    return [[AttributeList alloc] initWithCapacity:size];
}

- (id) init
{
    if (self = [super init]) {
    }
    return self;
}

- (id) initWithCapacity:(NSInteger)len
{
    if (self = [super initWithCapacity:len]) {
    }
    return self;
}

@end

/**
 * Cache exception since this could happen a lot if people use "missing"
 * to mean boolean false.
 */
STNoSuchPropertyException *cachedNoSuchPropException;

@implementation ST

static NSInteger NO_WRAP = 80;
static NSString *UNKNOWN_NAME = @"anonymous";
static AttributeList *EMPTY_ATTR;
//static AttributeList *attributeList;

@synthesize RegionType;
@synthesize impl;
@synthesize locals;
@synthesize attributes;
@synthesize enclosingInstance;
@synthesize groupThatCreatedThisInstance;

+ (void) initialize
{
    cachedNoSuchPropException = [STNoSuchPropertyException newException:nil];
    EMPTY_ATTR = [AttributeList arrayWithCapacity:1];
//    UNKNOWN_NAME = @"anonymous";
//    attributeList = [AttributeList arrayWithCapacity:16];
}

+ (NSInteger)NO_WRAP
{
    return NO_WRAP;
}

+ (NSString *)UNKNOWN_NAME
{
    return UNKNOWN_NAME;
}

+ (AttributeList *) EMPTY_ATTR
{
    return EMPTY_ATTR;
}

/*
 + (AttributeList *) attributeList
{
    return attributeList;
}
*/

+ (AttributeList *) convertToAttributeList:(id)curvalue
{
    AttributeList *multi;
    if (curvalue == nil) {
        multi = [AttributeList arrayWithCapacity:16];
        [multi addObject:curvalue];  // what to do with this?
    }
    else if ([curvalue class] == [AttributeList class]) {
        multi = (AttributeList *)curvalue;
    }
    else if ([curvalue isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *listAttr = (NSMutableArray *)curvalue;
        multi = [AttributeList arrayWithCapacity:[listAttr count]];
        [multi addObjectsFromArray:listAttr];
    }
    else if ([curvalue isKindOfClass:[NSArray class]]) {
        NSArray *a = (NSArray *)curvalue;
        multi = [AttributeList arrayWithCapacity:[a count]];
        [multi addObjectsFromArray:a];
    }
    else {
        multi = [AttributeList arrayWithCapacity:16];
        [multi addObject:curvalue];
    }
    return multi;
}

+ (id) newST
{
    return [[ST alloc] init];
}

+ (id) newSTWithTemplate:(NSString *)aTemplate
{
    return [[ST alloc] initWithTemplate:(NSString *)aTemplate];
}

+ (id) newST:(NSString *)aTemplate delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar
{
    return [[ST alloc] init:aTemplate delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
}

+ (id) newST:(STGroup *)aGroup template:(NSString *)aTemplate
{
    return [[ST alloc] init:aGroup template:aTemplate];
}

+ (id) newSTWithProto:(ST *)aProto
{
    return [[ST alloc] initWithProto:(ST *)aProto];
}

+ (NSString *) format:(NSString *)template attributes:(id)attributes
{
    return [self format:(NSInteger)NO_WRAP template:template attributes:attributes];
}

+ (NSString *) format:(NSInteger)lineWidth template:(NSString *)aTemplate attributes:(AttributeList *)theAttributes
{
    NSRange aRange;
    NSInteger idx = 1;

    do {
        aRange = [aTemplate rangeOfString:@"\%([0-9]+)"];
        if (aRange.location != NSNotFound) {
            [aTemplate stringByReplacingCharactersInRange:aRange withString:[NSString stringWithFormat:@"arg%d", idx++]];
        }
    } while (aRange.location != NSNotFound );
    NSLog( @"Template = %@", aTemplate );
    ST *st = [ST newSTWithTemplate:aTemplate];
    NSInteger i = 1;
    
    for (id a in theAttributes) {
        [st add:[NSString stringWithFormat:@"arg%d", i] value:a];
        i++;
    }
    return [st renderWithLineWidth:lineWidth];
}

/**
 * Used by group creation routine, not by users
 */
- (id) init
{
    if (self = [super init]) {
        attributes = [NSMutableDictionary dictionaryWithCapacity:16];
    }
    return self;
}

/**
 * Used to make templates inline in code for simple things like SQL or log records.
 * No formal args are set and there is no enclosing instance.
 */
- (id) initWithTemplate:(NSString *)aTemplate
{
    if (self = [super init]) {
        attributes = [NSMutableDictionary dictionaryWithCapacity:16];
        groupThatCreatedThisInstance = STGroup.defaultGroup;
        impl = [groupThatCreatedThisInstance compile:[groupThatCreatedThisInstance getFileName] name:nil args:nil template:aTemplate templateToken:nil];
        impl.hasFormalArgs = NO;
        impl.name = UNKNOWN_NAME;
        [impl defineImplicitlyDefinedTemplates:groupThatCreatedThisInstance];
    }
    return self;
}

/**
 * Create ST using non-default delimiters; each one of these will live
 * in it's own group since you're overriding a default; don't want to
 * alter STGroup.defaultGroup.
 */
- (id) init:(NSString *)template delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    if (self = [super init]) {
        attributes = [NSMutableDictionary dictionaryWithCapacity:16];
        groupThatCreatedThisInstance = [[STGroup alloc] init:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
        impl = [groupThatCreatedThisInstance compile:[groupThatCreatedThisInstance getFileName] name:nil args:nil template:template templateToken:nil];
        impl.hasFormalArgs = NO;
        impl.name = UNKNOWN_NAME;
        [impl defineImplicitlyDefinedTemplates:groupThatCreatedThisInstance];
    }
    return self;
}

- (id) init:(STGroup *)group template:(NSString *)template
{
    if (self = [super init]) {
        attributes = [NSMutableDictionary dictionaryWithCapacity:16];
        groupThatCreatedThisInstance = group;
        impl = [groupThatCreatedThisInstance compile:[group getFileName] name:nil args:nil template:template templateToken:nil];
        impl.hasFormalArgs = NO;
        impl.name = UNKNOWN_NAME;
        [impl defineImplicitlyDefinedTemplates:groupThatCreatedThisInstance];
    }
    return self;
}

/**
 * Clone a prototype template for application in MAP operations; copy all fields
 */
- (id) initWithProto:(ST *)proto
{
    if (self = [super init]) {
        attributes = [NSMutableDictionary dictionaryWithCapacity:16];
        impl = proto.impl;
        if (proto.locals != nil) {
            locals = [NSMutableArray arrayWithArray:proto.locals];
        }
        enclosingInstance = proto.enclosingInstance;
        groupThatCreatedThisInstance = proto.groupThatCreatedThisInstance;
    }
    return self;
}

/**
 * Inject an attribute (name/value pair). If there is already an
 * attribute with that name, this method turns the attribute into an
 * AttributeList with both the previous and the new attribute as elements.
 * This method will never alter a List that you inject.  If you send
 * in a List and then inject a single value element, add() copies
 * original list and adds the new value.
 */
- (void) add:(NSString *)aName value:(id)value
{
    NSRange aRange;
    if (aName == nil)
        return;
    aRange = [aName rangeOfString:@"."];
    if (aRange.location != NSNotFound) {
        @throw [IllegalArgumentException newException:@"cannot have '.' in attribute names"];
    }
    FormalArgument * arg = nil;
    if (impl.hasFormalArgs) {
        if (impl.formalArguments != nil)
            arg = [impl.formalArguments objectForKey:aName];
        if (arg == nil) {
            @throw [IllegalArgumentException newException:[NSString stringWithFormat:@"no such attribute: %@", aName]];
        }
    }
    else {
        if (impl.formalArguments != nil) {
            arg = [impl.formalArguments objectForKey:aName];
        }
        if (arg == nil) {
            arg = [FormalArgument newFormalArgument:aName];
            [impl addArg:arg];
            if (locals == nil)
                locals = [NSMutableArray array];
            else
                locals = [NSMutableArray arrayWithArray:locals];
            [locals insertObject:EMPTY_ATTR atIndex:arg.index];
        }
    }
    if ([value isMemberOfClass:[ST class]])
        ((ST *)value).enclosingInstance = self;
    id curvalue = [locals objectAtIndex:arg.index];
    if (curvalue == EMPTY_ATTR) {
        [locals insertObject:value atIndex:arg.index];
        return;
    }
    AttributeList *multi = [ST convertToAttributeList:curvalue];
    [locals insertObject:multi atIndex:arg.index];
    if ([value isMemberOfClass:[NSMutableArray class]]) {
        [multi addObjectsFromArray:(NSMutableArray *)value];
    }
    else if (value != nil && [value isMemberOfClass:[NSMutableArray class]]) {
        [multi addObjectsFromArray:(NSMutableArray *)value];
    }
    else {
        [multi addObject:value];
    }
}

/**
 * Remove an attribute value entirely (can't remove attribute definitions).
 */
- (void) remove:(NSString *)name
{
    if (impl.formalArguments == nil) {
        if (impl.hasFormalArgs) {
            @throw [IllegalArgumentException  newException:[NSString stringWithFormat:@"no such attribute: %@", name]];
        }
        return;
    }
    FormalArgument * arg = [impl.formalArguments objectForKey:name];
    if (arg == nil) {
        @throw [IllegalArgumentException newException:[NSString stringWithFormat:@"no such attribute: %@", name]];
    }
    [locals insertObject:EMPTY_ATTR atIndex:arg.index];
}

/**
 * Set this.locals attr value when you only know the name, not the index.
 * This is ultimately invoked by calling ST.add() from outside so toss
 * an exception to notify them.
 */
- (void) rawSetAttribute:(NSString *)name value:(id)value
{
    if (impl.formalArguments == nil) {
        @throw [IllegalArgumentException newException:[NSString stringWithFormat:@"no such attribute: %@", name]];
    }
    FormalArgument *arg = [impl.formalArguments objectForKey:name];
    if (arg == nil) {
        @throw [IllegalArgumentException  newException:[NSString stringWithFormat:@"no such attribute: %@", name]];
    }
    [locals insertObject:value atIndex:arg.index];
}

/**
 * Find an attr via dynamic scoping up enclosing ST chain.
 * If not found, look for a map.    So attributes sent in to a template
 * override dictionary names.
 */
- (id) getAttribute:(NSString *)name
{
    ST *p = self;
    
    while (p != nil) {
        FormalArgument *localArg = nil;
        if (p.impl.formalArguments != nil)
            localArg = [p.impl.formalArguments objectForKey:name];
        if (localArg != nil) {
            id obj = [p.locals objectAtIndex:localArg.index];
            if (obj == EMPTY_ATTR)
                obj = nil;
            return obj;
        }
        p = p.enclosingInstance;
    }
    
    if ([impl.nativeGroup isDictionary:name]) {
        return [impl.nativeGroup rawGetDictionary:name];
    }
    if (cachedNoSuchPropException == nil) {
        cachedNoSuchPropException = [STNoSuchPropertyException newException:name];
    }
//    cachedNoSuchPropException.propertyName = name;
    @throw cachedNoSuchPropException;
}

- (NSMutableDictionary *) getAttributes
{
    if (impl.formalArguments == nil)
        return nil;
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:16];
    
    for (FormalArgument *a in [impl.formalArguments allValues]) {
        id  obj = [locals objectAtIndex:a.index];
        if (obj == EMPTY_ATTR)
            obj = nil;
        [attributes setObject:obj forKey:a.name];
    }
    return attributes;
}

/**
 * If an instance of x is enclosed in a y which is in a z, return
 * a String of these instance names in order from topmost to lowest;
 * here that would be "[z y x]".
 */
- (NSString *) getEnclosingInstanceStackString
{
    NSMutableArray *templates = [self getEnclosingInstanceStack:YES];
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    NSInteger i = 0;
//    NSEnumerator *enumerator;
//    id anObject;

//    enumerator = [templates objectEnumerator];
//    while ( anObject = [enumerator nextObject] ) {
    for (ST *st in templates) {
        if (i > 0)
            [buf appendString:@" "];
        [buf appendString:[st getName]];
        i++;
    }
    
    return [buf description];
}

- (NSMutableArray *) getEnclosingInstanceStack:(BOOL)topdown
{
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:30];
    ST *p = self;
    
    while (p != nil) {
        if (topdown)
            [stack insertObject:p atIndex:0];
        else
            [stack addObject:p];
        p = p.enclosingInstance;
    }
    
    return stack;
}

- (NSString *) getName
{
    return impl.name;
}

- (NSInteger) write:(id<STWriter>)wr1
{
    Interpreter *interp = [[Interpreter alloc] init:groupThatCreatedThisInstance errMgr:impl.nativeGroup.errMgr];
    [interp setDefaultArguments:self];
    return [interp exec:wr1 who:self];
}

- (NSInteger) write:(id<STWriter>)wr1 locale:(NSLocale *)locale
{
    Interpreter *interp = [[Interpreter alloc] init:groupThatCreatedThisInstance locale:locale errMgr:impl.nativeGroup.errMgr];
    [interp setDefaultArguments:self];
    return [interp exec:wr1 who:self];
}

- (NSInteger) write:(id<STWriter>)wr1 listener:(STErrorListener *)listener
{
    Interpreter *interp = [[Interpreter alloc] init:groupThatCreatedThisInstance errMgr:[[ErrorManager alloc] initWithListener:listener]];
    [interp setDefaultArguments:self];
    return [interp exec:wr1 who:self];
}

- (NSInteger) write:(id<STWriter>)wr1 locale:(NSLocale *)locale listener:(STErrorListener *)listener
{
    Interpreter *interp = [[Interpreter alloc] init:groupThatCreatedThisInstance locale:locale errMgr:[[ErrorManager alloc] initWithListener:listener]];
    [interp setDefaultArguments:self];
    return [interp exec:wr1 who:self];
}

- (NSString *) render
{
    return [self render:[NSLocale currentLocale]];
}

- (NSString *) renderWithLineWidth:(NSInteger)lineWidth
{
    return [self render:[NSLocale currentLocale] lineWidth:lineWidth];
}

- (NSString *) render:(NSLocale *)locale
{
    return [self render:locale lineWidth:NO_WRAP];
}

- (NSString *) render:(NSLocale *)locale lineWidth:(NSInteger)lineWidth
{
    StringWriter *wr1 = [StringWriter stringWithCapacity:16];
    AutoIndentWriter *aWriter = [AutoIndentWriter newWriter:wr1];
    [aWriter setLineWidth:lineWidth];
    [self write:(id<STWriter>)aWriter locale:(NSLocale *)locale];
    return [wr1 description];
}

- (NSString *) description
{
    if (impl == nil)
        return @"bad-template()";
    return [impl.name stringByAppendingString:@"()"];
}

- (void) dealloc
{
    [impl release];
    [locals release];
    [enclosingInstance release];
    [groupThatCreatedThisInstance release];
    [super dealloc];
}

- (BOOL) getIsAnonSubtemplate
{
    return [impl getIsAnonSubtemplate];
}

#ifdef DONTUSENOMO
// getters and setters
- (CompiledST *) getImpl
{
    return impl;
}

- (void) setImpl:(CompiledST *)anImpl
{
    impl = anImpl;
}

- (NSArray *) getLocals
{
    return locals;
}

- (void) setLocals:(NSArray *)theLocals
{
    locals = theLocals;
}

//@property(retain, getter=getAttributes, setter=setAttributes:) NSMutableDictionary *attributes;
- (ST *) getEnclosingInstance
{
    return enclosingInstance;
}

- (void) setEnclosingInstance:(ST *)anEnclosingInstance
{
    enclosingInstance = anEnclosingInstance;
}

- (STGroup *) getGroupThatCreatedThisInstance
{
    return groupThatCreatedThisInstance;
}

- (void) setGroupThatCreatedThisInstance:(STGroup *)aGroupThatCreatedThisInstance
{
    groupThatCreatedThisInstance = aGroupThatCreatedThisInstance;
}

- (NSInteger) getNO_WRAP
{
    return NO_WRAP;
}

- (void) setNO_WRAP:(NSInteger)linewidth
{
    NO_WRAP = linewidth;
}

- (NSString *) getUNKNOW_NAME
{
    return UNKNOWN_NAME;
}

- (void) setUNKNOWN_NAME:(NSString *)aName
{
    UNKNOWN_NAME = aName;
}

- (AttributeList *) getEMPTY_ATTR
{
    return EMPTY_ATTR;
}

- (void) setEMPTY_ATTR:(AttributeList *)anAttr
{
    EMPTY_ATTR = anAttr;
}
#endif

@end
