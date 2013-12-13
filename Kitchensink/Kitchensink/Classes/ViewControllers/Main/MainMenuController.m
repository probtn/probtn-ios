//----------------------------------------------//

#import "MainMenuController.h"
#import "MainNavigationController.h"
#import "CoreNavigationController.h"
#import "ContentViewController.h"

//----------------------------------------------//

#import "ProBtn.h"

//----------------------------------------------//


@interface MainMenuController () {
    CoreNavigationController* mClearViewController;
    CoreNavigationController* mSurveyViewController;
    CoreNavigationController* mShopViewController;
    CoreNavigationController* mAdvertisingViewController;
    CoreNavigationController* mChicagoBulls1ViewController;
    CoreNavigationController* mChicagoBulls2ViewController;
    
    FG_SAFE_UNRETAINED(CoreNavigationController*) mCurrentViewController;
    FG_SAFE_UNRETAINED(UIButton*) mCurrentMenuItem;
}

@property(nonatomic, weak) IBOutlet UIButton* openSurveyPage;
@property(nonatomic, weak) IBOutlet UIButton* openShopPage;
@property(nonatomic, weak) IBOutlet UIButton* openAdvertisingPage;
@property(nonatomic, weak) IBOutlet UIButton* openChicagoBulls1Page;
@property(nonatomic, weak) IBOutlet UIButton* openChicagoBulls2Page;

- (void)selectMenuItem:(CoreNavigationController*)controller;

@end

//----------------------------------------------//

@implementation MainMenuController

#pragma mark - Default

- (id)initWithWindow:(Window*)window {
    self = [super initWithWindow:window];
    if(self != nil) {
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_RELEASE(mClearViewController);
    FG_SAFE_RELEASE(mSurveyViewController);
    FG_SAFE_RELEASE(mShopViewController);
    FG_SAFE_RELEASE(mAdvertisingViewController);
    FG_SAFE_RELEASE(mChicagoBulls1ViewController);
    FG_SAFE_RELEASE(mChicagoBulls2ViewController);
    FG_SAFE_DEALLOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self selectMenuItem:mCurrentViewController];
}

- (void)viewDidUnload {
    [self setOpenSurveyPage:nil];
    [self setOpenShopPage:nil];
    [self setOpenAdvertisingPage:nil];
    [self setOpenChicagoBulls1Page:nil];
    [self setOpenChicagoBulls2Page:nil];
    
    [super viewDidUnload];
}

#pragma mark - Property

- (CoreNavigationController*)clearViewController {
    if(mClearViewController == nil) {
        ContentViewController* controller = [ContentViewController controllerWithWindow:[self window]];
        if(controller != nil) {
            mClearViewController = FG_SAFE_RETAIN([CoreNavigationController controllerWithRootController:controller]);
        }
    }
    return mClearViewController;
}

- (CoreNavigationController*)surveyViewController {
    if(mSurveyViewController == nil) {
        ContentViewController* controller = [ContentViewController controllerWithWindow:[self window]];
        if(controller != nil) {
            [controller setContentPreference:[ContentPreference contentPreferenceWithType:ContentPreferenceTypeSurvey]];
            mSurveyViewController = FG_SAFE_RETAIN([CoreNavigationController controllerWithRootController:controller]);
        }
    }
    return mSurveyViewController;
}

- (CoreNavigationController*)shopViewController {
    if(mShopViewController == nil) {
        ContentViewController* controller = [ContentViewController controllerWithWindow:[self window]];
        if(controller != nil) {
            [controller setContentPreference:[ContentPreference contentPreferenceWithType:ContentPreferenceTypeShop]];
            mShopViewController = FG_SAFE_RETAIN([CoreNavigationController controllerWithRootController:controller]);
        }
    }
    return mShopViewController;
}

