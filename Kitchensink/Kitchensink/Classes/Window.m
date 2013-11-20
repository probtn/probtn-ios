//----------------------------------------------//

#import "Window.h"

//----------------------------------------------//

#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
#import "LaunchNavigationController.h"
#import "LaunchViewController.h"
#endif
#import "MainNavigationController.h"

//----------------------------------------------//

#import "ProBtn.h"

//----------------------------------------------//

@interface Window () {
#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
    LaunchNavigationController* mLaunchControler;
#endif
    MainNavigationController* mMainControler;
}

@end

//----------------------------------------------//

@implementation Window

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        switch(UI_USER_INTERFACE_IDIOM()) {
            case UIUserInterfaceIdiomPhone: {
                [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskPortrait];
                break;
            }
            case UIUserInterfaceIdiomPad: {
                [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAll];
                break;
            }
        }
#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
        [self setRootViewController:[self launchNavigationControler]];
#elif (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_LITE)
        [self setRootViewController:[self mainNavigationControler]];
        [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAll];
        [ProBtn open];
#endif
    }
    return self;
}

- (void)dealloc {
#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
    FG_SAFE_RELEASE(mLaunchControler);
#endif
    FG_SAFE_RELEASE(mMainControler);
    FG_SAFE_DEALLOC;
}

#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
- (LaunchNavigationController*)launchNavigationControler {
    if(mLaunchControler == nil) {
        mLaunchControler = FG_SAFE_RETAIN([LaunchNavigationController controllerWithWindow:self]);
    }
    return mLaunchControler;
}
#endif

- (MainNavigationController*)mainNavigationControler {
    if(mMainControler == nil) {
        mMainControler = FG_SAFE_RETAIN([MainNavigationController controllerWithWindow:self]);
    }
    return mMainControler;
}

#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
- (void)showLaunchNavigationController {
    [[self launchNavigationControler] popToRootViewControllerAnimated:NO];
    [UIView transitionWithView:self
                      duration:0.8f
                       options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self setRootViewController:[self launchNavigationControler]];
                    }
                    completion:^(BOOL finished) {
                        [ProBtn close];
                    }];
}

- (void)showMainNavigationController {
    [UIView transitionWithView:self
                      duration:0.8f
                       options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self setRootViewController:[self mainNavigationControler]];
                    }
                    completion:^(BOOL finished) {
                        [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAll];
                        [ProBtn open];
                    }];
}
#endif

@end

//----------------------------------------------//
