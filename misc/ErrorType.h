
/**
 * All the errors that can happen and how to generate a message
 */

typedef enum {
    NO_SUCH_TEMPLATE,
    CANT_SET_ATTRIBUTE,
    NO_IMPORTED_TEMPLATE,
    NO_SUCH_ATTRIBUTE,
    MISSING_FORMAL_ARGUMENTS,
    NO_SUCH_PROPERTY,
    MAP_ARGUMENT_COUNT_MISMATCH,
    ARGUMENT_COUNT_MISMATCH,
    EXPECTING_STRING,
    SYNTAX_ERROR,
    TEMPLATE_REDEFINITION,
    EMBEDDED_REGION_REDEFINITION,
    REGION_REDEFINITION,
    MAP_REDEFINITION,
    ALIAS_TARGET_UNDEFINED,
    TEMPLATE_REDEFINITION_AS_MAP,
    LEXER_ERROR,
    NO_DEFAULT_VALUE,
    NO_SUCH_FUNCTION,
    NO_SUCH_REGION,
    NO_SUCH_OPTION,
    INVALID_TEMPLATE_NAME,
    ANON_ARGUMENT_MISMATCH,
    INTERNAL_ERROR,
    WRITE_IO_ERROR,
    CANT_LOAD_GROUP_FILE,
    NUM_OF_ERRORENUMS
} ErrorTypeEnum;

// extern static NSString *ErrorType_Data[NUM_OF_ERRORENUMS];

@interface ErrorType : NSObject
{
    NSString *message;
    NSMutableDictionary *msgs;
}

@property (retain, getter=getMessage, setter=setMessage:) NSString *message;

+ (void) initialize;

+ (NSString *) NO_SUCH_TEMPLATE;
+ (NSString *) CANT_SET_ATTRIBUTE;
+ (NSString *) NO_IMPORTED_TEMPLATE;
+ (NSString *) NO_SUCH_ATTRIBUTE;
+ (NSString *) MISSING_FORMAL_ARGUMENTS;
+ (NSString *) NO_SUCH_PROPERTY;
+ (NSString *) MAP_ARGUMENT_COUNT_MISMATCH;
+ (NSString *) ARGUMENT_COUNT_MISMATCH;
+ (NSString *) EXPECTING_STRING;

// COMPILE-TIME SYNTAX/SEMANTIC ERRORS
+ (NSString *) SYNTAX_ERROR;
+ (NSString *) TEMPLATE_REDEFINITION;
+ (NSString *) EMBEDDED_REGION_REDEFINITION;
+ (NSString *) REGION_REDEFINITION;
+ (NSString *) MAP_REDEFINITION;
+ (NSString *) ALIAS_TARGET_UNDEFINED;
+ (NSString *) TEMPLATE_REDEFINITION_AS_MAP;
+ (NSString *) LEXER_ERROR;
+ (NSString *) NO_DEFAULT_VALUE;
+ (NSString *) NO_SUCH_FUNCTION;
+ (NSString *) NO_SUCH_REGION;
+ (NSString *) NO_SUCH_OPTION;
+ (NSString *) INVALID_TEMPLATE_NAME;
+ (NSString *) ANON_ARGUMENT_MISMATCH;
// INTERNAL ERRORS
+ (NSString *) INTERNAL_ERROR;
+ (NSString *) WRITE_IO_ERROR;
+ (NSString *) CANT_LOAD_GROUP_FILE;
+ (NSString *) ErrorNum:(ErrorTypeEnum)anErr;

+ (id) newErrorType;
+ (id) newErrorTypeWithErrNum:(ErrorTypeEnum) msgNum;
+ (id) newErrorTypeWithMsg:(NSString *) aMsg;

- (id) init;
- (id) initWithErrNum:(ErrorTypeEnum) aNum;
- (id) initWithMsg:(NSString *) m;
- (void) dealloc;

- (ErrorTypeEnum) ErrorTypeValueOf:(NSString *)text;
- (NSString *) description;
- (NSString *) description:(ErrorTypeEnum) value;

// getters and setters
- (NSString *) getMessage;
- (void) setMessage:(NSString *)msg;

@end
