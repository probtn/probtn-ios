//----------------------------------------------//

#import "ProBtnVersion.h"

//----------------------------------------------//

typedef NS_OPTIONS(NSUInteger, ProBtnInterfaceOrientationMask) {
    ProBtnInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
    ProBtnInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
    ProBtnInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
    ProBtnInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
    ProBtnInterfaceOrientationMaskLandscape = (ProBtnInterfaceOrientationMaskLandscapeLeft | ProBtnInterfaceOrientationMaskLandscapeRight),
    ProBtnInterfaceOrientationMaskAll = (ProBtnInterfaceOrientationMaskPortrait | ProBtnInterfaceOrientationMaskLandscapeLeft | ProBtnInterfaceOrientationMaskLandscapeRight | ProBtnInterfaceOrientationMaskPortraitUpsideDown),
    ProBtnInterfaceOrientationMaskAllButUpsideDown = (ProBtnInterfaceOrientationMaskPortrait | ProBtnInterfaceOrientationMaskLandscapeLeft | ProBtnInterfaceOrientationMaskLandscapeRight),
};

//----------------------------------------------//

@protocol ProBtnDelegate;
@protocol ProBtnSettings;
@protocol ProBtnStatistics;

//----------------------------------------------//

@interface ProBtn : NSObject

+ (NSUInteger)version;

+ (NSString*)deviceUID;
+ (NSString*)deviceType;

+ (BOOL)isOpened;
+ (void)open;
+ (void)close;

+ (BOOL)isShowed;
+ (void)show;
+ (void)hide;

+ (BOOL)isHintShowed;
+ (void)showHint;
+ (void)hideHint;

+ (BOOL)isContentShowed;
+ (void)showContent;
+ (void)hideContent;

+ (BOOL)isSettingsSynchronized;
+ (id< ProBtnSettings >)defaultSettings;
+ (id< ProBtnSettings >)serverSettings;
+ (void)setUserSettings:(id< ProBtnSettings >)userSettings;
+ (id< ProBtnSettings >)userSettings;

+ (BOOL)isStatisticsSynchronized;
+ (id< ProBtnStatistics >)serverStatistics;
+ (void)synchronizeStatistics;

+ (void)setAvailableOrientations:(ProBtnInterfaceOrientationMask)orientations;
+ (ProBtnInterfaceOrientationMask)availableOrientations;

+ (void)setButtonWindowLevel:(UIWindowLevel)buttonWindowLevel;
+ (UIWindowLevel)buttonWindowLevel;

+ (void)setButtonWindowFullscreen:(BOOL)buttonWindowFullscreen;
+ (BOOL)buttonWindowFullscreen;

+ (void)setDelegate:(id< ProBtnDelegate >)delegate;
+ (id< ProBtnDelegate >)delegate;

@end

//----------------------------------------------//

@protocol ProBtnDelegate < NSObject >

@optional
- (BOOL)proBtnWillOpen;
- (void)proBtnDidOpen;

- (BOOL)proBtnWillClose;
- (void)proBtnDidClose;

- (BOOL)proBtnWillShow;
- (void)proBtnDidShow;

- (BOOL)proBtnWillHide;
- (void)proBtnDidHide;

- (BOOL)proBtnWillDrag;
- (void)proBtnDidDrag;

- (BOOL)proBtnWillContentShow;
- (void)proBtnDidContentShow;

- (BOOL)proBtnWillContentHide;
- (void)proBtnDidContentHide;

- (void)proBtnWillContentLoad;
- (void)proBtnDidContentLoad;
- (void)proBtnContentError:(NSError*)error;

- (void)proBtnDidSettingsSynchronized;
- (void)proBtnDidStatisticsSynchronized;

- (void)proBtnEvent:(NSArray*)event args:(NSDictionary*)args;

@end

//----------------------------------------------//

@protocol ProBtnSettings < NSObject >

@property (nonatomic, readonly) NSMutableDictionary* values;

