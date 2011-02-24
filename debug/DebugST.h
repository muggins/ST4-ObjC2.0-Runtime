#import "ST.h"
#import "AttributeRenderer.h"
#import "AutoIndentWriter.h"
#import "DateRenderer.h"
#import "Interpreter.h"
#import "ModelAdaptor.h"
#import "NoIndentWriter.h"
#import "NumberRenderer.h"
#import "STErrorListener.h"
#import "STGroup.h"
#import "STGroupDir.h"
#import "STGroupFile.h"
#import "StringRenderer.h"
#import "STWriter.h"
//#import "STViz.h"
#import "ErrorBuffer.h"
#import <Cocoa/Cocoa.h>
#import "ErrorManager.h"
#import "MultiMap.h"
#import "StringWriter.h"
#import "ConstructionEvent.h"

@interface State : NSObject {
    
    /**
     * Track all events that occur during rendering.
     */
    NSMutableArray * interpEvents;
}

@property (retain, getter=interpEvents, setter=setInterpEvents:) NSMutableArray *interpEvents;

- (id) init;
@end

/**
 * To avoid polluting ST instances with debug info when not debugging.
 * Setting debug mode in STGroup makes it create these instead of STs.
 */

@interface DebugST : ST {
    
    /**
     * Record who made us? ConstructionEvent creates Exception to grab stack
     */
    ConstructionEvent *newSTEvent;
    
    /**
     * Track construction-time add attribute "events"; used for ST user-level debugging
     */
    MultiMap *addAttrEvents;
    NSMutableArray *events;
}

@property(retain, getter=getNewSTEvent, setter=setNewSTEvent:) ConstructionEvent *newSTEvent;
@property(retain, getter=getAddAttrEvents, setter=setAddAttrEvents:) MultiMap *addAttrEvents;
@property(retain, getter=getEvents, setter=setEvents:) NSMutableArray *events;

+ (id) newDebugSTWithProto:(ST *)proto;
- (id) init;
- (id) initWithProto:(ST *)proto;
- (void) add:(NSString *)name value:(id)value;
- (NSMutableArray *) inspect;
- (NSMutableArray *) inspect:(NSInteger)lineWidth;
- (NSMutableArray *) inspectLocale:(NSLocale *)locale;
- (NSMutableArray *) inspect:(ErrorManager *)errMgr locale:(NSLocale *)locale lineWidth:(NSInteger)lineWidth;
- (NSMutableArray *) getEvents:(NSInteger)lineWidth;
- (NSMutableArray *) getEventsLocale:(NSLocale *)locale;
- (NSMutableArray *) getEventsLocale:(NSLocale *)locale lineWidth:(NSInteger)lineWidth;
@end
