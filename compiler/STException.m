#import <ANTLR/ANTLR.h>
#import "STException.h"

@implementation STException

+ (id) newException:(NSString *)aReason
{
    return [[STException alloc] initWithName:@"ST Exception" reason:aReason userInfo:nil];
}

- (id) init
{
    if (self = [super initWithName:@"ST Exception" reason:nil userInfo:nil]) {
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause
{
    if (self = [super initWithName:aMsg reason:aCause userInfo:nil]) {
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo
{
    if (self = [super initWithName:aMsg reason:aCause userInfo:userInfo]) {
    }
    return self;
}

@end

@implementation STNoSuchMethodException

+ (id) newException:(NSString *)aReason
{
    return [[STNoSuchMethodException alloc] initWithName:@"ST No Such Method Exception" reason:aReason];
}

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason
{
    if (self = [super initWithName:aName reason:aReason userInfo:nil]) {
        methodName = aReason;
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aReason userInfo:(NSDictionary *)userInfo
{
    if (self = [super initWithName:aMsg reason:aReason userInfo:userInfo]) {
        methodName = aReason;
    }
    return self;
}

@end

@implementation STNoSuchPropertyException

+ (id) newException:(NSString *)aReason
{
    return [[STNoSuchPropertyException alloc] initWithName:@"ST No Such Property Exception" reason:aReason];
}

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason
{
    if (self = [super initWithName:aName reason:aReason userInfo:nil]) {
        propertyName = aReason;
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aReason userInfo:(NSDictionary *)userInfo
{
    if (self = [super initWithName:aMsg reason:aReason userInfo:userInfo]) {
        propertyName = aReason;
    }
    return self;
}

@end

@implementation FileNotFoundException

+ (id) newException:(NSString *)aReason
{
    return [[IllegalArgumentException alloc] initWithName:@"File Not Found Exception" reason:aReason userInfo:nil];
}

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason
{
    if (self = [super initWithName:aName reason:aReason userInfo:nil]) {
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo
{
    if (self = [super initWithName:aMsg reason:aCause userInfo:userInfo]) {
    }
    return self;
}

@end

@implementation IllegalArgumentException

+ (id) newException:(NSString *)aReason
{
    return [[IllegalArgumentException alloc] initWithName:@"Illegal Argument Exception" reason:aReason userInfo:nil];
}

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason
{
    if (self = [super initWithName:aName reason:aReason userInfo:nil]) {
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo
{
    if (self = [super initWithName:aMsg reason:aCause userInfo:userInfo]) {
    }
    return self;
}

@end

@implementation IllegalAccessException

+ (id) newException:(NSString *)aReason
{
    return [[IllegalArgumentException alloc] initWithName:@"Illegal Access Exception" reason:aReason userInfo:nil];
}

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason
{
    if (self = [super initWithName:aName reason:aReason userInfo:nil]) {
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo
{
    if (self = [super initWithName:aMsg reason:aCause userInfo:userInfo]) {
    }
    return self;
}

@end

@implementation MalformedURLException

+ (id) newException:(NSString *)aReason
{
    return [[IllegalArgumentException alloc] initWithName:@"Malformed URL Exception" reason:aReason userInfo:nil];
}

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason
{
    if (self = [super initWithName:aName reason:aReason userInfo:nil]) {
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo
{
    if (self = [super initWithName:aMsg reason:aCause userInfo:userInfo]) {
    }
    return self;
}

@end

@implementation IOException

+ (id) newException:(NSString *)aReason
{
    return [[IllegalArgumentException alloc] initWithName:@"IO Exception" reason:aReason userInfo:nil];
}

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason
{
    if (self = [super initWithName:aName reason:aReason userInfo:nil]) {
    }
    return self;
}

- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo
{
    if (self = [super initWithName:aMsg reason:aCause userInfo:userInfo]) {
    }
    return self;
}

@end
