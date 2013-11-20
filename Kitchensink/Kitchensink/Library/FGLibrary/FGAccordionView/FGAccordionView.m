//----------------------------------------------//

#import "FGAccordionView.h"

//----------------------------------------------//

@interface FGAccordionView () {
    NSMutableArray* mHeaders;
    NSMutableArray* mViews;
    
    NSInteger mSelectedIndex;
    id< FGAccordionViewDelegate > mDelegate;
    BOOL mEnabled;
}

- (void)initialize;
- (void)animateHeader:(UIView*)header headerFrame:(CGRect)headerFrame view:(UIView*)view viewFrame:(CGRect)viewFrame viewOpacity:(CGFloat)viewOpacity;

@end

//----------------------------------------------//

@implementation FGAccordionView

@synthesize selectedIndex = mSelectedIndex;
@synthesize delegate = mDelegate;
@synthesize enabled = mEnabled;

- (id)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    mHeaders = FG_SAFE_RETAIN([NSMutableArray array]);
    mViews = FG_SAFE_RETAIN([NSMutableArray array]);
    mSelectedIndex = NSNotFound;
    mEnabled = YES;
    
    [self setUserInteractionEnabled:YES];
}

- (void)dealloc {
    FG_SAFE_RELEASE(mHeaders);
    FG_SAFE_RELEASE(mViews);
    FG_SAFE_DEALLOC;
}

- (void)setEnabled:(BOOL)enabled {
    if(mEnabled != enabled) {
        mEnabled = enabled;
    }
}

- (void)addHeader:(id)header withView:(id)view {
    if((header != nil) && (view != nil)) {
        [mHeaders addObject:header];
        [mViews addObject:view];
        
        [header setFrameX:0.0f];
        [header setFrameWidth:[self frameWidth]];
        [header setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        [view setFrameX:0.0f];
        [view setFrameWidth:[self frameWidth]];
        [view setAlpha:0.0f];
        [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [view setClipsToBounds:YES];
        
        [self addSubview:header];
        [self addSubview:view];
        
        if([header respondsToSelector:@selector(addTarget:action:forControlEvents:)] == YES) {
            [header addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
        }
        [header setTag:[mHeaders count] - 1];
        if(mSelectedIndex == NSNotFound) {
            [self setSelectedIndex:0];
        }
        [self setNeedsLayout];
    }
}

- (void)removeHeaderAtIndex:(NSInteger)index {
    if(index < [mHeaders count]) {
        for(UIView* header in mHeaders) {
            if([header tag] > index) {
                [header setTag:[header tag] - 1];
            }
        }
        UIView* header = [mHeaders objectAtIndex:index];
        [mHeaders removeObjectAtIndex:index];
        [header removeFromSuperview];
        UIView* view = [mViews objectAtIndex:index];
        [mViews removeObjectAtIndex:index];
        [view removeFromSuperview];
        [self setNeedsLayout];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if(mSelectedIndex != selectedIndex) {
        mSelectedIndex = selectedIndex;
        if([mDelegate respondsToSelector:@selector(accordionView:didChangeSelectedIndex:)] == YES) {
            [mDelegate accordionView:self didChangeSelectedIndex:selectedIndex];
        }
        [self setNeedsLayout];
    }
}

- (void)touchDown:(id)sender {
    if(mEnabled == YES) {
        [self setSelectedIndex:[sender tag]];
    }
}

- (void)layoutSubviews {
    CGSize frameSize = [self frameSize];
    CGFloat headersHeight = 0.0f;
    for(UIView* header in mHeaders) {
        headersHeight += [header frameHeight];
    }
    CGFloat offset = 0.0f;
    for(NSUInteger i = 0; i < [mViews count]; i++) {
        UIView* header = [mHeaders objectAtIndex:i];
        CGRect headerFrame = [header frame];
        UIView* view = [mViews objectAtIndex:i];
        CGRect viewFrame = [view frame];
        
        headerFrame.origin.y = offset;
        offset += headerFrame.size.height;
        
        if(mSelectedIndex == i) {
            [self animateHeader:header
                    headerFrame:headerFrame
                           view:view
                      viewFrame:CGRectMake(viewFrame.origin.x, offset, frameSize.width, frameSize.height - headersHeight)
                    viewOpacity:1.0f];
            offset += frameSize.height - headersHeight;
        } else {
            [self animateHeader:header
                    headerFrame:headerFrame
                           view:view
                      viewFrame:CGRectMake(viewFrame.origin.x, offset, frameSize.width, 0.0f)
                    viewOpacity:0.0f];
        }
    }
}

- (void)animateHeader:(UIView*)header headerFrame:(CGRect)headerFrame view:(UIView*)view viewFrame:(CGRect)viewFrame viewOpacity:(CGFloat)viewOpacity {
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseOut)
                     animations:^{
                         [header setFrame:headerFrame];
                         [view setFrame:viewFrame];
                         [view setAlpha:viewOpacity];
                     }
                     completion:nil];
}

@end

//----------------------------------------------//
