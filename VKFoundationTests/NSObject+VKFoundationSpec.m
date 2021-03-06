#import "NSObject+VKFoundation.h"

SpecBegin(NSObject_VKFoundation)

describe(@"valueForKeyPathWithNilCheck", ^{
  it(@"should get correct object", ^{
    expect([@{@"aps": @{@"alert": @"pass"} } valueForKeyPathWithNilCheck:@"aps.alert"]).to.equal(@"pass");
    expect([@{@"aps": @{@"alert": @"pass"} } valueForKeyPathWithNilCheck:@"aps.alert.missingKey"]).to.beNil();
  });
});

describe(@"valueForKeyPathWithNilCheck", ^{
  it(@"should return nil if object is NSNull", ^{
    expect([@{@"nullObject":[NSNull null]} valueForKeyPathWithNilCheck:@"nullObject"]).to.beNil();
  });
});

describe(@"valueForKeyPathWithNilCheck", ^{
  it(@"should return nil if object is NSNull", ^{
    expect([@{@"nullObject":[NSNull null]} valueForKeyPathWithNilCheck:@"nullObject"]).to.beNil();
  });
});

describe(@"valueForKeyPath", ^{
  it(@"should return NSNull if object is NSNull", ^{
    expect([@{@"nullObject":[NSNull null]} valueForKeyPath:@"nullObject"]).to.beKindOf([NSNull class]);
  });
});

describe(@"RUN_ON_UI_THREAD", ^{

  it(@"RUN_ON_UI_THREAD should run on main thread", ^AsyncBlock {
    
    __block BOOL runOnBackgroundThread = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
      runOnBackgroundThread = ([NSThread currentThread] != [NSThread mainThread]);
      
      RUN_ON_UI_THREAD(^{
        expect(runOnBackgroundThread).to.equal(YES);
        expect([NSThread currentThread]).to.equal([NSThread mainThread]);
        done();
      });
    });
  });

  it(@"RUN_ON_UI_THREAD should run synchronously if it's doing on main thread", ^ {
    __block BOOL runSynchronously = NO;

    expect([NSThread currentThread]).to.equal([NSThread mainThread]);
    RUN_ON_UI_THREAD(^{
      expect([NSThread currentThread]).to.equal([NSThread mainThread]);
      runSynchronously = YES;
    });
    
    // need to wait for async call
    expect(runSynchronously).after(2).to.equal(YES);
  });

});

SpecEnd
