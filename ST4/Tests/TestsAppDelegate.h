//
//  TestsAppDelegate.h
//  Tests
//
//  Created by Alan Condit on 2/23/12.
//  Copyright 2012 Alan's MachineWorks. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TestsAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
