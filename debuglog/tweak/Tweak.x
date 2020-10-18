/*
 * Tweak.x
 * debugLog
 *
 * Created by c0dine <c0dineDev@gmail.com> on 2020/08/20.
 * Copyright © 2020 c0dine <c0dineDev@gmail.com>. All rights reserved.
 *
 *	////DEFINITIONS///////////////////////////////////////////////////////////////////////////////
 *	// %log: Logs everything about a certain method                                             //
 *	// %hook: Creates a pointer swap at that Class's functions                                  //
 *	// %ctor: Calls this code before creating a pointer swap                                    //
 *	// (%group/%end): Groups hooks to call conditionally                                        //
 *	// %orig: Run the methods original code (can be called conditionally)                       //
 *	// %orig(arguments): Call the original code with custom arguments (requires all arguments)  //
 *	//////////////////////////////////////////////////////////////////////////////////////////////
 */
#import <Foundation/Foundation.h>
#include "../.resources/logging/RemoteLog.h"
#import <UIKit/UIkit.h>
#import "Tweak.h"
#import <OSLog/OSLog.h>
MainPane *pane = nil;
UIWindow* keyWindow() { 
    UIWindow *foundWindow = nil;
    NSArray *windows = [[UIApplication sharedApplication]windows];
    for (UIWindow *window in windows) {
        if (window.isKeyWindow) {
            foundWindow = window;
            break;
        }
    }
    return foundWindow; 
}
UIScene* mainWindowScene() { 
    UIScene *foundScene = nil;
    NSSet *scenes = [[UIApplication sharedApplication] connectedScenes];
    for (UIScene *scene in scenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            foundScene = scene;
            break;
        }
    }
    return foundScene;
}

@implementation MainPane: UIView
@synthesize logger;
-(id)initWithFrame:(CGRect)frame logger:(Logger*)newLogger {
    self = [super initWithFrame:frame];
    if (self) {
        self.logger = newLogger;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] 
        initWithTarget:self
        action:@selector(handlePan:)
    ];
    [self addGestureRecognizer:pan];
    [self.logger log:@"Added pan gesture to the MainPane"];
    [self setup]; // setup our view for presentation
    }
    return self;
}

-(void)handlePan: (UIPanGestureRecognizer *)recognizer {
    UIEdgeInsets safeArea = keyWindow().safeAreaInsets;
    if (recognizer.state == UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [recognizer translationInView:recognizer.view]; 
        CGSize thisSize = recognizer.view.bounds.size; 
        CGSize superviewSize = [[UIScreen mainScreen] bounds].size;
        CGPoint center = CGPointMake(recognizer.view.center.x + translation.x,
                                    recognizer.view.center.y + translation.y);

        CGPoint resetTranslation = CGPointMake(translation.x, translation.y); 

        if(center.x - thisSize.width/2 < 0) { 
            center.x = thisSize.width/2;
        } else if (center.x + thisSize.width/2 > superviewSize.width) {
            center.x = superviewSize.width-thisSize.width/2;
        } else {
            resetTranslation.x = 0; 
        }
        if(center.y - thisSize.height/2 < 0 + safeArea.top) {
            center.y = thisSize.height/2 + safeArea.top;
        } else if (center.y + thisSize.height /2 > superviewSize.height - safeArea.bottom) {
            center.y = superviewSize.height-thisSize.height/2-safeArea.bottom;
        } else {
            resetTranslation.y = 0;
        }

        recognizer.view.center = center; 
        [recognizer setTranslation:CGPointMake(0, 0) inView:self]; 
    }
}
-(void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius { 
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
        byRoundingCorners:corners 
        cornerRadii:CGSizeMake(radius, radius)
    ];
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    [mask setPath:path.CGPath];
    [self.layer setMask:mask];
    self.translatesAutoresizingMaskIntoConstraints = true;
    [self.logger log:@"Gave selected corners a corner radius of: %f", radius];
}

-(void)setup { // Preperation
    self.backgroundColor = [UIColor clearColor];
    [self roundCorners:UIRectCornerAllCorners radius:36];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial]]; 
    blurView.layer.borderColor = [UIColor clearColor].CGColor;
    blurView.layer.borderWidth = 10.0f;
    [blurView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:blurView];
    [self.logger log:@"Added a blur ;)"];
}
@end

@implementation logView: UITextView
-(void)scrollToBottom {
    if(self.text.length > 0 ) {
        NSRange bottom = NSMakeRange(self.text.length -1, 1);
        [self scrollRangeToVisible:bottom];
    }
}
-(void)addText:(NSString*)newText{
    self.text = [self.text stringByAppendingString:newText];
    self.scrollEnabled = false;
    self.scrollEnabled = true;
    [self scrollToBottom];
}
-(void)setup {
    self.editable = false;
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor colorWithRed: 0.14 green: 0.18 blue: 0.18 alpha: 0.4];
    self.textColor = [UIColor whiteColor];
}
@end

@implementation Logger: NSObject
@synthesize logger;
-(void)log:(NSString *)format, ...{
    va_list args;
    va_start(args,format);
    NSString *text = [@"\n[com.c0dine.debugLog]: \n" stringByAppendingString:[[[NSString alloc] initWithFormat:format arguments:args] stringByAppendingString:@"\n"]];
    if (logger != nil) {
        [logger addText:text];
    }
    va_end(args);
}
-(id)initWithLogger:(logView *)newLogger {
    self = [super init];
    if (self) {
        self.logger = newLogger;
    }
    return self;
}
@end
@implementation TitleLabel: UILabel
-(id)initWithName:(NSString*)name frame:(CGRect)frame{
    RLog(@"Preparing to init");
    self = [super initWithFrame:frame];
    RLog(@"Hey I got this far");
    if (self) {
        RLog(@"Self exists and I have init");
        self.text = name;
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    RLog(@"Returning self...");
    return self;
}
@end
%group start
%hook SpringBoard 
-(void)applicationDidFinishLaunching: (id)arg {
    %orig(arg); 
    logView* ourLogs = [[logView alloc] initWithFrame:CGRectMake(20,40,260,240)];
    Logger* logger = [[Logger alloc] initWithLogger:ourLogs];
    [ourLogs setup]; 
    CGRect mainFrame = CGRectMake(60,60,300,300);
    CGSize iphoneScreenSize = [[UIScreen mainScreen] bounds].size;
    [logger log:@"Initiating with CGRect: %@", NSStringFromCGRect(mainFrame)];
    [logger log:@"Screen size: {\n  width:%i\n  height:%i\n}", iphoneScreenSize.width, iphoneScreenSize.height];
    pane = [[MainPane alloc] initWithFrame:mainFrame logger:logger];
    TitleLabel *tweakNameLabel = [[TitleLabel alloc] initWithName:@"DebugLogger" frame:CGRectMake(5,5,20,8)];
    UIWindow *mainWindow = keyWindow(); 
    RLog(@"Added subview to mainWindow");
    [mainWindow addSubview:pane];
    [mainWindow bringSubviewToFront:pane];
    [pane addSubview:ourLogs];
    [pane addSubview:tweakNameLabel];
    for (int i = 0; i < 50; i = i + 1) {
        [logger log:@"Testing spam logs"];
    }
}
%end
%end

%ctor {
    %init(start);
}