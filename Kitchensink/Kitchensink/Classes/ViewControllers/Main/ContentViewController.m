//----------------------------------------------//

#import "ContentViewController.h"
#import "MainNavigationController.h"
#import "PreferenceViewController.h"
#import "Buttons.h"

//----------------------------------------------//

#import "ProBtn.h"

//----------------------------------------------//

@interface ContentPreference () {
    FG_SAFE_UNRETAINED(ContentViewController*) mContentViewController;
    ContentPreferenceType mType;
    NSString* mBackgroundUrl;
    BOOL mBackgroundChanged;
    UIImage* mDefaultButtonImage;
    UIImage* mButtonImage;
    NSString* mButtonImageUrl;
    UIImage* mButtonOpenImage;
    NSString* mButtonOpenImageUrl;
    CGSize mButtonSize;
    NSString* mContentUrl;
    CGSize mContentSize;
    NSString* mHintText;
}

- (NSString*)stringFromType:(ContentPreferenceType)type;

@end

//----------------------------------------------//

@interface ContentViewController () < UIScrollViewDelegate, UIPopoverControllerDelegate > {
    ContentPreference* mContentPreference;
    
    UIPopoverController* mPreferencePopoverController;
    PreferenceViewController* mPreferenceViewController;
}

@property(nonatomic, weak) IBOutlet UIScrollView* scrollView;
@property(nonatomic, weak) IBOutlet UIWebView* webView;
@property(nonatomic, weak) IBOutlet UIView* blackView;

@end

//----------------------------------------------//

@implementation ContentPreference

@synthesize contentViewController = mContentViewController;
@synthesize backgroundUrl = mBackgroundUrl;
@synthesize defaultButtonImage = mDefaultButtonImage;
@synthesize buttonImage = mButtonImage;
@synthesize buttonImageUrl = mButtonImageUrl;
@synthesize buttonOpenImage = mButtonOpenImage;
@synthesize buttonOpenImageUrl = mButtonOpenImageUrl;
@synthesize buttonSize = mButtonSize;
@synthesize contentUrl = mContentUrl;
@synthesize contentSize = mContentSize;
@synthesize hintText = mHintText;

#pragma mark - Default

+ (id)contentPreferenceWithType:(ContentPreferenceType)type {
    return FG_SAFE_AUTORELEASE([[self alloc] initWithContentPreferenceType:type]);
}

