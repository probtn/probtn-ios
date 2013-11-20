//----------------------------------------------//
/*                                                  */
/*  Author:         Alexander Trifonov              */
/*  Contact:        fgengine@gmail.com              */
/*                                                  */
//----------------------------------------------//

#import "FGSlideNavigation.h"

//----------------------------------------------//

#define FG_SLIDE_NAVIGATION_THRESHOLD_VELOCITY      450.0f

//----------------------------------------------//

typedef enum {
	FGSlideNavigationStateClose = 0,
	FGSlideNavigationStateOpen
} FGSlideNavigationState;

//----------------------------------------------//

@interface FGSlideNavigation () < UIGestureRecognizerDelegate > {
    UIViewController* mMenuViewController;
    UIViewController* mContentViewController;
    UIView* mMenuView;
    UIView* mContentView;
    UIPanGestureRecognizer* mPanGesture;
    UITapGestureRecognizer* mTapGesture;
    
    FGSlideNavigationState mState;
    FGSlideNavigationDirection mDirection;
    CGFloat mMenuViewWidth;
    UIColor* mMenuOpenShadowColor;
    CGFloat mMenuOpenShadowRadius;
    UIColor* mContentOpenShadowColor;
    CGFloat mContentOpenShadowRadius;
}

- (void)updateViews;

- (void)setMenuViewController:(UIViewController*)menuViewController;
- (void)setContentViewController:(UIViewController*)contentViewController;

- (UIView*)menuView;
- (UIView*)contentView;

- (void)tapGestureHandle:(UITapGestureRecognizer*)tapGesture;
- (void)panGestureHandle:(UIPanGestureRecognizer*)panGesture;

- (void)panProccessFromDeltaPosition:(CGPoint)deltaPosition;

- (CGRect)menuOpenFrame;
- (CGRect)menuCloseFrame;
- (CGRect)contentOpenFrame;
- (CGRect)contentCloseFrame;
- (NSTimeInterval)durationFromStartRect:(CGRect)startRect finishRect:(CGRect)finishRect velocity:(CGFloat)velocity;

@end

//----------------------------------------------//

@implementation FGSlideNavigation

@synthesize direction = mDirection;
@synthesize menuViewController = mMenuViewController;
@synthesize contentViewController = mContentViewController;
@synthesize menuViewWidth = mMenuViewWidth;

+ (id)slideNafigationWithMenuViewController:(UIViewController*)menuViewController contentViewController:(UIViewController*)contentViewController {
    return FG_SAFE_AUTORELEASE([[self alloc] initWithMenuViewController:menuViewController contentViewController:contentViewController]);
}

- (id)initWithMenuViewController:(UIViewController*)menuViewController contentViewController:(UIViewController*)contentViewController {
	self = [super init];
	if(self != nil) {
        mMenuViewWidth = 280.0f;
        mMenuOpenShadowRadius = 8.0f;
        mMenuOpenShadowColor = FG_SAFE_RETAIN([UIColor blackColor]);
        mContentOpenShadowRadius = 8.0f;
        mContentOpenShadowColor = FG_SAFE_RETAIN([UIColor blackColor]);

		[self setMenuViewController:menuViewController];
		[self setContentViewController:contentViewController];
	}
	return self;
}

- (void)dealloc {
    FG_SAFE_RELEASE(mMenuViewController);
    FG_SAFE_RELEASE(mContentViewController);
    FG_SAFE_RELEASE(mMenuView);
    FG_SAFE_RELEASE(mContentView);
    FG_SAFE_RELEASE(mPanGesture);
    FG_SAFE_RELEASE(mTapGesture);
    
    FG_SAFE_RELEASE(mMenuOpenShadowColor);
    FG_SAFE_RELEASE(mContentOpenShadowColor);
    
    FG_SAFE_DEALLOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(FG_IOS_VERSION >= 7.0) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [[self view] setClipsToBounds:YES];

    mPanGesture = FG_SAFE_RETAIN([[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)]);
    [mPanGesture setDelegate:self];
    [[self view] addGestureRecognizer:mPanGesture];
    
    mTapGesture = FG_SAFE_RETAIN([[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)]);
    [mTapGesture setDelegate:self];
    [[self view] addGestureRecognizer:mTapGesture];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    [self updateViews];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[self view] setNeedsLayout];
}

