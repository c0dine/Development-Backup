#import <UIKit/UIKit.h>
@interface WelcomeView: UIView
- (void)setupAllViewsAndPresent;
- (void)handleTapFromUser: (UITapGestureRecognizer *)recognizer;
@end
@interface WelcomeBlurEffect: UIBlurEffect
@end
@interface WelcomeBlurEffectView: UIVisualEffectView
@end