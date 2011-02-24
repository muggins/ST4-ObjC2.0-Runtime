#import <Cocoa/Cocoa.h>
#import "ErrorType.h"

@implementation ErrorType

static NSString *ErrorType_Data[NUM_OF_ERRORENUMS] = {
@"no such template: %s",
@"can't set attribute %s; template %s has no such attribute",
@"no such template: super.%s",
@"attribute %s isn't defined",
@"missing argument definitions",
@"no such property or can't access: %s",
@"iterating through %s values in zip map but template has %s declared arguments",
@"passed %s arg(s) to template %s with %s declared arg(s)",
@"function %s expects a string not %s",
@"%s",
@"redefinition of template %s",
@"region %s is embedded and thus already implicitly defined",
@"redefinition of region %s",
@"redefinition of dictionary %s",
@"cannot alias %s to undefined template: %s",
@"redefinition of template %s as a map",
@"%s",
@"missing dictionary default value",
@"no such function: %s",
@"template %s doesn't have a region called %s",
@"no such option: %s",
@"invalid template name or path: %s",
@"anonymous template has %s arg(s) but mapped across %s value(s)",
@"%s",
@"error writing output caused by",
@"can't load group file %s" };

+ (void) initialize
{
}

+ (NSString *) NO_SUCH_TEMPLATE
{
//    return @"no such template: %s";
    return ErrorType_Data[NO_SUCH_TEMPLATE];
}

+ (NSString *) CANT_SET_ATTRIBUTE
{
//    return @"can't set attribute %s; template %s has no such attribute";
    return ErrorType_Data[CANT_SET_ATTRIBUTE];
}
+ (NSString *) NO_IMPORTED_TEMPLATE
{
//    return @"no such template: super.%s";
    return ErrorType_Data[NO_IMPORTED_TEMPLATE];
}

+ (NSString *) NO_SUCH_ATTRIBUTE
{
//    return @"attribute %s isn't defined";
    return ErrorType_Data[NO_SUCH_ATTRIBUTE];
}

+ (NSString *) MISSING_FORMAL_ARGUMENTS
{
//    return @"missing argument definitions";
    return ErrorType_Data[MISSING_FORMAL_ARGUMENTS];
}

+ (NSString *) NO_SUCH_PROPERTY
{
//    return @"no such property or can't access: %s";
    return ErrorType_Data[NO_SUCH_PROPERTY];
}

+ (NSString *) MAP_ARGUMENT_COUNT_MISMATCH
{
//    return @"iterating through %s values in zip map but template has %s declared arguments";
    return ErrorType_Data[MAP_ARGUMENT_COUNT_MISMATCH];
}

+ (NSString *) ARGUMENT_COUNT_MISMATCH
{
//    return @"passed %s arg(s) to template %s with %s declared arg(s)";
    return ErrorType_Data[ARGUMENT_COUNT_MISMATCH];
}

+ (NSString *) EXPECTING_STRING
{
//    return @"function %s expects a string not %s";
    return ErrorType_Data[EXPECTING_STRING];
}


// COMPILE-TIME SYNTAX/SEMANTIC ERRORS
+ (NSString *) SYNTAX_ERROR
{
//    return @"%s";
    return ErrorType_Data[SYNTAX_ERROR];
}

+ (NSString *) TEMPLATE_REDEFINITION
{
//    return @"redefinition of template %s";
    return ErrorType_Data[TEMPLATE_REDEFINITION];
}

+ (NSString *) EMBEDDED_REGION_REDEFINITION
{
    //    return @"region %s is embedded and thus already implicitly defined";
    return ErrorType_Data[EMBEDDED_REGION_REDEFINITION];
}

+ (NSString *) REGION_REDEFINITION
{
    //    return @"redefinition of region %s";
    return ErrorType_Data[REGION_REDEFINITION];
}

+ (NSString *) MAP_REDEFINITION
{
    //    return @"redefinition of dictionary %s";
    return ErrorType_Data[MAP_REDEFINITION];
}

+ (NSString *) ALIAS_TARGET_UNDEFINED
{
    //    return @"cannot alias %s to undefined template: %s";
    return ErrorType_Data[ALIAS_TARGET_UNDEFINED];
}

+ (NSString *) TEMPLATE_REDEFINITION_AS_MAP
{
    //    return @"redefinition of template %s as a map";
    return ErrorType_Data[TEMPLATE_REDEFINITION_AS_MAP];
}

+ (NSString *) LEXER_ERROR
{
    //    return @"%s";
    return ErrorType_Data[LEXER_ERROR];
}

+ (NSString *) NO_DEFAULT_VALUE
{
    //    return @"missing dictionary default value";
    return ErrorType_Data[NO_DEFAULT_VALUE];
}

+ (NSString *) NO_SUCH_FUNCTION
{
    //    return @"no such function: %s";
    return ErrorType_Data[NO_SUCH_FUNCTION];
}

