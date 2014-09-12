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

/*! Get current version
 @return Code versions
 */
#if (PROBTN_VERSION >= PROBTN_VERSION_1_1)
+ (NSUInteger)libraryVersion;
#endif

/*! Get current version
 @return Code versions
 */
+ (NSUInteger)version;

/*! Get device unique id
 @return Device unique id
 */
+ (NSString*)deviceUID;

/*! Get device type
 @return Device type
 */
+ (NSString*)deviceType;

/*! Get open status
 @return return YES is opened, otherwise NO.
 */
+ (BOOL)isOpened;

/*! Open button.
 */
+ (void)open;

/*! Close button
 */
+ (void)close;

/*! Get show status
 @return return YES is showed, otherwise NO.
 */
+ (BOOL)isShowed;

/*! Show button
 */
+ (void)show;

/*! Hide button
 */
+ (void)hide;

/*! Get hint status
 @return return YES is hint showed, otherwise NO.
 */
+ (BOOL)isHintShowed;

/*! Show hint
 */
+ (void)showHint;

/*! Hide hint
 */
+ (void)hideHint;

/*! Get content status
 @return return YES is content showed, otherwise NO.
 */
+ (BOOL)isContentShowed;

/*! Show content
 */
+ (void)showContent;

/*! Hide content
 */
+ (void)hideContent;

/*! Get settings synchronize status
 @return return YES is settings synchronized, otherwise NO.
 */
+ (BOOL)isSettingsSynchronized;

/*! Get default settings
 */
+ (id< ProBtnSettings >)defaultSettings;

/*! Get server settings
 */
+ (id< ProBtnSettings >)serverSettings;

/*! Apply user settings
 @param userSettings The required user settings, if you pass an nil user settings are reset
 */
+ (void)setUserSettings:(id< ProBtnSettings >)userSettings;

/*! Get user settings
 */
+ (id< ProBtnSettings >)userSettings;

/*! Get statistics synchronize status
 @return return YES is statistics synchronized, otherwise NO.
 */
+ (BOOL)isStatisticsSynchronized;

/*! Get current statistics
 */
+ (id< ProBtnStatistics >)serverStatistics;

/*! Request statistics
 */
+ (void)synchronizeStatistics;

/*! Set available orientations
 @code
 [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAllButUpsideDown];
 @endcode
 @param orientations Bits mask available orientations
 */
+ (void)setAvailableOrientations:(ProBtnInterfaceOrientationMask)orientations;

/*! Get available orientations
 @return Current available orientations
 */
+ (ProBtnInterfaceOrientationMask)availableOrientations;

/*! Set window level
 @param buttonWindowLevel Window level
 */
+ (void)setButtonWindowLevel:(UIWindowLevel)buttonWindowLevel;

/*! Get window level
 @return Current window level
 */
+ (UIWindowLevel)buttonWindowLevel;

/*! Set window fullscreen
 @param buttonWindowFullscreen Window fullscreen
 */
#if (PROBTN_VERSION >= PROBTN_VERSION_1_1)
+ (void)setWindowFullscreen:(BOOL)windowFullscreen;
#endif

/*! Set window fullscreen
 @param buttonWindowFullscreen Window fullscreen
 */
+ (void)setButtonWindowFullscreen:(BOOL)buttonWindowFullscreen;

/*! Get window fullscreen status
 @return return YES is fullscreen, otherwise NO.
 */
#if (PROBTN_VERSION >= PROBTN_VERSION_1_1)
+ (BOOL)windowFullscreen;
#endif

/*! Get window fullscreen status
 @return return YES is fullscreen, otherwise NO.
 */
+ (BOOL)buttonWindowFullscreen;

#if (PROBTN_VERSION >= PROBTN_VERSION_1_1)

/*! Reset button window orientation to portrait
 */
+ (void)resetOrientation;

/*! Set window status bar style
 @param windowStatusBarStyle status bar style
 */
+ (void)setWindowStatusBarStyle:(UIStatusBarStyle)windowStatusBarStyle;

