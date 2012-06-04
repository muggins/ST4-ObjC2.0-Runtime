#import "CommonTree.h"
#import "InstanceScope.h"
#import "Interpreter.h"
#import "ST.h"
#import "AddAttributeEvent.h"
#import "TreeModelListener.h"
#import "TreeModel.h"
#import "TreePath.h"
#import "NSMutableArray.h"
#import "NSMutableDictionary.h"

@interface StringTree : CommonTree {
  NSString * text;
}

@property(nonatomic, readonly) BOOL nil;
- (id) initWithText:(NSString *)text;
- (NSString *) description;
@end

/**
 * From a scope, get stack of enclosing scopes in order from root down
 * to scope.  Then show each scope's (ST's) attributes as children.
 */

@interface JTreeScopeStackModel : NSObject <TreeModel> {
  CommonTree * root;
}

@property(nonatomic, retain, readonly) NSObject * root;
- (id) initWithScope:(InstanceScope *)scope;
- (void) addAttributeDescriptions:(ST *)st node:(StringTree *)node;
- (NSObject *) getChild:(NSObject *)parent i:(int)i;
- (int) getChildCount:(NSObject *)parent;
- (BOOL) isLeaf:(NSObject *)node;
- (int) getIndexOfChild:(NSObject *)parent child:(NSObject *)child;
- (void) valueForPathChanged:(TreePath *)treePath o:(NSObject *)o;
- (void) addTreeModelListener:(TreeModelListener *)treeModelListener;
- (void) removeTreeModelListener:(TreeModelListener *)treeModelListener;
@end
