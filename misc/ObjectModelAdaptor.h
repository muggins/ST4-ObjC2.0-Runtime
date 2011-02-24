//#import "DoubleKeyMap.h"
#import "ModelAdaptor.h"
#import "ST.h"
//#import "Field.h"
//#import "Member.h"
//#import "Method.h"

@class DoubleKeyMap;

typedef enum {
    TP_CHAR,
    TP_SHORT,
    TP_INT,
    TP_LONG,
    TP_FLOAT,
    TP_DOUBLE,
    TP_STRING,
    TP_OBJECT
} typeDefEnum;

@interface Field : NSObject {
    NSString *name;
    NSInteger type;
    NSString *typeName;
    NSString *attr;
    char tChar;
    char pChar;
    id obj;
}

@property (retain, getter=getName, setter=setName:) NSString *name;
@property (assign, getter=getType, setter=setType:) NSInteger type;
@property (retain, getter=getTypeName, setter=setTypeName:) NSString *typeName;
@property (retain, getter=getObj, setter=setObj:) id obj;

+ (id) newField:(NSString *)aName obj:(id)instObj;
- (id) init:(NSString *)aName obj:instObj;
- (Class) getClass;
- (id) getObj;

@end

@interface OBJCMethod : NSObject {
    NSString *name;
    NSString *selString;
    id obj;
}

@property (retain, getter=getName, setter=setName:) NSString *name;
@property (retain, getter=getSelString, setter=setSelString:) NSString *selString;
@property (retain, getter=getObj, setter=setObj:) id obj;

+ (id) newOBJCMethod:(NSString *)methodName obj:(id)anObj sel:(SEL)aSel;
+ (id) newOBJCMethod:(NSString *)methodName obj:(id)anObj selString:(NSString *)aSelString;
- (id) init:(NSString *)methodName obj:(id)anObj selString:(NSString *)aSelString;
- (id) invoke:(id)obj;
- (id) getObj;

@end

@interface ObjectModelAdaptor : NSObject <ModelAdaptor> {
    
    /**
     * Cache exact attribute type and property name reflection Member object
     */
    DoubleKeyMap *classAndPropertyToMemberCache;
}

@property (retain, getter=classAndPropertyToMemberCache, setter=setClassAndPropertyToMemberCache:) DoubleKeyMap *classAndPropertyToMemberCache;

- (id) init;
- (id) getProperty:(ST *)aWho obj:(id)anObj property:(id)aProperty propertyName:(NSString *)aPropertyName;
- (id) throwNoSuchProperty:(NSString *)aPropertyName;
@end
