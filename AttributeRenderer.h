
/**
 * This interface describes an object that knows how to format or otherwise
 * render an object appropriately.  There is one renderer registered per
 * group for a given Java type.
 * 
 * If the format string passed to the renderer is not recognized then simply
 * call toString().
 * 
 * formatString can be null but locale will at least be Locale.getDefault()
 */

@protocol AttributeRenderer <NSObject>
- (NSString *) description:(id)obj formatString:(NSString *)formatString locale:(NSLocale *)locale;
@end
