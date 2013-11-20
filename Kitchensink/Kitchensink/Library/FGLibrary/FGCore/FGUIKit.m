//----------------------------------------------//
/*                                                  */
/*  Author:         Alexander Trifonov              */
/*  Contact:        fgengine@gmail.com              */
/*                                                  */
//----------------------------------------------//

#import "FGUIKit.h"

//----------------------------------------------//

@implementation UINib (FG)

+ (id)createViewWithNibName:(NSString*)nibName withClass:(Class)class {
    UINib* nib = [UINib nibWithNibName:nibName bundle:nil];
    if(nib != nil) {
        NSArray* content = [nib instantiateWithOwner:nil options:nil];
        for(id item in content) {
            if([item isKindOfClass:class] == YES) {
                return item;
            }
        }
    }
    return nil;
}

+ (NSString*)nibNameByClass:(Class)class {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* name = NSStringFromClass(class);
    if([bundle pathForResource:name ofType:@"nib"] == nil) {
        switch(UI_USER_INTERFACE_IDIOM()) {
            case UIUserInterfaceIdiomPhone:
                name = [NSString stringWithFormat:@"%@%@", name, @"-iPhone"];
                if([bundle pathForResource:name ofType:@"nib"] == nil) {
                    name = nil;
                }
                break;
            case UIUserInterfaceIdiomPad:
                name = [NSString stringWithFormat:@"%@%@", name, @"-iPad"];
                if([bundle pathForResource:name ofType:@"nib"] == nil) {
                    name = nil;
                }
                break;
        }
    }
    return name;
}

@end

//----------------------------------------------//

@implementation UIWindow (FG)

+ (id)windowWithFrame:(CGRect)frame {
    return FG_SAFE_AUTORELEASE([[self alloc] initWithFrame:frame]);
}

@end

//----------------------------------------------//

@implementation UIView (FG)

- (void)setFramePosition:(CGPoint)framePosition {
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(framePosition.x, framePosition.y, frame.size.width, frame.size.height)];
}

- (CGPoint)framePosition {
    return [self frame].origin;
}

- (void)setFrameSize:(CGSize)frameSize {
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frameSize.width, frameSize.height)];
}

- (CGSize)frameSize {
    return [self frame].size;
}

- (void)setFrameX:(CGFloat)frameX {
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(frameX, frame.origin.y, frame.size.width, frame.size.height)];
}

- (CGFloat)frameX {
    return CGRectGetMinX([self frame]);
}

- (void)setFrameCX:(CGFloat)frameCX {
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frameCX - frame.origin.x, frame.size.height)];
}

- (CGFloat)frameCX {
    return CGRectGetMaxX([self frame]);
}

- (void)setFrameY:(CGFloat)frameY {
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(frame.origin.x, frameY, frame.size.width, frame.size.height)];
}

- (CGFloat)frameY {
    return CGRectGetMinY([self frame]);
}

- (void)setFrameCY:(CGFloat)frameCY {
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frameCY - frame.origin.y)];
}

- (CGFloat)frameCY {
    return CGRectGetMaxY([self frame]);
}

- (void)setFrameWidth:(CGFloat)frameWidth {
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frameWidth, frame.size.height)];
}

- (CGFloat)frameWidth {
    return CGRectGetWidth([self frame]);
}

- (void)setFrameHeight:(CGFloat)frameHeight {
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frameHeight)];
}

- (CGFloat)frameHeight {
    return CGRectGetHeight([self frame]);
}

- (void)setBoundsPosition:(CGPoint)boundsPosition {
    CGRect bounds = [self bounds];
    [self setBounds:CGRectMake(boundsPosition.x, boundsPosition.y, bounds.size.width, bounds.size.height)];
}

- (CGPoint)boundsPosition {
    return [self bounds].origin;
}

- (void)setBoundsSize:(CGSize)boundsSize {
    CGRect bounds = [self bounds];
    [self setBounds:CGRectMake(bounds.origin.x, bounds.origin.y, boundsSize.width, boundsSize.height)];
}

