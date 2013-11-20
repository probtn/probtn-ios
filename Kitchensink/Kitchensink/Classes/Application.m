//----------------------------------------------//

#import "Application.h"

//----------------------------------------------//

#import "TestFlight.h"

//----------------------------------------------//

@interface Application () {
    Window* mWindow;
}

@end

//----------------------------------------------//

@implementation Application

@synthesize window = mWindow;

- (id)init {
    self = [super init];
    if(self != nil) {
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_RELEASE(mWindow);
    FG_SAFE_DEALLOC;
}

- (void)applicationDidFinishLaunching:(UIApplication*)application {
    NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate];
    
    [TestFlight takeOff:@"cd7b14b8-b0d6-40d2-8bc8-b4977df02b92"];
    
    mWindow = FG_SAFE_RETAIN([Window windowWithFrame:[[UIScreen mainScreen] bounds]]);
    if(mWindow != nil) {
        [mWindow makeKeyAndVisible];
    }
    NSLog(@"Launching: %0.2fs", [NSDate timeIntervalSinceReferenceDate] - time);
}

- (void)applicationWillTerminate:(UIApplication*)application {
}

- (void)applicationWillResignActive:(UIApplication*)application {
}

- (void)applicationDidEnterBackground:(UIApplication*)application {
}

- (void)applicationWillEnterForeground:(UIApplication*)application {
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
}

@end

//----------------------------------------------//
