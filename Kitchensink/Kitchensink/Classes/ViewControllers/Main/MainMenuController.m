//----------------------------------------------//

#import "MainMenuController.h"
#import "MainNavigationController.h"
#import "CoreNavigationController.h"
#import "ContentViewController.h"

//----------------------------------------------//

@interface MainMenuController () {
    CoreNavigationController* mSurveyViewController;
    CoreNavigationController* mShopViewController;
    CoreNavigationController* mAdvertisingViewController;
    
    FG_SAFE_UNRETAINED(CoreNavigationController*) mCurrentViewController;
    FG_SAFE_UNRETAINED(UIButton*) mCurrentMenuItem;
}

@property(nonatomic, weak) IBOutlet UIButton* openSurveyPage;
@property(nonatomic, weak) IBOutlet UIButton* openShopPage;
@property(nonatomic, weak) IBOutlet UIButton* openAdvertisingPage;

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
    FG_SAFE_RELEASE(mSurveyViewController);
    FG_SAFE_RELEASE(mShopViewController);
    FG_SAFE_RELEASE(mAdvertisingViewController);
    FG_SAFE_DEALLOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectMenuItem:mCurrentViewController];
}

- (void)viewDidUnload {
    [self setOpenSurveyPage:nil];
    [self setOpenShopPage:nil];
    [self setOpenAdvertisingPage:nil];
    
    [super viewDidUnload];
}

#pragma mark - Property

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

- (CoreNavigationController*)currentViewController {
    if(mCurrentViewController == nil) {
        mCurrentViewController = [self surveyViewController];
        
        [self selectMenuItem:mCurrentViewController];
    }
    return mCurrentViewController;
}

#pragma mark - Public

- (void)openController:(CoreNavigationController*)controller {
    if(mCurrentViewController != controller) {
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

@end

//----------------------------------------------//