+ (NSString *) NO_SUCH_REGION
{
    //    return @"template %s doesn't have a region called %s";
    return ErrorType_Data[NO_SUCH_REGION];
}

+ (NSString *) NO_SUCH_OPTION
{
    //    return @"no such option: %s";
    return ErrorType_Data[NO_SUCH_OPTION];
}

+ (NSString *) INVALID_TEMPLATE_NAME
{
    //    return @"invalid template name or path: %s";
    return ErrorType_Data[INVALID_TEMPLATE_NAME];
}

+ (NSString *) ANON_ARGUMENT_MISMATCH
{
    //    return @"anonymous template has %s arg(s) but mapped across %s value(s)";
    return ErrorType_Data[ANON_ARGUMENT_MISMATCH];
}

// INTERNAL ERRORS
+ (NSString *) INTERNAL_ERROR
{
    //    return @"%s";
    return ErrorType_Data[INTERNAL_ERROR];
}

+ (NSString *) WRITE_IO_ERROR
{
    //    return @"error writing output caused by";
    return ErrorType_Data[WRITE_IO_ERROR];
}

+ (NSString *) CANT_LOAD_GROUP_FILE
{
    //    return @"can't load group file %s";
    return ErrorType_Data[SYNTAX_ERROR];
}

+ (NSString *) ErrorNum:(ErrorTypeEnum)anErr
{
    return ErrorType_Data[anErr];
}

+ (id) newErrorType
{
    return [[ErrorType alloc] init];
}

+ (id) newErrorTypeWithErrNum:(ErrorTypeEnum) msgNum
{
    return [[ErrorType alloc] init];
}

+ (id) newErrorTypeWithMsg:(NSString *) aMsg
{
    return [[ErrorType alloc] initWithMsg:aMsg];
}

- (id) init
{
    if (self = [super init] ) {
        message = nil;
        NSInteger idx = 0;
        msgs = [NSMutableDictionary dictionaryWithCapacity:NUM_OF_ERRORENUMS];
        for (idx = 0; idx < NUM_OF_ERRORENUMS; idx++ ) {
            [msgs setObject:ErrorType_Data[idx] forKey:[NSString stringWithFormat:@"%d", idx]];
        }
    }
    return self;
}

- (id) initWithErrNum:(ErrorTypeEnum) aNum
{
    if (self = [super init] ) {
        message = nil;
        NSInteger idx = 0;
        msgs = [NSMutableDictionary dictionaryWithCapacity:NUM_OF_ERRORENUMS];
        for (idx = 0; idx < NUM_OF_ERRORENUMS; idx++ ) {
            [msgs setObject:ErrorType_Data[idx] forKey:[NSString stringWithFormat:@"%d", idx]];
        }
        message = [NSString stringWithString:[msgs objectForKey:[self description:aNum]]];
    }
    return self;
}

- (id) initWithMsg:(NSString *) aMsg
{
    if (self = [super init]) {
        message = aMsg;
        NSInteger idx = 0;
        msgs = [NSMutableDictionary dictionaryWithCapacity:NUM_OF_ERRORENUMS];
        for (idx = 0; idx < NUM_OF_ERRORENUMS; idx++ ) {
            [msgs setObject:ErrorType_Data[idx] forKey:[NSString stringWithString:[self description:idx]]];
        }
    }
    return self;
}

