#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "main.h"
#import "welcome.h"
//Rename the views///////////////////////////////////////////
@implementation WelcomeBlurEffect: UIBlurEffect            // 
@end                                                       //
@implementation WelcomeBlurEffectView: UIVisualEffectView  //
@end                                                       //
/////////////////////////////////////////////////////////////


@implementation WelcomeView: UIView
-(id)initWithFrame:(CGRect)theFrame {
    self = [super initWithFrame:theFrame];
    if (self) {
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]
        initWithTarget:self
        action:@selector(handleTapFromUser:)
    ];
    [self addGestureRecognizer:dismissTap];
    }
    return self;
}

-(void)setupAllViewsAndPresent {
    welcomeShowing = true;
    self.backgroundColor = [UIColor clearColor];
    UIBlurEffect *welcomeBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    WelcomeBlurEffectView *welcomeBlurEffectView = [[WelcomeBlurEffectView alloc] initWithEffect:welcomeBlurEffect];
    welcomeBlurEffectView.frame = [[UIScreen mainScreen] bounds];
    welcomeBlurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:welcomeBlurEffectView];
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    [mainWindow addSubview:self];
    self.alpha = 0.0f;
    [UIView animateWithDuration:4.0 animations:^() {
        self.alpha = 1.0f;
    }];

}

-(void)handleTapFromUser: (UITapGestureRecognizer *)recognizer {
    [UIView animateWithDuration:4.0 animations:^() {
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = true;
        welcomeShowing = false;
    }];
}
@end



%group welcome
%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)arg {
    %orig(arg);

    NSLog (@"[Main BoilerPlate]: [Welcome]: Preparing welcome view.");
    WelcomeView *welcomeView = [[WelcomeView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [welcomeView setupAllViewsAndPresent];

/*
    NSString *titleText = @"DevKit";
    //CGSize *titleLabelSize = [titleText sizeWithAttributes:@{NSFontAttributeName: [UIFont systemOfSize:17.0f]}];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,30,300,50)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    titleLabel.text = titleText;
    [blurEffectView addSubview:titleLabel];
*/
    NSLog (@"[Main BoilerPlate]: [Welcome]: Alerting");
}
%end
%end
extern "C" void welcome() {
    %init(welcome);
}