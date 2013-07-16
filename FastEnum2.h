//
//  FastEnum2.h
//  a_ST4
//
//  Created by Alan Condit on 3/12/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FastEnum2 : NSObject<NSFastEnumeration> {
    NSFastEnumerationState *state;
    std::vector<NSInteger> list;
}

-(id)initWithCapacity:(NSUInteger)numItems;
-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len;

- (BOOL) hasNext;
- (id) nextObject;

@end

