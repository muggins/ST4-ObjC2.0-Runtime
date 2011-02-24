#import <Cocoa/Cocoa.h>
#import "DateRenderer.h"

@implementation DateRenderer_Anon1

+ (id) newDictionary
{
    return [[DateRenderer_Anon1 alloc] initWithCapacity:15];
}

+ (id) DictionaryWithCapacity:(NSInteger)len
{
    return [[DateRenderer_Anon1 alloc] initWithCapacity:len];
}

- (id) init
{
    if (self = [super initWithCapacity:15]) {
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterShortStyle] forKey:@"short"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterShortStyle] forKey:@"medium"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterMediumStyle] forKey:@"medium"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterLongStyle] forKey:@"long"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterFullStyle] forKey:@"full"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterShortStyle] forKey:@"date:short"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterMediumStyle] forKey:@"date:medium"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterLongStyle] forKey:@"date:long"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterFullStyle] forKey:@"date:full"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterShortStyle] forKey:@"time:short"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterMediumStyle] forKey:@"time:medium"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterLongStyle] forKey:@"time:long"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterFullStyle] forKey:@"time:full"];
    }
    return self;
}

- (id) initWithCapacity:(NSInteger)len
{
    if (self = [super initWithCapacity:len]) {
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterShortStyle] forKey:@"short"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterShortStyle] forKey:@"medium"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterMediumStyle] forKey:@"medium"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterLongStyle] forKey:@"long"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterFullStyle] forKey:@"full"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterShortStyle] forKey:@"date:short"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterMediumStyle] forKey:@"date:medium"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterLongStyle] forKey:@"date:long"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterFullStyle] forKey:@"date:full"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterShortStyle] forKey:@"time:short"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterMediumStyle] forKey:@"time:medium"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterLongStyle] forKey:@"time:long"];
        [self setObject:[NSNumber numberWithInteger:NSDateFormatterFullStyle] forKey:@"time:full"];
    }
    return self;
}

@end

@implementation DateRenderer

static DateRenderer_Anon1 *formatToInt;

+ (id) newDateRenderer
{
    return [[DateRenderer alloc] init];
}

- (id) init
{
    if (self = [super init]) {
        formatToInt = [DateRenderer_Anon1 newDictionary];
    }
    return self;
}

- (NSString *) description:(NSDate *)d formatString:(NSString *)formatString locale:(NSLocale *)locale
{
    NSNumber *style;
    NSInteger styleI;
    NSString *dateStr;
    if (formatString == nil)
        formatString = @"short";
//    if ([obj isMemberOfClass:[NSDate class]])
//        d = [((NSCalendar *)obj) time];
//    else
//        d = (NSDate *)obj;
    style = (NSNumber *)[formatToInt objectForKey:formatString];
    if (style == nil) {
        dateStr = [NSDateFormatter localizedStringFromDate:d dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
    }
    else {
        styleI = [style integerValue];
        if ([formatString hasPrefix:@"date:"]) {
            dateStr = [NSDateFormatter localizedStringFromDate:d dateStyle:styleI timeStyle:NSDateFormatterNoStyle];
        }
        else if ([formatString hasPrefix:@"time:"]) {
            dateStr = [NSDateFormatter localizedStringFromDate:d dateStyle:NSDateFormatterNoStyle timeStyle:styleI];
        }
        else {
            dateStr = [NSDateFormatter localizedStringFromDate:d dateStyle:styleI timeStyle:styleI];
        }
    }
    return dateStr;
}

@end
