//
//  ViewController.h
//  PushExample2
//

#import <UIKit/UIKit.h>
#import "IXPushSdk.h"

@interface ViewController : UIViewController<IXTagOpDelegate,IXAliasOpDelegate>
@property (weak, nonatomic) IBOutlet UITextView *logView;
@end