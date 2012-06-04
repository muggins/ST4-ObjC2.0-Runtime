#import "CommonToken.h"
#import "CommonTree.h"
#import "CommonTreeAdaptor.h"
#import "AttributeRenderer.h"
#import "AutoIndentWriter.h"
#import "DateRenderer.h"
#import "InstanceScope.h"
#import "Interpreter.h"
#import "ModelAdaptor.h"
#import "NoIndentWriter.h"
#import "NumberRenderer.h"
#import "ST.h"
#import "STErrorListener.h"
#import "STGroup.h"
#import "STGroupDir.h"
#import "STGroupFile.h"
#import "STGroupString.h"
#import "STRawGroupDir.h"
#import "StringRenderer.h"
#import "STWriter.h"
#import "EvalTemplateEvent.h"
#import "InterpEvent.h"
#import "Aggregate.h"
#import "AggregateModelAdaptor.h"
#import "ArrayIterator.h"
#import "Coordinate.h"
#import "ErrorBuffer.h"
#import "ErrorManager.h"
#import "ErrorType.h"
#import "Interval.h"
#import "MapModelAdaptor.h"
#import "Misc.h"
#import "MultiMap.h"
#import "ObjectModelAdaptor.h"
#import "STCompiletimeMessage.h"
#import "STGroupCompiletimeMessage.h"
#import "STLexerMessage.h"
#import "STMessage.h"
#import "STModelAdaptor.h"
#import "STNoSuchAttributeException.h"
#import "STNoSuchPropertyException.h"
#import "STRuntimeMessage.h"
#import "Border.h"
#import "BadLocationException.h"
#import "DefaultHighlighter.h"
#import "Highlighter.h"
#import "JTextComponent.h"
#import "TreePath.h"
#import "BufferedWriter.h"
#import "File.h"
#import "FileWriter.h"
#import "IOException.h"
#import "NSMutableArray.h"

@interface STViz_Anon1 : NSObject <TreeSelectionListener> {
}

- (void) valueChanged:(TreeSelectionEvent *)treeSelectionEvent;
@end

@interface STViz_Anon2 : NSObject <TreeSelectionListener> {
}

- (void) valueChanged:(TreeSelectionEvent *)treeSelectionEvent;
@end

@interface STViz_Anon3 : NSObject <CaretListener> {
}

- (void) caretUpdate:(CaretEvent *)e;
@end

@interface STViz_Anon4 : NSObject <ListSelectionListener> {
}

- (void) valueChanged:(ListSelectionEvent *)e;
@end

@interface STViz : NSObject {
  EvalTemplateEvent * root;
  InstanceScope * currentScope;
  NSMutableArray * allEvents;
  JTreeSTModel * tmodel;
  ErrorManager * errMgr;
  Interpreter * interp;
  NSString * output;
  NSMutableArray * trace;
  NSMutableArray * errors;
  STViewFrame * viewFrame;
}

- (id) init:(ErrorManager *)errMgr root:(EvalTemplateEvent *)root output:(NSString *)output interp:(Interpreter *)interp trace:(NSMutableArray *)trace errors:(NSMutableArray *)errors;
- (void) open;
- (void) highlight:(JTextComponent *)comp i:(int)i j:(int)j;
- (void) updateAttributes:(InstanceScope *)scope m:(STViewFrame *)m;
- (void) updateStack:(InstanceScope *)scope m:(STViewFrame *)m;
- (InterpEvent *) findEventAtOutputLocation:(NSMutableArray *)events charIndex:(int)charIndex;
+ (void) main:(NSArray *)args;
+ (void) test1;
+ (void) test2;
+ (void) test3;
+ (void) test4;
+ (void) writeFile:(NSString *)dir fileName:(NSString *)fileName content:(NSString *)content;
@end