- (CGSize)boundsSize {
    return [self bounds].size;
}

- (void)setBoundsX:(CGFloat)boundsX {
    CGRect bounds = [self bounds];
    [self setBounds:CGRectMake(boundsX, bounds.origin.y, bounds.size.width, bounds.size.height)];
}

- (CGFloat)boundsX {
    return CGRectGetMinX([self bounds]);
}

- (void)setBoundsY:(CGFloat)boundsY {
    CGRect bounds = [self bounds];
    [self setBounds:CGRectMake(bounds.origin.x, boundsY, bounds.size.width, bounds.size.height)];
}

- (CGFloat)boundsY {
    return CGRectGetMinY([self bounds]);
}

- (void)setBoundsWidth:(CGFloat)boundsWidth {
    CGRect bounds = [self bounds];
    [self setBounds:CGRectMake(bounds.origin.x, bounds.origin.y, boundsWidth, bounds.size.height)];
}

- (CGFloat)boundsWidth {
    return CGRectGetWidth([self bounds]);
}

- (void)setBoundsHeight:(CGFloat)boundsHeight {
    CGRect bounds = [self bounds];
    [self setBounds:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, boundsHeight)];
}

- (CGFloat)boundsHeight {
    return CGRectGetHeight([self bounds]);
}

@end

//----------------------------------------------//

@implementation UIButton (FG)

+ (id)buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    id button = FG_SAFE_AUTORELEASE([[self alloc] initWithFrame:frame]);
    if(button != nil) {
        [button addTarget:target action:action forControlEvents:controlEvents];
    }
    return button;
}

@end

//----------------------------------------------//

@implementation UILabel (FG)

- (CGSize)implicitWidth:(CGFloat)width {
    if(FG_IOS_VERSION >= 7.0) {
    }
    return [[self text] sizeWithFont:[self font]
                   constrainedToSize:CGSizeMake(width, NSIntegerMax)
                       lineBreakMode:[self lineBreakMode]];
}

- (CGSize)implicitSize:(CGSize)constrainedSize {
    if(FG_IOS_VERSION >= 7.0) {
    }
    return [[self text] sizeWithFont:[self font]
                   constrainedToSize:constrainedSize
                       lineBreakMode:[self lineBreakMode]];
}

@end

//----------------------------------------------//

@implementation UIScrollView (FG)

- (CGSize)contentSizeFromSubviews {
    CGRect rect = CGRectZero;
    for(UIView* view in [self subviews]) {
        rect = CGRectUnion(rect, view.frame);
    }
    return rect.size;
}

@end

//----------------------------------------------//

@implementation UITableView (FG)

- (void)reloadDataAndRestoreSelectedRows {
    NSArray* indexPaths = [self indexPathsForSelectedRows];
    [self reloadData];
    for(NSIndexPath* indexPath in indexPaths) {
        [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

@end

//----------------------------------------------//

@implementation UITableViewCell (FG)

- (UITableView*)tableView {
    if([[self superview] isKindOfClass:[UITableView class]] == YES) {
        return (UITableView*)[self superview];
    }
    return nil;
}

@end

//----------------------------------------------//

@implementation UINavigationItem (FG)

- (void)setLeftBarView:(UIView*)view {
    [self setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
}

- (void)setRightBarView:(UIView*)view {
    [self setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
}

@end

//----------------------------------------------//

@implementation UIViewController (FG)

+ (id)newWithAppropriate {
    return FG_SAFE_AUTORELEASE([[self alloc] initWithNibName:[UINib nibNameByClass:[self class]] bundle:nil]);
}

@end

//----------------------------------------------//

@implementation UINavigationController (FG)

- (UIViewController*)rootViewController {
    NSArray* viewControllers = [self viewControllers];
    if([viewControllers count] > 0) {
        return [viewControllers objectAtIndex:0];
    }
    return nil;
}

@end

//----------------------------------------------//