- (void)updateViews {
    
    switch(mState) {
        case FGSlideNavigationStateOpen:
            [mMenuView setFrame:[self menuOpenFrame]];
            [mContentView setFrame:[self contentOpenFrame]];
            break;
        case FGSlideNavigationStateClose:
            [mMenuView setFrame:[self menuCloseFrame]];
            [mContentView setFrame:[self contentCloseFrame]];
            break;
    }
    [[mMenuView layer] setShadowPath:[[UIBezierPath bezierPathWithRect:[mMenuView bounds]] CGPath]];
    [[mContentView layer] setShadowPath:[[UIBezierPath bezierPathWithRect:[mContentView bounds]] CGPath]];
}

- (void)setMenuViewController:(UIViewController*)menuViewController {
	if (mMenuViewController != menuViewController) {
        if(mMenuViewController != nil) {
            [mMenuViewController willMoveToParentViewController:nil];
            [[mMenuViewController view] removeFromSuperview];
            [mMenuViewController removeFromParentViewController];
		}
        FG_SAFE_SETTER(mMenuViewController, menuViewController);
        if(mMenuViewController != nil) {
            [self addChildViewController:mMenuViewController];
            [[mMenuViewController view] setFrame:[[self menuView] bounds]];
            [[self menuView] addSubview:[mMenuViewController view]];
            [mMenuViewController didMoveToParentViewController:self];
        }
	}
}

- (void)changeMenuViewController:(UIViewController*)menuViewController closeMenu:(BOOL)closeMenu {
    [self setMenuViewController:menuViewController];
    if(closeMenu == YES) {
        [self closeMenu];
    }
}

- (void)setContentViewController:(UIViewController*)contentViewController {
	if (mContentViewController != contentViewController) {
        if(mContentViewController != nil) {
            [mContentViewController willMoveToParentViewController:nil];
            [[mContentViewController view] removeFromSuperview];
            [mContentViewController removeFromParentViewController];
        }
        FG_SAFE_SETTER(mContentViewController, contentViewController);
        if(mContentViewController != nil) {
            [self addChildViewController:mContentViewController];
            [[mContentViewController view] setFrame:[[self contentView] bounds]];
            [[self contentView] addSubview:mContentViewController.view];
            [mContentViewController didMoveToParentViewController:self];
        }
	}
}

- (void)changeContentViewController:(UIViewController*)contentViewController closeMenu:(BOOL)closeMenu {
    [self setContentViewController:contentViewController];
    if(closeMenu == YES) {
        [self closeMenu];
    }
}

- (void)setMenuViewWidth:(CGFloat)menuViewWidth {
    if(mMenuViewWidth != menuViewWidth) {
        mMenuViewWidth = menuViewWidth;
        
        [self updateViews];
    }
}

