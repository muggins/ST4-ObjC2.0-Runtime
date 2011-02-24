
@interface STException : ANTLRRuntimeException {
}
+ (id) newException:(NSString *)aReason;

- (id) init;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo;
@end

@interface STNoSuchMethodException : ANTLRRuntimeException
{
    NSString *methodName;
}

+ (id) newException:(NSString *)aReason;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo;

@end

@interface STNoSuchPropertyException : ANTLRRuntimeException
{
    NSString *propertyName;
}

+ (id) newException:(NSString *)aReason;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo;

@end

@interface FileNotFoundException : ANTLRRuntimeException {
}

+ (id) newException:(NSString *)aReason;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo;

@end

@interface IllegalArgumentException : ANTLRRuntimeException {
}

+ (id) newException:(NSString *)aReason;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo;

@end

@interface IllegalAccessException : ANTLRRuntimeException {
}

+ (id) newException:(NSString *)aReason;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo;

@end

@interface MalformedURLException : ANTLRRuntimeException {
}

+ (id) newException:(NSString *)aReason;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo;

@end

@interface IOException : ANTLRRuntimeException {
}

+ (id) newException:(NSString *)aReason;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason;
- (id) initWithName:(NSString *)aMsg reason:(NSString *)aCause userInfo:(NSDictionary *)userInfo;

@end
