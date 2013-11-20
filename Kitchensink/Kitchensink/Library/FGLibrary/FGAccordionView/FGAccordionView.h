//----------------------------------------------//

#import "FGUIKit.h"

//----------------------------------------------//

@protocol FGAccordionViewDelegate;

//----------------------------------------------//

@interface FGAccordionView : UIView

@property(nonatomic, readwrite) NSInteger selectedIndex;
@property(nonatomic, strong) IBOutlet id< FGAccordionViewDelegate > delegate;
@property(nonatomic, readwrite) BOOL enabled;

- (void)addHeader:(id)header withView:(id)view;
- (void)removeHeaderAtIndex:(NSInteger)index;

@end

//----------------------------------------------//

@protocol FGAccordionViewDelegate <NSObject>

@optional
- (void)accordionView:(FGAccordionView*)accordionView didChangeSelectedIndex:(NSInteger)selectedIndex;

@end

//----------------------------------------------//
