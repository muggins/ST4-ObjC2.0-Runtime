//
//  BaseTest.h
//  BaseTest
//
//  Created by Alan Condit on 4/3/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

// #define STAssertTrue GHAssertTrue
// #define SenTestCase GHTestCase

#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
// #import <GHUnit/GHTestCase.h>
#import <SenTestingKit/SenTestCase.h>
#import "STGroup.h"
#import "Compiler.h"
#import "Misc.h"
#import "Writer.h"
#import "STException.h"
#import "Assert.h"

extern NSString *const tmpdir;
extern NSString *const newline;

@interface User : NSObject {
    ACNumber *num;
    NSString *name;
    BOOL manager;
    BOOL parkingSpot;
}

@property (retain, getter=getNum, setter=setNum:) ACNumber *num;
@property (retain) NSString *name;
@property (assign) BOOL manager;
@property (assign) BOOL parkingSpot;

+ (id) new;
+ (id) newUser:(NSInteger)aNum name:(NSString *)aName;

- (id) init;
- (id) init:(NSInteger)aNum name:(NSString *)aName;
- (void)dealloc;
- (ACNumber *)getNum;
- (void)setNum:(ACNumber *)aNum;
- (BOOL) hasParkingSpot;
@end

@interface HashableUser : User {
}

- (id) init:(NSInteger)aNum name:(NSString *)name;
- (void)dealloc;
- (NSInteger) hash;
- (BOOL) isEqualTo:(NSObject *)obj;
@end

@interface BaseTest : SenTestCase {
    NSString *randomDir;
    NSString *tmpdir;
    
    /**
     * reset during setUp and set to true if we find a problem
     */
    BOOL lastTestFailed;
    
    /**
     * If error during parser execution, store stderr here; can't return
     * stdout and stderr.  This doesn't trap errors from running antlr.
     */
    NSString *stderrDuringParse;
}

@property (retain) NSString *randomDir;
@property (retain) NSString *tmpdir;

- (void) setUp;
- (void) tearDown;
- (void) dealloc;
- (void) writeFile:(NSString *)dir fileName:(NSString *)fileName content:(NSString *)content;

- (void) checkTokens:(NSString *)template expected:(NSString *)expected;
- (void) checkTokens:(NSString *)template expected:(NSString *)expected delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
- (NSString *)getRandomDir;
- (void) assertEquals:(NSString *)expected result:(NSString *)result;
- (void) assertNotNil:(id)ptr msg:(NSString *)msg;

@end

@interface Strings : NSObject {
    AMutableArray *thisArray;
}

@property (retain) AMutableArray *thisArray;

+ (id) newStringsWithArray:(AMutableArray *)anArray;
- (id) initWithArray:(AMutableArray *)anArray;

- (void)dealloc;
- (void) addObject:(id)anObject;
- (id) objectAtIndex:(NSInteger)idx;
- (NSString *)description;

@end