- (id)initWithContentPreferenceType:(ContentPreferenceType)type {
    self = [super init];
    if(self != nil) {
        mType = type;
        
        switch(mType) {
            case ContentPreferenceTypeSurvey: {
                mBackgroundUrl = @"http://mobile.nytimes.com/";
                mBackgroundChanged = YES;
                mButtonSize = CGSizeMake(64.0f, 64.0f);
                mDefaultButtonImage = FG_SAFE_RETAIN([UIImage imageNamed:@"survey_button"]);
                mContentUrl = @"http://survey.probtn.com/52248963450fdc0200000001";
                break;
            }
            case ContentPreferenceTypeShop: {
                mBackgroundUrl = @"http://goo.gl/mraDV9";
                mBackgroundChanged = YES;
                mButtonSize = CGSizeMake(72.0f, 72.0f);
                mDefaultButtonImage = FG_SAFE_RETAIN([UIImage imageNamed:@"shop_button"]);
                mButtonImage = FG_SAFE_RETAIN([UIImage imageNamed:@"eqwid_button"]);
                mButtonOpenImage = FG_SAFE_RETAIN([UIImage imageNamed:@"eqwid_button_active"]);
                mContentUrl = @"http://app.ecwid.com/jsp/2557211/m";
                break;
            }
            case ContentPreferenceTypeAdvertising: {
                mBackgroundUrl = @"http://bleacherreport.com/";
                mBackgroundChanged = YES;
                mButtonSize = CGSizeMake(92.0f, 86.0f);
                mDefaultButtonImage = FG_SAFE_RETAIN([UIImage imageNamed:@"advertising_button"]);
                mContentUrl = @"http://m.adidas.com/";
                break;
            }
            case ContentPreferenceTypeChicagoBulls1: {
                mBackgroundUrl = @"http://www.blogabull.com/";
                mBackgroundChanged = YES;
                mButtonSize = CGSizeMake(72.0f, 72.0f);
                mDefaultButtonImage = FG_SAFE_RETAIN([UIImage imageNamed:@"chicago_bulls1_button"]);
                mButtonImage = FG_SAFE_RETAIN([UIImage imageNamed:@"chicago_bulls1_button"]);
                mButtonOpenImage = FG_SAFE_RETAIN([UIImage imageNamed:@"chicago_bulls1_button_active"]);
                mContentUrl = @"http://shop.bulls.com/";
                mHintText = @"Chicago Bulls";
                break;
            }
            case ContentPreferenceTypeChicagoBulls2: {
                mBackgroundUrl = @"http://www.blogabull.com/";
                mBackgroundChanged = YES;
                mButtonSize = CGSizeMake(72.0f, 72.0f);
                mDefaultButtonImage = FG_SAFE_RETAIN([UIImage imageNamed:@"chicago_bulls2_button"]);
                mButtonImage = FG_SAFE_RETAIN([UIImage imageNamed:@"chicago_bulls2_button"]);
                mButtonOpenImage = FG_SAFE_RETAIN([UIImage imageNamed:@"chicago_bulls2_button_active"]);
                mContentUrl = @"http://store.nba.com/partnerID/13558/Chicago_Bulls_Gear/";
                mHintText = @"Chicago Bulls";
                break;
            }
        }
        
        if(mButtonImage == nil) {
            mButtonImage = FG_SAFE_RETAIN(mDefaultButtonImage);
        }
        if(mButtonOpenImage == nil) {
            mButtonOpenImage = FG_SAFE_RETAIN(mDefaultButtonImage);
        }
        
        id< ProBtnSettings > settings = [ProBtn defaultSettings];
        if(settings != nil) {
            mContentSize = [settings contentSize];
            if(mHintText == nil) {
                mHintText = FG_SAFE_RETAIN([settings hintText]);
            }
        }
        
        [self loadFromSetting];
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_RELEASE(mBackgroundUrl);
    FG_SAFE_RELEASE(mDefaultButtonImage);
    FG_SAFE_RELEASE(mButtonImage);
    FG_SAFE_RELEASE(mButtonImageUrl);
    FG_SAFE_RELEASE(mButtonOpenImage);
    FG_SAFE_RELEASE(mButtonOpenImageUrl);
    FG_SAFE_RELEASE(mContentUrl);
    FG_SAFE_RELEASE(mHintText);
    FG_SAFE_DEALLOC;
}

#pragma mark - Property

- (void)setBackgroundUrl:(NSString*)backgroundUrl {
    if([mBackgroundUrl isEqualToString:backgroundUrl] == NO) {
        FG_SAFE_SETTER(mBackgroundUrl, backgroundUrl);
        mBackgroundChanged = YES;
    }
}

#pragma mark - Public

- (void)applyPreference {
    switch(mType) {
        case ContentPreferenceTypeSurvey: {
            [[mContentViewController navigationItem] setTitle:NSLocalizedString(@"Survey", nil)];
            break;
        }
        case ContentPreferenceTypeShop: {
            [[mContentViewController navigationItem] setTitle:NSLocalizedString(@"Shop", nil)];
            break;
        }
        case ContentPreferenceTypeAdvertising: {
            [[mContentViewController navigationItem] setTitle:NSLocalizedString(@"Advertising", nil)];
            break;
        }
        case ContentPreferenceTypeChicagoBulls1: {
            [[mContentViewController navigationItem] setTitle:NSLocalizedString(@"Chickago Bulls", nil)];
            break;
        }
        case ContentPreferenceTypeChicagoBulls2: {
            [[mContentViewController navigationItem] setTitle:NSLocalizedString(@"Chickago Bulls", nil)];
            break;
        }
    }
    
    if(mBackgroundChanged == YES) {
        [[mContentViewController webView] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:mBackgroundUrl]]];
        mBackgroundChanged = NO;
    }
    
    id< ProBtnSettings > settings = [ProBtn userSettings];
    if(settings != nil) {
        [settings setButtonImage:mButtonImage];
        [settings setButtonDragImage:mButtonImage];
        [settings setButtonOpenImage:mButtonOpenImage];
        [settings setButtonSize:mButtonSize];
        [settings setButtonDragSize:CGSizeMake(mButtonSize.width + 4.0f, mButtonSize.height + 4.0f)];
        [settings setButtonOpenSize:CGSizeMake(mButtonSize.width + 2.0f, mButtonSize.height + 2.0f)];
        [settings setContentURL:[NSURL URLWithString:mContentUrl]];
        [settings setContentSize:mContentSize];
        [settings setHintText:mHintText];
        [ProBtn setUserSettings:settings];
    }
}

