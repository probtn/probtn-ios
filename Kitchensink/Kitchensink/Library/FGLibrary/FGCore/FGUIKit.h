//----------------------------------------------//

#import "FGCore.h"

//----------------------------------------------//

#define FG_IOS_VERSION                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define FG_IPHONE                               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define FG_IPAD                                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define FG_COLOR_BYTE(r, g, b, a)               [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a) / 255.0f]

//----------------------------------------------//

@interface UINib (FG)

+ (id)createViewWithNibName:(NSString*)nibName withClass:(Class)class;

+ (NSString*)nibNameByClass:(Class)class;

@end

//----------------------------------------------//

@interface UIWindow (FG)

+ (id)windowWithFrame:(CGRect)frame;

@end

//----------------------------------------------//

@interface UIView (FG)

@property(nonatomic, readwrite) CGPoint framePosition;
@property(nonatomic, readwrite) CGSize frameSize;

@property(nonatomic, readwrite) CGFloat frameX;
@property(nonatomic, readwrite) CGFloat frameCX;
@property(nonatomic, readwrite) CGFloat frameY;
@property(nonatomic, readwrite) CGFloat frameCY;
@property(nonatomic, readwrite) CGFloat frameWidth;
@property(nonatomic, readwrite) CGFloat frameHeight;

@property(nonatomic, readwrite) CGPoint boundsPosition;
@property(nonatomic, readwrite) CGSize boundsSize;

@property(nonatomic, readwrite) CGFloat boundsX;
@property(nonatomic, readwrite) CGFloat boundsY;
@property(nonatomic, readwrite) CGFloat boundsWidth;
@property(nonatomic, readwrite) CGFloat boundsHeight;

@end

//----------------------------------------------//

@interface UIButton (FG)

+ (id)buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end

//----------------------------------------------//

@interface UILabel (FG)

- (CGSize)implicitWidth:(CGFloat)width;
- (CGSize)implicitSize:(CGSize)size;

@end

//----------------------------------------------//

@interface UIScrollView (FG)

- (CGSize)contentSizeFromSubviews;

@end

//----------------------------------------------//

@interface UITableView (FG)

- (void)reloadDataAndRestoreSelectedRows;

@end

//----------------------------------------------//

@interface UITableViewCell (FG)

- (UITableView*)tableView;

@end

//----------------------------------------------//

@interface UINavigationItem (FG)

- (void)setLeftBarView:(UIView*)view;
- (void)setRightBarView:(UIView*)view;

@end

//----------------------------------------------//

@interface UIViewController (FG)

+ (id)newWithAppropriate;

@end

//----------------------------------------------//

@interface UINavigationController (FG)

- (UIViewController*)rootViewController;

@end

//----------------------------------------------//