- (UIView*)menuView {
    if(mMenuView == nil) {
        mMenuView = FG_SAFE_RETAIN([[UIView alloc] initWithFrame:[self menuCloseFrame]]);
        [mMenuView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [mMenuView setBackgroundColor:[UIColor clearColor]];
        [[mMenuView layer] setShadowColor:[mMenuOpenShadowColor CGColor]];
        [[mMenuView layer] setShadowRadius:mMenuOpenShadowRadius];
        [[mMenuView layer] setShadowPath:[[UIBezierPath bezierPathWithRect:[mMenuView bounds]] CGPath]];
        [[mMenuView layer] setMasksToBounds:NO];
        [[self view] insertSubview:mMenuView atIndex:0];
    }
    return mMenuView;
}

- (UIView*)contentView {
    if(mContentView == nil) {
        mContentView = FG_SAFE_RETAIN([[UIView alloc] initWithFrame:[[self view] bounds]]);
        [mMenuView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [mContentView setBackgroundColor:[UIColor clearColor]];
        [[mContentView layer] setShadowColor:[mContentOpenShadowColor CGColor]];
        [[mContentView layer] setShadowRadius:mContentOpenShadowRadius];
        [[mContentView layer] setShadowPath:[[UIBezierPath bezierPathWithRect:[mContentView bounds]] CGPath]];
        [[mContentView layer] setMasksToBounds:NO];
        [[self view] insertSubview:mContentView atIndex:1];
    }
    return mContentView;
}

- (void)toggleMenu {
    if(mState == FGSlideNavigationStateOpen) {
        [self closeMenu];
    } else {
        [self openMenu];
    }
}

- (void)openMenu {
    if(mState == FGSlideNavigationStateClose) {
        [mPanGesture setEnabled:NO];
        [mTapGesture setEnabled:NO];
        [self openMenuWithVelocity:0.0f];
        [mTapGesture setEnabled:YES];
        [mPanGesture setEnabled:YES];
    }
}

- (void)openMenuWithVelocity:(CGFloat)velocity {
    mState = FGSlideNavigationStateOpen;
	CGRect currentMenu = [[self menuView] frame];
	CGRect finalMenu = [self menuOpenFrame];
	CGRect finalContent = [self contentOpenFrame];
	[UIView animateWithDuration:[self durationFromStartRect:currentMenu finishRect:finalMenu velocity:velocity]
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [[[self menuView] layer] setShadowOpacity:1.0f];
                         [[self menuView] setFrame:finalMenu];
                         [[[self contentView] layer] setShadowOpacity:1.0f];
                         [[self contentView] setFrame:finalContent];
                     } completion:^(BOOL finished) {
                     }];
}

- (void)closeMenu {
    if(mState == FGSlideNavigationStateOpen) {
        [mPanGesture setEnabled:NO];
        [mTapGesture setEnabled:NO];
        [self closeMenuWithVelocity:0.0f];
        [mTapGesture setEnabled:YES];
        [mPanGesture setEnabled:YES];
    }
}

- (void)closeMenuWithVelocity:(CGFloat)velocity {
    mState = FGSlideNavigationStateClose;
	CGRect currentMenu = [[self menuView] frame];
	CGRect finalMenu = [self menuCloseFrame];
	CGRect finalContent = [self contentCloseFrame];
	[UIView animateWithDuration:[self durationFromStartRect:currentMenu finishRect:finalMenu velocity:velocity]
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [[self menuView] setFrame:finalMenu];
                         [[self contentView] setFrame:finalContent];
                     } completion:^(BOOL finished) {
                         [[[self menuView] layer] setShadowOpacity:0.0f];
                         [[[self contentView] layer] setShadowOpacity:0.0f];
                     }];
}

- (void)tapGestureHandle:(UITapGestureRecognizer*)tapGesture {
    [self toggleMenu];
}

