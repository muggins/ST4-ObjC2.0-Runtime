//#import "Formatter.h"
//#import "Locale.h"
#import "AttributeRenderer.h"
/**
 * Works with Byte, Short, Integer, Long, and BigInteger as well as
 * Float, Double, and BigDecimal.  You pass in a format string suitable
 * for Formatter object:
 * 
 * http://java.sun.com/j2se/1.5.0/docs/api/java/util/Formatter.html
 * 
 * For example, "%10d" emits a number as a decimal int padding to 10 char.
 * This can even do long to date conversions using the format string.
 */

@interface NumberRenderer : NSObject <AttributeRenderer> {
}

- (NSString *) description:(id)obj formatString:(NSString *)formatString locale:(NSLocale *)locale;
@end
