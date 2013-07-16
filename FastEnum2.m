//
//  FastEnum2.m
//  a_ST4
//
//  Created by Alan Condit on 3/12/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

#import "FastEnum2.h"
/*
 * this is the state structure for FastEnumeration
typedef struct {
    unsigned long state;
    id *itemsPtr;
    unsigned long *mutationsPtr;
    unsigned long extra[5];
} NSFastEnumerationState;
*/
@implementation FastEnum2

// Designated initializer for this class.
// Since this is just a sample, we'll generate some random data
// for the enumeration to return later.
-(id)initWithCapacity:(NSUInteger)numItems
{
    if ((self = [super init]) != nil) {
        state = calloc(sizeof(NSFastEnumerationState), 1);
        for(NSInteger i = 0; i < numItems; ++i) {
            list.push_back(random());
        }
    }
    return self;
}

// This is where all the magic happens.
// You have two choices when implementing this method:
// 1) Use the stack based array provided by stackbuf. If you do this, then you must respect the value of 'len'.
// 2) Return your own array of objects. If you do this, return the full length of the array returned until you run out of objects, then return 0. For example, a linked-array implementation may return each array in order until you iterate through all arrays.
// In either case, state->itemsPtr MUST be a valid array (non-nil). This sample takes approach #1, using stackbuf to store results.
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    NSUInteger count = 0;
    // This is the initialization condition, so we'll do one-time setup here.
    // Ensure that you never set state->state back to 0, or use another method to detect initialization
    // (such as using one of the values of state->extra).
    if (state->state == 0) {
        // We are not tracking mutations, so we'll set state->mutationsPtr to point into one of our extra values,
        // since these values are not otherwise used by the protocol.
        // If your class was mutable, you may choose to use an internal variable that is updated when the class is mutated.
        // state->mutationsPtr MUST NOT be NULL.
        state->mutationsPtr = &state->extra[0];
    }
    // Now we provide items, which we track with state->state, and determine if we have finished iterating.
    if(state->state < list.size()) {
        // Set state->itemsPtr to the provided buffer.
        // Alternate implementations may set state->itemsPtr to an internal C array of objects.
        // state->itemsPtr MUST NOT be NULL.
        state->itemsPtr = stackbuf;
        // Fill in the stack array, either until we've provided all items from the list
        // or until we've provided as many items as the stack based buffer will hold.
        while((state->state < list.size()) && (count < len))
        {
            // For this sample, we generate the contents on the fly.
            // A real implementation would likely just be copying objects from internal storage.
            stackbuf[count] = [NSString stringWithFormat:@"Item %i = %i", state->state, list[state->state]];
            state->state++;
            count++;
        }
    }
    else
    {
        // We've already provided all our items, so we signal we are done by returning 0.
        count = 0;
    }
    return count;
}

- (BOOL) hasNext
{
    return (state && state->state > 0);
}

- (id) nextObject
{
    id obj;
    if (state && state->state > 0) {
        obj = list[state->state--];
        if (state->state == 0 ) {
            free(state);
            state = nil;
        }
        return obj;
    }
    else
        return nil;
}

@end

