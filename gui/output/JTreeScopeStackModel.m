#import "JTreeScopeStackModel.h"

@implementation StringTree

@synthesize nil;

- (id) initWithText:(NSString *)text {
  if (self = [super init]) {
    text = text;
  }
  return self;
}

- (BOOL) nil {
  return text == nil;
}

- (NSString *) description {
  if (![self nil])
    return [text description];
  return @"nil";
}

- (void) dealloc {
  [text release];
  [super dealloc];
}

@end

@implementation JTreeScopeStackModel

@synthesize root;

- (id) initWithScope:(InstanceScope *)scope {
  if (self = [super init]) {
    root = [[[StringTree alloc] init:@"Scope stack:"] autorelease];
    NSMutableArray * stack = [Interpreter getScopeStack:scope param1:YES];

    for (InstanceScope * s in stack) {
      StringTree * templateNode = [[[StringTree alloc] init:[s.st name]] autorelease];
      [root addChild:templateNode];
      [self addAttributeDescriptions:s.st node:templateNode];
    }

  }
  return self;
}

- (void) addAttributeDescriptions:(ST *)st node:(StringTree *)node {
  NSMutableDictionary * attrs = [st attributes];
  if (attrs == nil)
    return;

  for (NSString * a in [attrs allKeys]) {
    NSString * descr = nil;
    if (st.debugState != nil && st.debugState.addAttrEvents != nil) {
      NSMutableArray * events = [st.debugState.addAttrEvents get:a];
      StringBuilder * locations = [[[StringBuilder alloc] init] autorelease];
      int i = 0;
      if (events != nil) {

        for (AddAttributeEvent * ae in events) {
          if (i > 0)
            [locations append:@", "];
          [locations append:[[ae fileName] stringByAppendingString:@":"] + [ae line]];
          i++;
        }

      }
      if ([locations length] > 0) {
        descr = [[a stringByAppendingString:@" = "] + [attrs objectForKey:a] stringByAppendingString:@" @ "] + [locations description];
      }
       else {
        descr = [a stringByAppendingString:@" = "] + [attrs objectForKey:a];
      }
    }
     else {
      descr = [a stringByAppendingString:@" = "] + [attrs objectForKey:a];
    }
    [node addChild:[[[StringTree alloc] init:descr] autorelease]];
  }

}

- (NSObject *) getChild:(NSObject *)parent i:(int)i {
  StringTree * t = (StringTree *)parent;
  return [t getChild:i];
}

- (int) getChildCount:(NSObject *)parent {
  StringTree * t = (StringTree *)parent;
  return [t childCount];
}

- (BOOL) isLeaf:(NSObject *)node {
  return [self getChildCount:node] == 0;
}

- (int) getIndexOfChild:(NSObject *)parent child:(NSObject *)child {
  StringTree * c = (StringTree *)child;
  return [c childIndex];
}

- (void) valueForPathChanged:(TreePath *)treePath o:(NSObject *)o {
}

- (void) addTreeModelListener:(TreeModelListener *)treeModelListener {
}

- (void) removeTreeModelListener:(TreeModelListener *)treeModelListener {
}

- (void) dealloc {
  [root release];
  [super dealloc];
}

@end