/*! Get window status bar style
 @return return status bar style.
 */
+ (UIStatusBarStyle)windowStatusBarStyle;

#endif

/*! Set delegate
 @param delegate Delegate object
 */
+ (void)setDelegate:(id< ProBtnDelegate >)delegate;

/*! Get delegate
 @return Delegate object
 */
+ (id< ProBtnDelegate >)delegate;

@end

//----------------------------------------------//

@protocol ProBtnDelegate < NSObject >

@optional

/*! Open request
 @return return YES if the opening possible, otherwise NO.
 */
- (BOOL)proBtnWillOpen;

/*! Did open
 */
- (void)proBtnDidOpen;

/*! Close request
 @return return YES if the closing possible, otherwise NO.
 */
- (BOOL)proBtnWillClose;

/*! Did close
 */
- (void)proBtnDidClose;

/*! Show request
 @return return YES if the showing possible, otherwise NO.
 */
- (BOOL)proBtnWillShow;

/*! Did show
 */
- (void)proBtnDidShow;

/*! Hide request
 @return return YES if the hiding possible, otherwise NO.
 */
- (BOOL)proBtnWillHide;

/*! Did hide
 */
- (void)proBtnDidHide;

/*! Drag request
 @return return YES if the draging possible, otherwise NO.
 */
- (BOOL)proBtnWillDrag;

/*! Did drag
 */
- (void)proBtnDidDrag;

#if (PROBTN_VERSION >= PROBTN_VERSION_1_1)

/*! Show hint request
 @return return YES if the showing hint possible, otherwise NO.
 */
- (BOOL)proBtnWillHintShow;

/*! Did hint show
 */
- (void)proBtnDidHintShow;

/*! Hide hint request
 @return return YES if the hiding hint possible, otherwise NO.
 */
- (BOOL)proBtnWillHintHide;

/*! Did hint hide
 */
- (void)proBtnDidHintHide;

#endif

/*! Show hint request
 @return return YES if the showing hint possible, otherwise NO.
 */
- (BOOL)proBtnWillContentShow;

/*! Did content show
 */
- (void)proBtnDidContentShow;

/*! Hide content request
 @return return YES if the hiding content possible, otherwise NO.
 */
- (BOOL)proBtnWillContentHide;

/*! Did content hide
 */
- (void)proBtnDidContentHide;

/*! Will load content
 */
- (void)proBtnWillContentLoad;

/*! Did load content
 */
- (void)proBtnDidContentLoad;

/*! Error load content
 @param error Error descriptions
 */
- (void)proBtnContentError:(NSError*)error;

/*! Did settings synchronized
 */
- (void)proBtnDidSettingsSynchronized;

/*! Did statistics synchronized
 */
- (void)proBtnDidStatisticsSynchronized;

/*! Processing messages from WebView.
 Called if the WebView is trying to open a page from a template:
 @code
 event://method1/method2?arg1=value1&arg2=value2
 @endcode
 @param event List of methods
 @param args Pairs of args and value
 */
- (void)proBtnEvent:(NSArray*)event args:(NSDictionary*)args;

@end

//----------------------------------------------//

@protocol ProBtnSettings < NSObject >

@property(nonatomic, readonly) NSMutableDictionary* values;

@property(nonatomic, readwrite) UIEdgeInsets baseInsets;

@property(nonatomic, readwrite) BOOL buttonEnabled;
@property(nonatomic, readwrite) BOOL buttonVisible;