- (ErrorTypeEnum) ErrorTypeValueOf:(NSString *)text
{
    if (text) {
        if ([text isEqualToString:@"NO_SUCH_TEMPLATE"])
            return NO_SUCH_TEMPLATE;
        else if ([text isEqualToString:@"CANT_SET_ATTRIBUTE"])
            return CANT_SET_ATTRIBUTE;
        else if ([text isEqualToString:@"NO_IMPORTED_TEMPLATE"])
            return NO_IMPORTED_TEMPLATE;
        else if ([text isEqualToString:@"NO_SUCH_ATTRIBUTE"])
            return NO_SUCH_ATTRIBUTE;
        else if ([text isEqualToString:@"MISSING_FORMAL_ARGUMENTS"])
            return MISSING_FORMAL_ARGUMENTS;
        else if ([text isEqualToString:@"NO_SUCH_PROPERTY"])
            return NO_SUCH_PROPERTY;
        else if ([text isEqualToString:@"MAP_ARGUMENT_COUNT_MISMATCH"])
            return MAP_ARGUMENT_COUNT_MISMATCH;
        else if ([text isEqualToString:@"ARGUMENT_COUNT_MISMATCH"])
            return ARGUMENT_COUNT_MISMATCH;
        else if ([text isEqualToString:@"EXPECTING_STRING"])
            return EXPECTING_STRING;
        else if ([text isEqualToString:@"SYNTAX_ERROR"])
            return SYNTAX_ERROR;
        else if ([text isEqualToString:@"TEMPLATE_REDEFINITION"])
            return TEMPLATE_REDEFINITION;
        else if ([text isEqualToString:@"EMBEDDED_REGION_REDEFINITION"])
            return EMBEDDED_REGION_REDEFINITION;
        else if ([text isEqualToString:@"REGION_REDEFINITION"])
            return REGION_REDEFINITION;
        else if ([text isEqualToString:@"MAP_REDEFINITION"])
            return MAP_REDEFINITION;
        else if ([text isEqualToString:@"ALIAS_TARGET_UNDEFINED"])
            return ALIAS_TARGET_UNDEFINED;
        else if ([text isEqualToString:@"TEMPLATE_REDEFINITION_AS_MAP"])
            return TEMPLATE_REDEFINITION_AS_MAP;
        else if ([text isEqualToString:@"LEXER_ERROR"])
            return LEXER_ERROR;
        else if ([text isEqualToString:@"NO_DEFAULT_VALUE"])
            return NO_DEFAULT_VALUE;
        else if ([text isEqualToString:@"NO_SUCH_FUNCTION"])
            return NO_SUCH_FUNCTION;
        else if ([text isEqualToString:@"NO_SUCH_REGION"])
            return NO_SUCH_REGION;
        else if ([text isEqualToString:@"NO_SUCH_OPTION"])
            return NO_SUCH_OPTION;
        else if ([text isEqualToString:@"INVALID_TEMPLATE_NAME"])
            return INVALID_TEMPLATE_NAME;
        else if ([text isEqualToString:@"ANON_ARGUMENT_MISMATCH"])
            return ANON_ARGUMENT_MISMATCH;
        else if ([text isEqualToString:@"INTERNAL_ERROR"])
            return INTERNAL_ERROR;
        else if ([text isEqualToString:@"WRITE_IO_ERROR"])
            return WRITE_IO_ERROR;
        else if ([text isEqualToString:@"CANT_LOAD_GROUP_FILE"])
            return CANT_LOAD_GROUP_FILE;
    }
    return -1;
}

- (NSString *) description
{
    return message;
}

- (NSString *) description:(ErrorTypeEnum) value
{
    switch (value) {
        case NO_SUCH_TEMPLATE:
            return @"NO_SUCH_TEMPLATE";
        case CANT_SET_ATTRIBUTE:
            return @"CANT_SET_ATTRIBUTE";
        case NO_IMPORTED_TEMPLATE:
            return @"NO_IMPORTED_TEMPLATE";
        case NO_SUCH_ATTRIBUTE:
            return @"NO_SUCH_ATTRIBUTE";
        case MISSING_FORMAL_ARGUMENTS:
            return @"MISSING_FORMAL_ARGUMENTS";
        case NO_SUCH_PROPERTY:
            return @"NO_SUCH_PROPERTY";
        case MAP_ARGUMENT_COUNT_MISMATCH:
            return @"MAP_ARGUMENT_COUNT_MISMATCH";
        case ARGUMENT_COUNT_MISMATCH:
            return @"ARGUMENT_COUNT_MISMATCH";
        case EXPECTING_STRING:
            return @"EXPECTING_STRING";
        case SYNTAX_ERROR:
            return @"SYNTAX_ERROR";
        case TEMPLATE_REDEFINITION:
            return @"TEMPLATE_REDEFINITION";
        case EMBEDDED_REGION_REDEFINITION:
            return @"EMBEDDED_REGION_REDEFINITION";
        case REGION_REDEFINITION:
            return @"REGION_REDEFINITION";
        case MAP_REDEFINITION:
            return @"MAP_REDEFINITION";
        case ALIAS_TARGET_UNDEFINED:
            return @"ALIAS_TARGET_UNDEFINED";
        case TEMPLATE_REDEFINITION_AS_MAP:
            return @"TEMPLATE_REDEFINITION_AS_MAP";
        case LEXER_ERROR:
            return @"LEXER_ERROR";
        case NO_DEFAULT_VALUE:
            return @"NO_DEFAULT_VALUE";
        case NO_SUCH_FUNCTION:
            return @"NO_SUCH_FUNCTION";
        case NO_SUCH_REGION:
            return @"NO_SUCH_REGION";
        case NO_SUCH_OPTION:
            return @"NO_SUCH_OPTION";
        case INVALID_TEMPLATE_NAME:
            return @"INVALID_TEMPLATE_NAME";
        case ANON_ARGUMENT_MISMATCH:
            return @"ANON_ARGUMENT_MISMATCH";
        case INTERNAL_ERROR:
            return @"INTERNAL_ERROR";
        case WRITE_IO_ERROR:
            return @"WRITE_IO_ERROR";
        case CANT_LOAD_GROUP_FILE:
            return @"CANT_LOAD_GROUP_FILE";
    }
    return nil;
}

// getters and setters
- (NSString *) getMessage
{
    return message;
}

- (void) setMessage:(NSString *)msg
{
    message = msg;
}

- (void) dealloc
{
    [message release];
    [super dealloc];
}

@end

