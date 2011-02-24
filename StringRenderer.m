#import "StringRenderer.h"

@implementation StringRenderer

- (NSString *) description:(id)obj formatString:(NSString *)formatString locale:(NSLocale *)locale {
    NSString * s = (NSString *)obj;
    if (formatString == nil)
        return s;
    if ([formatString isEqualToString:@"upper"])
        return [s uppercaseString];
    if ([formatString isEqualToString:@"lower"])
        return [s lowercaseString];
    if ([formatString isEqualToString:@"cap"]) {
        //return [Character capitalizedString:[s characterAtIndex:0]] + [s substringFromIndex:1];
        return [s capitalizedString];
    }
    if ([formatString isEqualToString:@"url-encode"]) {
        //return [URLEncoder encode:s ];
        return [s stringByStandardizingPath];
    }
#pragma error to resolve
#ifdef DONTUSEYET
    if ([formatString isEqualToString:@"xml-encode"]) {
        return [self escapeHTML:s];
    }
#endif
    return [NSString stringWithFormat:formatString, s];
}

+ (NSString *) escapeHTML:(NSString *)s {
    if (s == nil) {
        return nil;
    }
    BOOL aboveASCII;
    BOOL control;
    NSInteger len = [s length];
    NSMutableString *buf = [NSMutableString stringWithCapacity:len];
    
    for (NSInteger i = 0; i < len; i++) {
        unichar c = [s characterAtIndex:i];
        
        switch (c) {
            case '&':
                [buf appendString:@"&amp;"];
                break;
            case '<':
                [buf appendString:@"&lt;"];
                break;
            case '>':
                [buf appendString:@"&gt;"];
                break;
            case '\r':
            case '\n':
            case '\t':
                [buf appendFormat:@"%c", c];
                break;
            default:
                control = (c < ' ');
                aboveASCII = (c > 126);
                if (control || aboveASCII) {
                    [buf appendFormat:@"&#%d;", (NSInteger)c];
                }
                else
                    [buf appendFormat:@"%c", c];
        }
    }
    
    return [buf description];
}

@end