- (void)panGestureHandle:(UIPanGestureRecognizer*)panGesture {
    static CGPoint previousPosition;
    static CGPoint beganPosition;
	static BOOL beganMenuOpen;
    
    CGPoint currentPosition = [panGesture locationInView:[self view]];
	switch([panGesture state]) {
		case UIGestureRecognizerStateBegan: {
            beganPosition = currentPosition;
			beganMenuOpen = (mState == FGSlideNavigationStateOpen);
			[mMenuViewController beginAppearanceTransition:beganMenuOpen animated:YES];
			break;
        }
		case UIGestureRecognizerStateChanged: {
            CGPoint deltaPosition = CGPointMake(currentPosition.x - previousPosition.x, currentPosition.y - previousPosition.y);
            [self panProccessFromDeltaPosition:deltaPosition];
			break;
		}
		case UIGestureRecognizerStateEnded: {
            FGSlideNavigationState state = mState;
			[mMenuViewController beginAppearanceTransition:(beganMenuOpen == NO) animated:YES];
			CGPoint velocity = [panGesture velocityInView:[panGesture view]];
            switch(mDirection) {
                case FGSlideNavigationDirectionLeft: {
                    if(velocity.x >= FG_SLIDE_NAVIGATION_THRESHOLD_VELOCITY) {
                        state = FGSlideNavigationStateOpen;
                    } else if(velocity.x <= -FG_SLIDE_NAVIGATION_THRESHOLD_VELOCITY) {
                        state = FGSlideNavigationStateClose;
                    }
                    break;
                }
                case FGSlideNavigationDirectionRight: {
                    if(velocity.x >= -FG_SLIDE_NAVIGATION_THRESHOLD_VELOCITY) {
                        state = FGSlideNavigationStateOpen;
                    } else if(velocity.x <= FG_SLIDE_NAVIGATION_THRESHOLD_VELOCITY) {
                        state = FGSlideNavigationStateClose;
                    }
                    break;
                }
            }
            if(mState == state) {
                CGFloat threshold = mMenuViewWidth * 0.2f;
                CGPoint deltaPosition = CGPointMake(currentPosition.x - beganPosition.x, currentPosition.y - beganPosition.y);
                switch(mDirection) {
                    case FGSlideNavigationDirectionLeft:
                        if(state == FGSlideNavigationStateOpen) {
                            if(deltaPosition.x <= threshold) {
                                state = FGSlideNavigationStateClose;
                            }
                        } else {
                            if(deltaPosition.x >= threshold) {
                                state = FGSlideNavigationStateOpen;
                            }
                        }
                        break;
                    case FGSlideNavigationDirectionRight:
                        if(state == FGSlideNavigationStateOpen) {
                            if(deltaPosition.x >= threshold) {
                                state = FGSlideNavigationStateClose;
                            }
                        } else {
                            if(deltaPosition.x <= threshold) {
                                state = FGSlideNavigationStateOpen;
                            }
                        }
                        break;
                }
                velocity = CGPointZero;
            }
            if(state == FGSlideNavigationStateOpen) {
                [self openMenuWithVelocity:velocity.x];
            } else {
                [self closeMenuWithVelocity:velocity.x];
            }
			break;
		}
		default:
			break;
	}
    previousPosition = currentPosition;
}

- (void)panProccessFromDeltaPosition:(CGPoint)deltaPosition {
    CGRect menuOpenFrame = [self menuOpenFrame];
    CGRect menuCloseFrame = [self menuCloseFrame];
    CGRect menuFrame = [[self menuView] frame];
    CGRect contentOpenFrame = [self contentOpenFrame];
    CGRect contentCloseFrame = [self contentCloseFrame];
    CGRect contentFrame = [[self contentView] frame];
    switch(mDirection) {
        case FGSlideNavigationDirectionLeft:
        case FGSlideNavigationDirectionRight: {
            menuFrame = CGRectOffset(menuFrame, deltaPosition.x, 0.0f);
            contentFrame = CGRectOffset(contentFrame, deltaPosition.x, 0.0f);
            break;
        }
    }
    CGFloat proccess = 0.0f;
    switch(mDirection) {
        case FGSlideNavigationDirectionLeft:
            menuFrame.origin.x = MIN(menuFrame.origin.x, menuOpenFrame.origin.x);
            menuFrame.origin.x = MAX(menuFrame.origin.x, menuCloseFrame.origin.x);
            contentFrame.origin.x = MIN(contentFrame.origin.x, contentOpenFrame.origin.x);
            contentFrame.origin.x = MAX(contentFrame.origin.x, contentCloseFrame.origin.x);
            proccess = (menuFrame.origin.x - menuCloseFrame.origin.x) / mMenuViewWidth;
            break;
        case FGSlideNavigationDirectionRight:
            menuFrame.origin.x = MAX(menuFrame.origin.x, menuOpenFrame.origin.x);
            menuFrame.origin.x = MIN(menuFrame.origin.x, menuCloseFrame.origin.x);
            contentFrame.origin.x = MAX(contentFrame.origin.x, contentOpenFrame.origin.x);
            contentFrame.origin.x = MIN(contentFrame.origin.x, contentCloseFrame.origin.x);
            proccess = (menuCloseFrame.origin.x - menuFrame.origin.x) / mMenuViewWidth;
            break;
    }
    [[[self contentView] layer] setShadowOpacity:proccess];
    [[self contentView] setFrame:contentFrame];
    [[[self menuView] layer] setShadowOpacity:proccess];
    [[self menuView] setFrame:menuFrame];
}