@property (nonatomic, readwrite) UIEdgeInsets baseInsets;

@property (nonatomic, readwrite) BOOL buttonEnabled;
@property (nonatomic, readwrite) BOOL buttonVisible;

@property (nonatomic, readwrite) CGFloat buttonWeight;
@property (nonatomic, readwrite) CGFloat buttonDensity;
@property (nonatomic, readwrite) CGFloat buttonDragRatio;
@property (nonatomic, readwrite) BOOL buttonDragReflection;
@property (nonatomic, readwrite) UIEdgeInsets buttonOpenInsets;
@property (nonatomic, readwrite) CGPoint buttonPosition;
@property (nonatomic, readwrite) CGSize buttonSize;
@property (nonatomic, readwrite) CGSize buttonDragSize;
@property (nonatomic, readwrite) CGSize buttonOpenSize;
@property (nonatomic, readwrite) CGSize buttonInactiveSize;
@property (nonatomic, readwrite) CGFloat buttonOpacity;
@property (nonatomic, readwrite) CGFloat buttonDragOpacity;
@property (nonatomic, readwrite) CGFloat buttonOpenOpacity;
@property (nonatomic, readwrite) CGFloat buttonInactiveOpacity;
@property (nonatomic, readwrite, strong) UIImage* buttonImage;
@property (nonatomic, readwrite, strong) UIImage* buttonDragImage;
@property (nonatomic, readwrite, strong) UIImage* buttonOpenImage;
@property (nonatomic, readwrite, strong) UIImage* buttonInactiveImage;

@property (nonatomic, readwrite) CGPoint closePosition;
@property (nonatomic, readwrite) CGSize closeSize;
@property (nonatomic, readwrite) CGSize closeActiveSize;
@property (nonatomic, readwrite) CGFloat closeOpacity;
@property (nonatomic, readwrite) CGFloat closeActiveOpacity;
@property (nonatomic, readwrite, strong) UIImage* closeImage;
@property (nonatomic, readwrite, strong) UIImage* closeActiveImage;

@property (nonatomic, readwrite) UIEdgeInsets hintInsets;
@property (nonatomic, readwrite) UIEdgeInsets hintLabelInsets;
@property (nonatomic, readwrite) UIEdgeInsets hintImageInsets;
@property (nonatomic, readwrite, strong) NSString* hintText;
@property (nonatomic, readwrite, strong) UIFont* hintFont;
@property (nonatomic, readwrite, strong) UIColor* hintFontColor;
@property (nonatomic, readwrite) CGFloat hintOpacity;
@property (nonatomic, readwrite, strong) UIImage* hintImage;

@property (nonatomic, readwrite) CGSize hintArrowSize;
@property (nonatomic, readwrite) UIEdgeInsets hintArrowOffset;
@property (nonatomic, readwrite, strong) UIImage* hintArrowImageT;
@property (nonatomic, readwrite, strong) UIImage* hintArrowImageB;
@property (nonatomic, readwrite, strong) UIImage* hintArrowImageL;
@property (nonatomic, readwrite, strong) UIImage* hintArrowImageR;

@property (nonatomic, readwrite) UIEdgeInsets contentInsets;
@property (nonatomic, readwrite) UIEdgeInsets contentWebViewInsets;
@property (nonatomic, readwrite) UIEdgeInsets contentImageInsets;
@property (nonatomic, readwrite) CGSize contentSize;
@property (nonatomic, readwrite, strong) NSURL* contentURL;
@property (nonatomic, readwrite) CGFloat contentOpacity;
@property (nonatomic, readwrite, strong) UIColor* contentBackColor;
@property (nonatomic, readwrite) CGFloat contentBackOpacity;
@property (nonatomic, readwrite, strong) UIColor* contentActivityColor;
@property (nonatomic, readwrite, strong) UIImage* contentImage;