- (CoreNavigationController*)advertisingViewController {
    if(mAdvertisingViewController == nil) {
        ContentViewController* controller = [ContentViewController controllerWithWindow:[self window]];
        if(controller != nil) {
            [controller setContentPreference:[ContentPreference contentPreferenceWithType:ContentPreferenceTypeAdvertising]];
            mAdvertisingViewController = FG_SAFE_RETAIN([CoreNavigationController controllerWithRootController:controller]);
        }
    }
    return mAdvertisingViewController;
}

- (CoreNavigationController*)chicagoBulls1ViewController {
    if(mChicagoBulls1ViewController == nil) {
        ContentViewController* controller = [ContentViewController controllerWithWindow:[self window]];
        if(controller != nil) {
            [controller setContentPreference:[ContentPreference contentPreferenceWithType:ContentPreferenceTypeChicagoBulls1]];
            mChicagoBulls1ViewController = FG_SAFE_RETAIN([CoreNavigationController controllerWithRootController:controller]);
        }
    }
    return mChicagoBulls1ViewController;
}

- (CoreNavigationController*)chicagoBulls2ViewController {
    if(mChicagoBulls2ViewController == nil) {
        ContentViewController* controller = [ContentViewController controllerWithWindow:[self window]];
        if(controller != nil) {
            [controller setContentPreference:[ContentPreference contentPreferenceWithType:ContentPreferenceTypeChicagoBulls2]];
            mChicagoBulls2ViewController = FG_SAFE_RETAIN([CoreNavigationController controllerWithRootController:controller]);
        }
    }
    return mChicagoBulls2ViewController;
}

- (CoreNavigationController*)currentViewController {
    if(mCurrentViewController == nil) {
        mCurrentViewController = [self clearViewController];
        
        [self selectMenuItem:mCurrentViewController];
    }
    return mCurrentViewController;
}

#pragma mark - Public

- (void)openController:(CoreNavigationController*)controller {
    if(mCurrentViewController != controller) {
        if([ProBtn isOpened] == NO) {
            [ProBtn open];
        }
        mCurrentViewController = controller;
        
        if([mCurrentViewController isViewLoaded] == YES) {
            UIViewController* rootViewController = [controller rootViewController];
            if([rootViewController isKindOfClass:[ContentViewController class]] == YES) {
                [(ContentViewController*)rootViewController applyContentPreference];
            }
        }
        [[[self window] mainNavigationControler] changeContentViewController:mCurrentViewController closeMenu:YES];
        [self selectMenuItem:mCurrentViewController];
    }
}

#pragma mark - Private

- (void)selectMenuItem:(CoreNavigationController*)controller {
    UIButton* previousMenuItem = mCurrentMenuItem;
    if(controller == mSurveyViewController) {
        mCurrentMenuItem = [self openSurveyPage];
    } else if(controller == mShopViewController) {
        mCurrentMenuItem = [self openShopPage];
    } else if(controller == mAdvertisingViewController) {
        mCurrentMenuItem = [self openAdvertisingPage];
    } else if(controller == mChicagoBulls1ViewController) {
        mCurrentMenuItem = [self openChicagoBulls1Page];
    } else if(controller == mChicagoBulls2ViewController) {
        mCurrentMenuItem = [self openChicagoBulls2Page];
    }
    if(mCurrentMenuItem != nil) {
        [mCurrentMenuItem setSelected:YES];
    }
    if(previousMenuItem != nil) {
        [previousMenuItem setSelected:NO];
    }
}

#pragma mark - IBAction

- (IBAction)openSurveyPagePressed:(id)sender {
    [self openController:[self surveyViewController]];
}

- (IBAction)openShopPagePressed:(id)sender {
    [self openController:[self shopViewController]];
}

- (IBAction)openAdvertisingPagePressed:(id)sender {
    [self openController:[self advertisingViewController]];
}

- (IBAction)openChicagoBulls1Pressed:(id)sender {
    [self openController:[self chicagoBulls1ViewController]];
}

- (IBAction)openChicagoBulls2Pressed:(id)sender {
    [self openController:[self chicagoBulls2ViewController]];
}


@end

//----------------------------------------------//
