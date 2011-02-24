#import "TestModelAdaptors.h"

@implementation UserAdaptor

- (NSObject *) getProperty:(ST *)self o:(NSObject *)o property:(NSObject *)property propertyName:(NSString *)propertyName {
  if ([propertyName isEqualToString:@"id"])
    return ((User *)o).id;
  if ([propertyName isEqualToString:@"name"])
    return [((User *)o) name];
  @throw [[[STNoSuchPropertyException alloc] init:nil arg1:[@"User." stringByAppendingString:propertyName]] autorelease];
}

@end

@implementation UserAdaptorConst

- (NSObject *) getProperty:(ST *)self o:(NSObject *)o property:(NSObject *)property propertyName:(NSString *)propertyName {
  if ([propertyName isEqualToString:@"id"])
    return @"const id value";
  if ([propertyName isEqualToString:@"name"])
    return @"const name value";
  @throw [[[STNoSuchPropertyException alloc] init:nil arg1:[@"User." stringByAppendingString:propertyName]] autorelease];
}

@end

@implementation SuperUser

@synthesize name;

- (id) init:(int)id name:(NSString *)name {
  if (self = [super init:id arg1:name]) {
    bitmask = 0x8080;
  }
  return self;
}

- (NSString *) name {
  return [@"super " stringByAppendingString:[super name]];
}

@end

@implementation TestModelAdaptors

- (void) testSimpleAdaptor {
  NSString * templates = @"foo(x) ::= \"<x.id>: <x.name>\"\n";
  [self writeFile:tmpdir arg1:@"foo.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/foo.stg"]] autorelease];
  [group registerModelAdaptor:[User class] arg1:[[[UserAdaptor alloc] init] autorelease]];
  ST * st = [group getInstanceOf:@"foo"];
  [st add:@"x" arg1:[[[User alloc] init:100 arg1:@"parrt"] autorelease]];
  NSString * expecting = @"100: parrt";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testAdaptorAndBadProp {
  ErrorBufferAllErrors * errors = [[[ErrorBufferAllErrors alloc] init] autorelease];
  NSString * templates = @"foo(x) ::= \"<x.qqq>\"\n";
  [self writeFile:tmpdir arg1:@"foo.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/foo.stg"]] autorelease];
  [group setListener:errors];
  [group registerModelAdaptor:[User class] arg1:[[[UserAdaptor alloc] init] autorelease]];
  ST * st = [group getInstanceOf:@"foo"];
  [st add:@"x" arg1:[[[User alloc] init:100 arg1:@"parrt"] autorelease]];
  NSString * expecting = @"";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
  STRuntimeMessage * msg = (STRuntimeMessage *)[errors.errors get:0];
  STNoSuchPropertyException * e = (STNoSuchPropertyException *)msg.cause;
  [self assertEquals:@"User.qqq" arg1:e.propertyName];
}

- (void) testAdaptorCoversSubclass {
  NSString * templates = @"foo(x) ::= \"<x.id>: <x.name>\"\n";
  [self writeFile:tmpdir arg1:@"foo.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/foo.stg"]] autorelease];
  [group registerModelAdaptor:[User class] arg1:[[[UserAdaptor alloc] init] autorelease]];
  ST * st = [group getInstanceOf:@"foo"];
  [st add:@"x" arg1:[[[SuperUser alloc] init:100 arg1:@"parrt"] autorelease]];
  NSString * expecting = @"100: super parrt";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testWeCanResetAdaptorCacheInvalidatedUponAdaptorReset {
  NSString * templates = @"foo(x) ::= \"<x.id>: <x.name>\"\n";
  [self writeFile:tmpdir arg1:@"foo.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/foo.stg"]] autorelease];
  [group registerModelAdaptor:[User class] arg1:[[[UserAdaptor alloc] init] autorelease]];
  [group getModelAdaptor:[User class]];
  [group getModelAdaptor:[SuperUser class]];
  [group registerModelAdaptor:[User class] arg1:[[[UserAdaptorConst alloc] init] autorelease]];
  ST * st = [group getInstanceOf:@"foo"];
  [st add:@"x" arg1:[[[User alloc] init:100 arg1:@"parrt"] autorelease]];
  NSString * expecting = @"const id value: const name value";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testSeesMostSpecificAdaptor {
  NSString * templates = @"foo(x) ::= \"<x.id>: <x.name>\"\n";
  [self writeFile:tmpdir arg1:@"foo.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[tmpdir stringByAppendingString:@"/foo.stg"]] autorelease];
  [group registerModelAdaptor:[User class] arg1:[[[UserAdaptor alloc] init] autorelease]];
  [group registerModelAdaptor:[SuperUser class] arg1:[[[UserAdaptorConst alloc] init] autorelease]];
  ST * st = [group getInstanceOf:@"foo"];
  [st add:@"x" arg1:[[[User alloc] init:100 arg1:@"parrt"] autorelease]];
  NSString * expecting = @"100: parrt";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
  [st remove:@"x"];
  [st add:@"x" arg1:[[[SuperUser alloc] init:100 arg1:@"parrt"] autorelease]];
  expecting = @"const id value: const name value";
  result = [st render];
  [self assertEquals:expecting arg1:result];
}

@end
