//#import "DateFormat.h"
//#import "SimpleDateFormat.h"
#import "AttributeRenderer.h"

@interface DateRenderer_Anon1 : NSMutableDictionary {
}
+ (id) newDictionary;
+ (id) DictionaryWithCapacity:(NSInteger)len;

- (id) init;
- (id) initWithCapacity:(NSInteger)len;
@end

/**
 * A renderer for java.util.Date and Calendar objects. It understands a
 * variety of format names as shown in formatToInt field.  By default
 * it assumes "short" format.  A prefix of date: or time: shows only
 * those components of the time object.
 */

@interface DateRenderer : NSObject <AttributeRenderer> {
}

+ (id) newDateRenderer;

- (id) init;
- (NSString *) description:(id)obj formatString:(NSString *)formatString locale:(NSLocale *)locale;
@end