@property(nonatomic, readwrite) CGFloat buttonWeight;
@property(nonatomic, readwrite) CGFloat buttonDensity;
@property(nonatomic, readwrite) CGFloat buttonDragRatio;
@property(nonatomic, readwrite) BOOL buttonDragReflection;
@property(nonatomic, readwrite) UIEdgeInsets buttonOpenInsets;
@property(nonatomic, readwrite) CGPoint buttonPosition;
@property(nonatomic, readwrite) CGSize buttonSize;
@property(nonatomic, readwrite) CGSize buttonDragSize;
@property(nonatomic, readwrite) CGSize buttonOpenSize;
@property(nonatomic, readwrite) CGSize buttonInactiveSize;
@property(nonatomic, readwrite) CGFloat buttonOpacity;
@property(nonatomic, readwrite) CGFloat buttonDragOpacity;
@property(nonatomic, readwrite) CGFloat buttonOpenOpacity;
@property(nonatomic, readwrite) CGFloat buttonInactiveOpacity;
@property(nonatomic, readwrite, strong) UIImage* buttonImage;
@property(nonatomic, readwrite, strong) UIImage* buttonDragImage;
@property(nonatomic, readwrite, strong) UIImage* buttonOpenImage;
@property(nonatomic, readwrite, strong) UIImage* buttonInactiveImage;

@property(nonatomic, readwrite) CGPoint closePosition;
@property(nonatomic, readwrite) CGSize closeSize;
@property(nonatomic, readwrite) CGSize closeActiveSize;
@property(nonatomic, readwrite) CGFloat closeOpacity;
@property(nonatomic, readwrite) CGFloat closeActiveOpacity;
@property(nonatomic, readwrite, strong) UIImage* closeImage;
@property(nonatomic, readwrite, strong) UIImage* closeActiveImage;

@property(nonatomic, readwrite) UIEdgeInsets hintInsets;
@property(nonatomic, readwrite) UIEdgeInsets hintLabelInsets;
@property(nonatomic, readwrite) UIEdgeInsets hintImageInsets;
@property(nonatomic, readwrite, strong) NSString* hintText;
@property(nonatomic, readwrite, strong) UIFont* hintFont;
@property(nonatomic, readwrite, strong) UIColor* hintFontColor;
@property(nonatomic, readwrite) CGFloat hintOpacity;
@property(nonatomic, readwrite, strong) UIImage* hintImage;

@property(nonatomic, readwrite) CGSize hintArrowSize;
@property(nonatomic, readwrite) UIEdgeInsets hintArrowOffset;
@property(nonatomic, readwrite, strong) UIImage* hintArrowImageT;
@property(nonatomic, readwrite, strong) UIImage* hintArrowImageB;
@property(nonatomic, readwrite, strong) UIImage* hintArrowImageL;
@property(nonatomic, readwrite, strong) UIImage* hintArrowImageR;

@property(nonatomic, readwrite) UIEdgeInsets contentInsets;
@property(nonatomic, readwrite) UIEdgeInsets contentWebViewInsets;
@property(nonatomic, readwrite) UIEdgeInsets contentImageInsets;
@property(nonatomic, readwrite) CGSize contentSize;
@property(nonatomic, readwrite, strong) NSURL* contentURL;
@property(nonatomic, readwrite) CGFloat contentOpacity;
@property(nonatomic, readwrite, strong) UIColor* contentBackColor;
@property(nonatomic, readwrite) CGFloat contentBackOpacity;
@property(nonatomic, readwrite, strong) UIColor* contentActivityColor;
@property(nonatomic, readwrite, strong) UIImage* contentImage;

@property(nonatomic, readwrite) CGSize contentArrowSize;
@property(nonatomic, readwrite) UIEdgeInsets contentArrowOffset;
@property(nonatomic, readwrite, strong) UIImage* contentArrowImageT;
@property(nonatomic, readwrite, strong) UIImage* contentArrowImageB;
@property(nonatomic, readwrite, strong) UIImage* contentArrowImageL;
@property(nonatomic, readwrite, strong) UIImage* contentArrowImageR;

@property(nonatomic, readwrite) BOOL neverClose;

@property(nonatomic, readwrite, strong) NSString* campaignId;

#if (PROBTN_VERSION >= PROBTN_VERSION_1_1)
@property(nonatomic, readwrite, strong) UIColor* vendorColor;
@property(nonatomic, readwrite) CGFloat vendorOpacity;
@property(nonatomic, readwrite, strong) NSString* vendorText;
@property(nonatomic, readwrite, strong) NSURL* vendorURL;
@property(nonatomic, readwrite, strong) UIFont* vendorTextFont;
@property(nonatomic, readwrite, strong) UIColor* vendorTextColor;
#endif

