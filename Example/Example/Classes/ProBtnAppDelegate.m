//----------------------------------------------//

#import "ProBtnAppDelegate.h"

//----------------------------------------------//

@implementation ProBtnAppDelegate

- (void)dealloc {
    [self setWindow:nil];
}

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    [ProBtn setDelegate:self];
    [ProBtn open];

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAllButUpsideDown];
    } else {
        [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAll];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication*)application {
}

- (void)applicationDidEnterBackground:(UIApplication*)application {
}

- (void)applicationWillEnterForeground:(UIApplication*)application {
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
}

- (void)applicationWillTerminate:(UIApplication*)application {
}

#pragma mark - ProBtnDelegate

- (BOOL)proBtnWillOpen {
    NSLog(@"ProBtn: proBtnWillOpen");
    return YES;
}

- (void)proBtnDidOpen {
    NSLog(@"ProBtn: proBtnDidOpen");
}

- (BOOL)proBtnWillClose {
    NSLog(@"ProBtn: proBtnWillClose");
    return YES;
}

- (void)proBtnDidClose {
    NSLog(@"ProBtn: proBtnDidClose");
}

- (BOOL)proBtnWillShow {
    NSLog(@"ProBtn: proBtnWillShow");
    return YES;
}

- (void)proBtnDidShow {
    NSLog(@"ProBtn: proBtnDidShow");
}

- (BOOL)proBtnWillHide {
    NSLog(@"ProBtn: proBtnWillHide");
    return YES;
}

- (void)proBtnDidHide {
    NSLog(@"ProBtn: proBtnDidHide");
}

- (BOOL)proBtnWillDrag {
    NSLog(@"ProBtn: proBtnWillDrag");
    return YES;
}

- (void)proBtnDidDrag {
    NSLog(@"ProBtn: proBtnDidDrag");
}

- (BOOL)proBtnWillContentShow {
    NSLog(@"ProBtn: proBtnWillContentShow");
    return YES;
}

- (void)proBtnDidContentShow {
    NSLog(@"ProBtn: proBtnDidContentShow");
}

- (BOOL)proBtnWillContentHide {
    NSLog(@"ProBtn: proBtnWillContentHide");
    return YES;
}

- (void)proBtnDidContentHide {
    NSLog(@"ProBtn: proBtnDidContentHide");
}

- (void)proBtnWillContentLoad {
    NSLog(@"ProBtn: proBtnWillContentLoad");
}

- (void)proBtnDidContentLoad {
    NSLog(@"ProBtn: proBtnDidContentLoad");
}

- (void)proBtnContentError:(NSError*)error {
    NSLog(@"ProBtn: proBtnContentError:%@", error);
}

- (void)proBtnDidSettingsSynchronized {
    NSLog(@"ProBtn: proBtnDidSettingsSynchronized %@", [ProBtn serverSettings]);
    [ProBtn synchronizeStatistics];
}

- (void)proBtnDidStatisticsSynchronized {
    NSLog(@"ProBtn: proBtnDidStatisticsSynchronized %@", [ProBtn serverStatistics]);
}

- (void)proBtnEvent:(NSArray*)event args:(NSDictionary*)args {
    NSLog(@"ProBtn: proBtnEvent:%@ args:%@", event, args);
}

@end

//----------------------------------------------//