@property (nonatomic, readwrite) CGSize contentArrowSize;
@property (nonatomic, readwrite) UIEdgeInsets contentArrowOffset;
@property (nonatomic, readwrite, strong) UIImage* contentArrowImageT;
@property (nonatomic, readwrite, strong) UIImage* contentArrowImageB;
@property (nonatomic, readwrite, strong) UIImage* contentArrowImageL;
@property (nonatomic, readwrite, strong) UIImage* contentArrowImageR;

@property (nonatomic, readwrite) NSTimeInterval defaultDuration;
@property (nonatomic, readwrite) NSTimeInterval defaultDelay;

@property (nonatomic, readwrite) NSTimeInterval openDuration;
@property (nonatomic, readwrite) NSTimeInterval openDelay;
@property (nonatomic, readwrite) NSTimeInterval closeDuration;
@property (nonatomic, readwrite) NSTimeInterval closeDelay;

@property (nonatomic, readwrite) NSTimeInterval buttonShowDuration;
@property (nonatomic, readwrite) NSTimeInterval buttonShowDelay;
@property (nonatomic, readwrite) NSTimeInterval buttonHideDuration;
@property (nonatomic, readwrite) NSTimeInterval buttonHideDelay;
@property (nonatomic, readwrite) NSTimeInterval buttonDragDuration;
@property (nonatomic, readwrite) NSTimeInterval buttonDragDelay;
@property (nonatomic, readwrite) NSTimeInterval buttonUndragDuration;
@property (nonatomic, readwrite) NSTimeInterval buttonUndragDelay;
@property (nonatomic, readwrite) NSTimeInterval buttonInactiveDuration;
@property (nonatomic, readwrite) NSTimeInterval buttonInactiveDelay;

@property (nonatomic, readwrite) NSTimeInterval closeShowDuration;
@property (nonatomic, readwrite) NSTimeInterval closeShowDelay;
@property (nonatomic, readwrite) NSTimeInterval closeHideDuration;
@property (nonatomic, readwrite) NSTimeInterval closeHideDelay;
@property (nonatomic, readwrite) NSTimeInterval closeActiveDuration;
@property (nonatomic, readwrite) NSTimeInterval closeActiveDelay;
@property (nonatomic, readwrite) NSTimeInterval closeUnactiveDuration;
@property (nonatomic, readwrite) NSTimeInterval closeUnactiveDelay;

@property (nonatomic, readwrite) NSTimeInterval hintLaunchDuration;
@property (nonatomic, readwrite) NSTimeInterval hintLaunchDelay;
@property (nonatomic, readwrite) NSTimeInterval hintShowDuration;
@property (nonatomic, readwrite) NSTimeInterval hintShowDelay;
@property (nonatomic, readwrite) NSTimeInterval hintHideDuration;
@property (nonatomic, readwrite) NSTimeInterval hintHideDelay;

@property (nonatomic, readwrite) NSTimeInterval contentShowDuration;
@property (nonatomic, readwrite) NSTimeInterval contentShowDelay;
@property (nonatomic, readwrite) NSTimeInterval contentHideDuration;
@property (nonatomic, readwrite) NSTimeInterval contentHideDelay;

@end

//----------------------------------------------//

@protocol ProBtnStatistics < NSObject >

@property (nonatomic, readonly) NSMutableDictionary* values;

@property (nonatomic, readonly) NSUInteger usersCount;

@property (nonatomic, readonly) NSUInteger statisticOpened;
@property (nonatomic, readonly) NSUInteger statisticClosed;
@property (nonatomic, readonly) NSUInteger statisticMoved;
@property (nonatomic, readonly) NSUInteger statisticShowed;
@property (nonatomic, readonly) NSUInteger statisticHided;
@property (nonatomic, readonly) NSUInteger statisticHintShowed;
@property (nonatomic, readonly) NSUInteger statisticContentShowed;

- (NSUInteger)usersCountByDeviceType:(NSString*)deviceType;

@end

//----------------------------------------------//