- (NSString*)stringFromType:(ContentPreferenceType)type {
    switch(mType) {
        case ContentPreferenceTypeSurvey: return @"Kitchensink::Survey";
        case ContentPreferenceTypeShop: return @"Kitchensink::Shop";
        case ContentPreferenceTypeAdvertising: return @"Kitchensink::Advertising";
        case ContentPreferenceTypeChicagoBulls1: return @"Kitchensink::ChicagoBulls1";
        case ContentPreferenceTypeChicagoBulls2: return @"Kitchensink::ChicagoBulls2";
    }
    return nil;
}

- (void)loadFromSetting {
    NSString* group = [self stringFromType:mType];
    if(group != nil) {
        NSDictionary* params = [[NSUserDefaults standardUserDefaults] objectForKey:group];
        if(params != nil) {
            NSString* backgroundUrl = [params objectForKey:@"BackgroundUrl"];
            if(backgroundUrl != nil) {
                FG_SAFE_SETTER(mBackgroundUrl, backgroundUrl);
            }
            NSString* buttonImageUrl = [params objectForKey:@"ButtonImageUrl"];
            if(buttonImageUrl != nil) {
                FG_SAFE_SETTER(mButtonImageUrl, buttonImageUrl);
            }
            @try {
                NSData* buttonImageData = [params objectForKey:@"ButtonImage"];
                if(buttonImageData != nil) {
                    FG_SAFE_SETTER(mButtonImage, [UIImage imageWithData:buttonImageData scale:2.0f]);
                }
            }
            @catch(NSException *exception) {
            }
            NSString* buttonOpenImageUrl = [params objectForKey:@"ButtonOpenImageUrl"];
            if(buttonOpenImageUrl != nil) {
                FG_SAFE_SETTER(mButtonOpenImageUrl, buttonOpenImageUrl);
            }
            @try {
                NSData* buttonOpenImageData = [params objectForKey:@"ButtonOpenImage"];
                if(buttonOpenImageData != nil) {
                    FG_SAFE_SETTER(mButtonOpenImage, [UIImage imageWithData:buttonOpenImageData scale:2.0f]);
                }
            }
            @catch(NSException *exception) {
            }
            NSString* buttonSize = [params objectForKey:@"ButtonSize"];
            if(buttonSize != nil) {
                mButtonSize = CGSizeFromString(buttonSize);
            }
            NSString* contentUrl = [params objectForKey:@"ContentUrl"];
            if(contentUrl != nil) {
                FG_SAFE_SETTER(mContentUrl, contentUrl);
            }
            NSString* contentSize = [params objectForKey:@"ContentSize"];
            if(contentSize != nil) {
                mContentSize = CGSizeFromString(contentSize);
            }
            NSString* hintText = [params objectForKey:@"HintText"];
            if(hintText != nil) {
                FG_SAFE_SETTER(mHintText, hintText);
            }
        }
    }
}

