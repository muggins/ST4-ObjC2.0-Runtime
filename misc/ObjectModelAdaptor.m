#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "ObjectModelAdaptor.h"
#import "Misc.h"
#import "STException.h"

/**
 * Cached exception to reuse since creation is expensive part.
 * Just in case people use "missing" to mean boolean false not error.
 */
STNoSuchPropertyException *cachedException;

@implementation Field

@synthesize name;
@synthesize type;
@synthesize typeName;
@synthesize obj;

+ (id) newField:(NSString *)aName obj:(id)instObj
{
    return [[Field alloc] init:aName obj:instObj];
}

- (id) init:(NSString *)aName obj:instObj
{
    if (self = [super init]) {
        const char *tmp;
        tChar = '\0';
        pChar = '\0';
        name = aName;
        obj = instObj;
        tmp = property_getAttributes(class_getProperty([obj class], [name UTF8String]));
        attr = [NSString stringWithCString:tmp encoding:NSASCIIStringEncoding];
        if ([attr characterAtIndex:0] == 'T') {
            tChar = [attr characterAtIndex:1];
            if (tChar == '^') {
                pChar = '*';
                tChar = [attr characterAtIndex:2];
            }
            switch (tChar) {
                case 'c':
                    typeName = @"char";
                    break;
                case 'd':
                    typeName = @"double";
                    break;
                case 'f':
                    typeName = @"float";
                    break;
                case 'i':
                    typeName = @"int";
                    break;
                case 'l':
                    typeName = @"long";
                    break;
                case 's':
                    typeName = @"short";
                    break;
                case 'u':
                    typeName = @"unsigned";
                    break;
                case 'v':
                    typeName = @"void";
                    break;
                case '{':
                    typeName = @"struct/union";
                    break;
                case '?':
                    typeName = @"pointer to func";
                    break;
                case '@':
                    typeName = @"id";
                    break;
            }
            attr = typeName;
            if ( pChar == '*' ) attr = [NSString stringWithFormat:@"%@ %c", typeName, pChar];
        }
    }
    return self;
}

- (Class) getClass
{
    return [obj class];
}

- (id) getObj
{
    return obj;
}

@end

@implementation OBJCMethod

@synthesize name;
@synthesize selString;
@synthesize obj;

+ (id) newOBJCMethod:(NSString *)methodName obj:(id)anObj selString:(NSString *)aSelString
{
    return [[OBJCMethod alloc] init:methodName obj:(id)anObj selString:aSelString];
}

+ (id) newOBJCMethod:(NSString *)methodName obj:(id)anObj sel:(SEL)aSel
{
    return [[OBJCMethod alloc] init:methodName obj:(id)anObj selString:NSStringFromSelector(aSel)];
}

- (id) init:(NSString *)methodName obj:(id)anObj selString:(NSString *)aSelString
{
    if (self = [super init]) {
        name = methodName;
        selString = aSelString;
        obj = anObj;
    }
    return self;
}

- (Class) getClass
{
    return [obj class];
}

- (id) getObj
{
    return obj;
}

- (id) invoke:(id)anObj
{
    SEL aSEL =  NSSelectorFromString(selString);
    return [obj performSelector:aSEL];
}

@end

@implementation ObjectModelAdaptor

- (id) init
{
    if (self = [super init]) {
        classAndPropertyToMemberCache = [[ANTLRDoubleKeyMap alloc] init];
    }
    return self;
}

- (id) getProperty:(ST *)aWho obj:(id)anObj property:(id)aProperty propertyName:(NSString *)aPropertyName
{
    id value = nil;
    Class c = [anObj class];
    if (aProperty == nil) {
        return [self throwNoSuchProperty:[NSString stringWithFormat:@"%@.%@", [NSString stringWithCString:class_getName(c) encoding:NSASCIIStringEncoding], aPropertyName]];
    }
    id member = [classAndPropertyToMemberCache objectForKey1:c forKey2:aPropertyName];
    if (member != nil) {
        @try {
            if ([member getClass] == [OBJCMethod class])
                return [((OBJCMethod *)member) invoke:anObj];
            if ([member getClass] == [Field class]) {
                return [(Field *)member getObj];
            }
        }
        @catch (NSException * e) {
            [self throwNoSuchProperty:[NSString stringWithFormat:@"%@.%@", [NSString stringWithCString:class_getName(c) encoding:NSASCIIStringEncoding], aPropertyName]];
        }
    }
    NSString *methodSuffix = [[NSString stringWithString:aPropertyName] capitalizedString];
    Method *m = [Misc getMethod:c methodName:[NSString stringWithFormat:@"get%@", methodSuffix]];
    if (m == nil) {
        m = [Misc getMethod:c methodName:[NSString stringWithFormat:@"is%@", methodSuffix]];
        if (m == nil) {
            m = [Misc getMethod:c methodName:[NSString stringWithFormat:@"has%@", methodSuffix]];
        }
    }
    @try {
        if (m != nil) {
            [classAndPropertyToMemberCache setObject:c forKey1:aPropertyName forKey2:m];
            value = [Misc invokeMethod:m obj:anObj value:value];
        }
        else {
            Field *f = [Field newField:aPropertyName obj:anObj];
            [classAndPropertyToMemberCache setObject:c forKey1:aPropertyName forKey2:f];
            
            @try {
                value = [Misc accessField:f obj:anObj value:value];
            }
            @catch (IllegalAccessException *iae) {
                [self throwNoSuchProperty:[NSString stringWithFormat:@"%@.%@", [NSString stringWithCString:class_getName(c) encoding:NSASCIIStringEncoding], aPropertyName]];
            }
        }
    }
    @catch (NSException *e) {
        [self throwNoSuchProperty:[NSString stringWithFormat:@"%@.%@", [NSString stringWithCString:class_getName(c) encoding:NSASCIIStringEncoding], aPropertyName]];
    }
    @finally {
        return value;
    }
    return value;
}

- (id) throwNoSuchProperty:(NSString *)aPropertyName {
    if (cachedException == nil)
        cachedException = [STNoSuchPropertyException newException:aPropertyName];
    @throw cachedException;
}

- (void) dealloc {
    [classAndPropertyToMemberCache release];
    [super dealloc];
}

@end
