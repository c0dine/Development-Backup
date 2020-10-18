#import <UIKit/UIkit.h>
@interface logView: UITextView
-(void)scrollToBottom;
-(void)addText:(NSString*)newText;
-(void)setup;
@end
@interface Logger: NSObject
@property (nonatomic, retain) logView* logger;
-(void)log:(NSString *)format, ...;
-(id)initWithLogger:(logView*)newLogger;
@end
@interface MainPane: UIView
@property (nonatomic, retain) Logger* logger;
-(id)initWithFrame:(CGRect)frame logger:(Logger*)newLogger;
-(void)handlePan: (UIPanGestureRecognizer *)gesture;
-(void)setup;
-(void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius;
@end
@interface TitleLabel: UILabel
@property (nonatomic, retain) NSString* tweakName;
-(id)initWithName:(NSString*)name frame:(CGRect)frame;
@end