- (void)saveToSetting {
    @try {
        NSString* group = [self stringFromType:mType];
        if(group != nil) {
            NSMutableDictionary* params = [NSMutableDictionary dictionary];
            if(params != nil) {
                if(mBackgroundUrl != nil) {
                    [params setObject:mBackgroundUrl forKey:@"BackgroundUrl"];
                }
                if(mButtonImage != nil) {
                    if(mButtonImageUrl != nil) {
                        [params setObject:mButtonImageUrl forKey:@"ButtonImageUrl"];
                    }
                    if(mButtonImage != mDefaultButtonImage) {
                        @try {
                            NSData* imageData = UIImagePNGRepresentation(mButtonImage);
                            if(imageData != nil) {
                                [params setObject:imageData forKey:@"ButtonImage"];
                            }
                        }
                        @catch(NSException *exception) {
                        }
                    }
                }
                if(mButtonOpenImage != nil) {
                    if(mButtonOpenImageUrl != nil) {
                        [params setObject:mButtonOpenImageUrl forKey:@"ButtonOpenImageUrl"];
                    }
                    if(mButtonOpenImage != mDefaultButtonImage) {
                        @try {
                            NSData* imageData = UIImagePNGRepresentation(mButtonOpenImage);
                            if(imageData != nil) {
                                [params setObject:imageData forKey:@"ButtonOpenImage"];
                            }
                        }
                        @catch(NSException *exception) {
                        }
                    }
                }
                [params setObject:NSStringFromCGSize(mButtonSize) forKey:@"ButtonSize"];
                if(mContentUrl != nil) {
                    [params setObject:mContentUrl forKey:@"ContentUrl"];
                }
                [params setObject:NSStringFromCGSize(mContentSize) forKey:@"ContentSize"];
                if(mHintText != nil) {
                    [params setObject:mHintText forKey:@"HintText"];
                }
                [[NSUserDefaults standardUserDefaults] setObject:params forKey:group];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }
    @catch(NSException *exception) {
    }
}

@end

//----------------------------------------------//

@implementation ContentViewController

@synthesize contentPreference = mContentPreference;

#pragma mark - Default

- (id)initWithWindow:(Window*)window {
    self = [super initWithWindow:window];
    if(self != nil) {
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_RELEASE(mContentPreference);
    FG_SAFE_RELEASE(mPreferencePopoverController);
    FG_SAFE_RELEASE(mPreferenceViewController);
    FG_SAFE_DEALLOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
    if(FG_IOS_VERSION >= 7.0) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        [ProBtn setButtonWindowFullscreen:YES];
    }
#endif
    
    [[self navigationItem] setLeftBarView:[ButtonNavigationMenu buttonWithTarget:self action:@selector(showMainMenuPressed:) forControlEvents:UIControlEventTouchDown]];
    [[self navigationItem] setRightBarView:[ButtonNavigationPreference buttonWithTarget:self action:@selector(showPreferencePressed:) forControlEvents:UIControlEventTouchUpInside]];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [[[self webView] scrollView] setDelegate:self];
    
    [self applyContentPreference];
}

- (void)viewDidUnload {
    [self setWebView:nil];
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [ProBtn showHint];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize scrollSize = [[self scrollView] boundsSize];
    [[self webView] setFramePosition:CGPointMake(0.0f, 0.0f)];
    [[self webView] setFrameSize:scrollSize];
    [[self blackView] setFramePosition:CGPointMake(scrollSize.width, 0.0f)];
    [[self blackView] setFrameSize:scrollSize];
    [[self scrollView] setContentSize:CGSizeMake(scrollSize.width * 2.0f, scrollSize.height)];
}

#pragma mark - Property

- (void)setContentPreference:(ContentPreference*)contentPreference {
    if(mContentPreference != contentPreference) {
        FG_SAFE_SETTER(mContentPreference, contentPreference);
        [mContentPreference setContentViewController:self];
    }
}

#pragma mark - Public

- (void)applyContentPreference {
    [mContentPreference applyPreference];
}

- (void)showMainMenu {
    [[[self window] mainNavigationControler] toggleMenu];
}

- (void)showPreference {
    if(mPreferenceViewController == nil) {
        mPreferenceViewController = FG_SAFE_RETAIN([PreferenceViewController controllerWithWindow:[self window]]);
        [mPreferenceViewController setContentPreference:mContentPreference];
    }
    switch(UI_USER_INTERFACE_IDIOM()) {
        case UIUserInterfaceIdiomPhone: {
            [self presentViewController:mPreferenceViewController animated:YES completion:nil];
            break;
        }
        case UIUserInterfaceIdiomPad: {
            if(mPreferencePopoverController == nil) {
                mPreferencePopoverController = FG_SAFE_RETAIN([[UIPopoverController alloc] initWithContentViewController:mPreferenceViewController]);
                [mPreferencePopoverController setDelegate:self];
            }
            [mPreferencePopoverController presentPopoverFromRect:[[[[self navigationItem] rightBarButtonItem] customView] frame]
                                                          inView:[[self navigationController] view]
                                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                                        animated:YES];
            break;
        }
    }
}

#pragma mark - IBAction

- (IBAction)showMainMenuPressed:(id)sender {
    [self showMainMenu];
}

- (IBAction)showPreferencePressed:(id)sender {
    [self showPreference];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGPoint contentOffset = [scrollView contentOffset];
    if(contentOffset.y > CONTENT_PREFERENCE_SENSITIVITY) {
        if(FG_IOS_VERSION >= 7.0) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            [ProBtn setButtonWindowFullscreen:YES];
        }
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    } else if(contentOffset.y < -CONTENT_PREFERENCE_SENSITIVITY) {
        if(FG_IOS_VERSION >= 7.0) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
            [ProBtn setButtonWindowFullscreen:NO];
        }
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController*)popoverController {
    [mContentPreference saveToSetting];
}

@end

//----------------------------------------------//