#if (PROBTN_VERSION >= PROBTN_VERSION_1_1)
@property(nonatomic, readwrite) BOOL hideAfterFirstShow;
#endif

@property(nonatomic, readwrite) NSTimeInterval defaultDuration;
@property(nonatomic, readwrite) NSTimeInterval defaultDelay;

@property(nonatomic, readwrite) NSTimeInterval openDuration;
@property(nonatomic, readwrite) NSTimeInterval openDelay;
@property(nonatomic, readwrite) NSTimeInterval closeDuration;
@property(nonatomic, readwrite) NSTimeInterval closeDelay;

@property(nonatomic, readwrite) NSTimeInterval buttonShowDuration;
@property(nonatomic, readwrite) NSTimeInterval buttonShowDelay;
@property(nonatomic, readwrite) NSTimeInterval buttonHideDuration;
@property(nonatomic, readwrite) NSTimeInterval buttonHideDelay;
@property(nonatomic, readwrite) NSTimeInterval buttonDragDuration;
@property(nonatomic, readwrite) NSTimeInterval buttonDragDelay;
@property(nonatomic, readwrite) NSTimeInterval buttonUndragDuration;
@property(nonatomic, readwrite) NSTimeInterval buttonUndragDelay;
@property(nonatomic, readwrite) NSTimeInterval buttonInactiveDuration;
@property(nonatomic, readwrite) NSTimeInterval buttonInactiveDelay;

@property(nonatomic, readwrite) NSTimeInterval closeShowDuration;
@property(nonatomic, readwrite) NSTimeInterval closeShowDelay;
@property(nonatomic, readwrite) NSTimeInterval closeHideDuration;
@property(nonatomic, readwrite) NSTimeInterval closeHideDelay;
@property(nonatomic, readwrite) NSTimeInterval closeActiveDuration;
@property(nonatomic, readwrite) NSTimeInterval closeActiveDelay;
@property(nonatomic, readwrite) NSTimeInterval closeUnactiveDuration;
@property(nonatomic, readwrite) NSTimeInterval closeUnactiveDelay;

@property(nonatomic, readwrite) NSTimeInterval hintLaunchDuration;
@property(nonatomic, readwrite) NSTimeInterval hintLaunchDelay;
@property(nonatomic, readwrite) NSTimeInterval hintShowDuration;
@property(nonatomic, readwrite) NSTimeInterval hintShowDelay;
@property(nonatomic, readwrite) NSTimeInterval hintHideDuration;
@property(nonatomic, readwrite) NSTimeInterval hintHideDelay;

@property(nonatomic, readwrite) NSTimeInterval contentShowDuration;
@property(nonatomic, readwrite) NSTimeInterval contentShowDelay;
@property(nonatomic, readwrite) NSTimeInterval contentHideDuration;
@property(nonatomic, readwrite) NSTimeInterval contentHideDelay;

@end

//----------------------------------------------//

@protocol ProBtnStatistics < NSObject >

@property(nonatomic, readonly) NSMutableDictionary* values;

@property(nonatomic, readonly) NSUInteger usersCount;

@property(nonatomic, readonly) NSUInteger statisticOpened;
@property(nonatomic, readonly) NSUInteger statisticClosed;
@property(nonatomic, readonly) NSUInteger statisticMoved;
@property(nonatomic, readonly) NSUInteger statisticShowed;
@property(nonatomic, readonly) NSUInteger statisticHided;
@property(nonatomic, readonly) NSUInteger statisticHintShowed;
@property(nonatomic, readonly) NSUInteger statisticContentShowed;

/*! Count users by device type
 @code
 [[ProBtn serverStatistics] usersCountByDeviceType:"iphone"];
 @endcode
 @param deviceType Device type for examples: iphone, ipad or android
 */
- (NSUInteger)usersCountByDeviceType:(NSString*)deviceType;

@end

//----------------------------------------------//
