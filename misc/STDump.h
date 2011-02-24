#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "Interpreter.h"
#import "ST.h"

@interface STDump_Anon1 : NSObject {
}

+ (id) newSTDump_Anon1;
- (id) init;
- (NSInteger) compare:(NSString *)s1 s2:(NSString *)s2;
@end

/**
 * This class dumps out a hierarchy of templates in text form, indented
 * to show the nested relationship.  Usage:
 * 
 * ST st = ...;
 * STDump d = new STDump(st);
 * System.out.println(d.toString());
 */

@interface STDump : NSObject {
  ST *who;
}

@property (retain, getter=getWho, setter=setWho:) ST *who;

+ (id) newSTDumpWithWho:(ST *)aWho;
- (id) initWithWho:(ST *)aWho;
+ (NSString *) description:(ST *)aWho;
- (NSString *) description;
- (NSString *) description:(NSInteger)n;
- (NSString *) getValueDebugString:(id)value n:(NSInteger)n;
- (NSString *) getTemplateDeclaratorString;
- (void) indent:(NSMutableString *)buf n:(NSInteger)n;
@end
