//----------------------------------------------//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>

//----------------------------------------------//

#if __has_feature(objc_arc)
#   define FG_SAFE_AUTORELEASE(object)          object
#   define FG_SAFE_RETAIN(object)               object
#   define FG_SAFE_RELEASE(object)              object = nil
#   define FG_SAFE_DISPATCH_RELEASE(object)     object = nil
#   define FG_SAFE_BRIDGE(class, object)        (__bridge class)object
#   define FG_SAFE_UNRETAINED(class)            __unsafe_unretained class
#   define FG_SAFE_DEALLOC                      /**/
#else
#   define FG_SAFE_AUTORELEASE(object)          [object autorelease]
#   define FG_SAFE_RETAIN(object)               [object retain]
#   define FG_SAFE_RELEASE(object)              [object release]; object = nil
#   define FG_SAFE_DISPATCH_RELEASE(object)     dispatch_release(object); object = nil
#   define FG_SAFE_BRIDGE(class, object)        (class)object
#   define FG_SAFE_UNRETAINED(class)            class
#   define FG_SAFE_DEALLOC                      [super dealloc];
#endif
#define FG_SAFE_SETTER(object, value)           FG_SAFE_RELEASE(object); object = FG_SAFE_RETAIN(value)

//----------------------------------------------//
