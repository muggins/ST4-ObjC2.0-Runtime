//#import "NSMutableArray.h"

/**
 * Essentially a char filter that knows how to auto-indent output
 * by maintaining a stack of indent levels.
 * 
 * The indent stack is a stack of strings so we can repeat original indent
 * not just the same number of columns (don't have to worry about tabs vs
 * spaces then).
 * 
 * Anchors are char positions (tabs won't work) that indicate where all
 * future wraps should justify to.  The wrap position is actually the
 * larger of either the last anchor or the indentation level.
 * 
 * This is a filter on a Writer.
 * 
 * \n is the proper way to say newline for options and templates.
 * Templates can mix \r\n and \n them but use \n for sure in options like
 * wrap="\n". ST will generate the right thing. Override the default (locale)
 * newline by passing in a string to the constructor.
 */
@class Writer;
#import <ANTLR/ANTLR.h>
@class NSMutableArray;
#import "STWriter.h"

@interface AutoIndentWriter : NSObject<STWriter> {

  /**
   * stack of indents; use List as it's much faster than Stack. Grows
   * from 0..n-1.
 */
  NSMutableArray *indents;

  /**
   * Stack of integer anchors (char positions in line); avoid Integer
   * creation overhead.
 */
  ANTLRIntArray *anchors;
  NSInteger anchors_sp;

  /**
   * \n or \r\n?
 */
  NSString *newline;
  Writer *writer;
  BOOL atStartOfLine;

  /**
   * Track char position in the line (later we can think about tabs).
   * Indexed from 0.  We want to keep charPosition <= lineWidth.
   * This is the position we are *about* to write not the position
   * last written to.
 */
  NSInteger charPosition;

  /**
   * The absolute char index into the output of the next char to be written.
 */
  NSInteger charIndex;
  NSInteger lineWidth;
}

@property (retain, getter=getIndents, setter=setIndents:) NSMutableArray *indents;
@property (retain, getter=getAnchors, setter=setAnchors:) ANTLRIntArray *anchors;
@property (assign, getter=getAnchors_sp, setter=setAnchors_sp:) NSInteger anchors_sp;
@property (retain, getter=getNewline, setter=setNewline:) NSString *newline;
@property (retain, getter=getWriter, setter=setWriter:) Writer *writer;
@property (assign, getter=getAtStartOfLine, setter=setAtStartOfLine:) BOOL atStartOfLine;
@property (assign, getter=getCharPosition, setter=setCharPosition:) NSInteger charPosition;
@property (assign, getter=getCharIndex, setter=setCharIndex:) NSInteger charIndex;
@property (assign, getter=getLineWidth, setter=setLineWidth:) NSInteger lineWidth;

+ (id) newWriter:(Writer *)aWriter;

- (id) initWithWriter:(Writer *)aWriter;
- (id) init:(Writer *)aWriter newline:(NSString *)newline;
- (void) setLineWidth:(NSInteger)lineWidth;
- (void) pushIndentation:(NSString *)indent;
- (NSString *) popIndentation;
- (void) pushAnchorPoint;
- (NSInteger) popAnchorPoint;
- (NSInteger) index;
- (NSInteger) write:(NSString *)str;
- (NSInteger) writeSeparator:(NSString *)str;
- (NSInteger) write:(NSString *)str wrap:(NSString *)wrap;
- (NSInteger) writeWrap:(NSString *)wrap;
- (NSInteger) indent;
@end
