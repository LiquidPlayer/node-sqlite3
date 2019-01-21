#import <LiquidCore/LiquidCore.h>
#import "node_sqlite3.h"

@interface SQLite3 : NSObject<LCAddOn>

@end

@implementation SQLite3

- (id) init
{
    self = [super init];
    if (self != nil) {

    }
    return self;
}

- (void) register:(NSString*) module
{
    assert([@"node_sqlite3" isEqualToString:module]);
    register_node_sqlite3();
}

- (void) require:(JSValue*) binding service:(LCMicroService *)service
{
    assert(binding != nil);
    assert([binding isObject]);
}

@end

@interface SQLite3Factory : LCAddOnFactory

@end

@implementation SQLite3Factory

- (id) init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id<LCAddOn>)createInstance
{
    return [[SQLite3 alloc] init];
}

@end

__attribute__((constructor))
static void coreJSRegistration()
{
    [LCAddOnFactory registerAddOnFactory:@"sqlite3" factory:[[SQLite3Factory alloc] init]];
}
