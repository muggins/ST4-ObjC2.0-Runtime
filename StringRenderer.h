#import <Cocoa/Cocoa.h>
#import "AttributeRenderer.h"
//#import "URLEncoder.h"
//#import "Locale.h"

/**
 * This render knows to perform a few operations on String objects:
 * upper, lower, cap, url-encode, xml-encode.
 */

@interface StringRenderer : NSObject<AttributeRenderer> {
}

- (NSString *) description:(id)obj formatString:(NSString *)formatString locale:(NSLocale *)aLocale;
+ (NSString *) escapeHTML:(NSString *)s;
@end
