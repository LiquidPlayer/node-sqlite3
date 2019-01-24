//
//  node_sqlite3_testTests.m
//  node-sqlite3-testTests
//
//  Created by Eric Lange on 1/24/19.
//  Copyright © 2019 LiquidPlayer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <LiquidCore/LiquidCore.h>

@interface node_sqlite3_testTests : XCTestCase<LCMicroServiceDelegate, LCProcessDelegate>
@property (atomic, assign) int finishCount;
@end

@implementation node_sqlite3_testTests

- (void)testModule {
    _finishCount = 1;
    LCMicroService *service = [[LCMicroService alloc] initWithURL:LCMicroService.devServer delegate:self];
    [service start];
    
    volatile int finishCount = self.finishCount; while (finishCount>0) { finishCount = self.finishCount; }
}

- (void)onStart:(LCMicroService *)service
{
    [service.process addDelegate:self];
}

- (void)onError:(LCMicroService *)service exception:(NSException *)exception
{
    XCTFail(@"%@", exception);
    self.finishCount--;
}

- (void)onProcessStart:(LCProcess *)process context:(JSContext *)context
{
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        XCTFail(@"%@", [exception toString]);
    };
}

- (void)onProcessExit:(LCProcess *)process exitCode:(int)code
{
    self.finishCount--;
}

- (void)onProcessAboutToExit:(LCProcess *)process exitCode:(int)code {}
- (void)onProcessFailed:(LCProcess *)process exception:(NSException *)exception {}

@end