- (CGRect)menuOpenFrame {
    CGSize size = [[self view] boundsSize];
    switch(mDirection) {
        case FGSlideNavigationDirectionLeft:
            return CGRectMake(0, 0, mMenuViewWidth, size.height);
            break;
        case FGSlideNavigationDirectionRight:
            return CGRectMake(size.width - mMenuViewWidth, 0, mMenuViewWidth, size.height);
            break;
    }
    return CGRectZero;
}

- (CGRect)menuCloseFrame {
    CGSize size = [[self view] boundsSize];
    switch(mDirection) {
        case FGSlideNavigationDirectionLeft:
            return CGRectMake(-mMenuViewWidth, 0, mMenuViewWidth, size.height);
            break;
        case FGSlideNavigationDirectionRight:
            return CGRectMake(size.width, 0, mMenuViewWidth, size.height);
            break;
    }
    return CGRectZero;
}

- (CGRect)contentOpenFrame {
    CGSize size = [[self view] boundsSize];
    switch(mDirection) {
        case FGSlideNavigationDirectionLeft:
            return CGRectMake(mMenuViewWidth, 0, size.width, size.height);
            break;
        case FGSlideNavigationDirectionRight:
            return CGRectMake(-mMenuViewWidth, 0, size.width, size.height);
            break;
    }
    return CGRectZero;
}

- (CGRect)contentCloseFrame {
    return [[self view] bounds];
}

- (NSTimeInterval)durationFromStartRect:(CGRect)startRect finishRect:(CGRect)finishRect velocity:(CGFloat)velocity {
    NSTimeInterval duration = 0.4f;
	if(velocity != 0.0f) {
        CGFloat delta = 0.0f;
        switch(mDirection) {
            case FGSlideNavigationDirectionLeft:
            case FGSlideNavigationDirectionRight:
                delta = fabs(startRect.origin.x - finishRect.origin.x);
                break;
        }
		duration = fmax(0.1f, fmin(delta / velocity, 1.0f));
	}
    return duration;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    BOOL result = NO;
	CGPoint point = [touch locationInView:[self view]];
	if(gestureRecognizer == mPanGesture) {
        if(mState == FGSlideNavigationStateClose) {
            CGRect navigationBarRect = CGRectNull;
            if([mContentViewController isKindOfClass:[UINavigationController class]] == YES) {
                UINavigationBar* navBar = [(UINavigationController*)mContentViewController navigationBar];
                navigationBarRect = [navBar convertRect:[navBar frame] toView:[self view]];
                navigationBarRect = CGRectIntersection(navigationBarRect, [[self view] bounds]);
            }
            result = CGRectContainsPoint(navigationBarRect, point);
        } else {
            result = (CGRectContainsPoint([mMenuView frame], point) == NO);
        }
	} else if(gestureRecognizer == mTapGesture) {
        if(mState == FGSlideNavigationStateOpen) {
            result = (CGRectContainsPoint([mMenuView frame], point) == NO);
        }
	}
	return result;
}

@end

//----------------------------------------------//
