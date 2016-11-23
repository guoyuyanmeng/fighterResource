//
//  ViewController.m
//  PushExample2
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)onResult:(BOOL)result tags:(NSArray *)tags{
    if (result == TRUE) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self addLogString:[NSString stringWithFormat:@"tag command succeed,%@",tags]];
        });
        
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self addLogString:[NSString stringWithFormat:@"tag command failed,%@",tags]];
        });
    }
}

-(void)onResult:(BOOL)result alias:(NSString *)alias{
    if (result == TRUE) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self addLogString:[NSString stringWithFormat:@"alias command succeed,%@", alias]];
        });
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self addLogString:[NSString stringWithFormat:@"alias command failed,%@", alias]];
        });
    }
}

- (IBAction)addTag:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加标签" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *tagField = alertController.textFields.firstObject;
        
        NSArray *tags = [self readTags:tagField.text];
        [IXPushSdkApi addTags:tags delegate:self];
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (NSArray *)readTags:(NSString *)text {
    NSArray *array = [text componentsSeparatedByString:@","];
    NSMutableArray *tags = [[NSMutableArray alloc]init];
    for (NSString *anArray in array) {
        int tag = [anArray intValue];
        [tags addObject:[NSNumber numberWithInt:tag]];
    }
    return tags;
}

- (IBAction)deleteTag:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除标签" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *tagField = alertController.textFields.firstObject;
        
        NSArray *tags = [self readTags:tagField.text];
        [IXPushSdkApi deleteTags:tags delegate:self];
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (IBAction)listTag:(UIButton *)sender {
    NSArray *tags = [IXPushSdkApi listTags];
    [self addLogString:[NSString stringWithFormat:@"list tags:%@",tags]];
}

- (IBAction)isSuspend:(UIButton *)sender {
    if ([IXPushSdkApi isRegistered]) {
        [self addLogString:@"push is registered"];
    } else {
        [self addLogString:@"push is unregistered"];
    }
}
- (IBAction)suspendPush:(UIButton *)sender {
    [IXPushSdkApi unregisterPush];
}

- (IBAction)resumePush:(UIButton *)sender {
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [IXPushSdkApi registerNotificationSettings:settings];
    } else {
        [IXPushSdkApi registerNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
    }
#else
    [PushSdkApi registerNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
#endif
}

- (IBAction)bindAlias:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"绑定别名" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *aliasField = alertController.textFields.firstObject;
        NSString *alias = aliasField.text;
        [IXPushSdkApi bindAlias:alias delegate:self];
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)clearAlias:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除别名" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *aliasField = alertController.textFields.firstObject;
        NSLog(@"clear alias input:%@",aliasField.text);
        NSString *alias = aliasField.text;
        [IXPushSdkApi unbindAlias:alias delegate:self];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)addLogString:(NSString *)logStr
{
    self.logView.editable = FALSE;
    NSString *additionStr = [logStr stringByAppendingString:@"\n\n"];
    NSString *preLogString = self.logView.text;
    [self.logView setText:[additionStr stringByAppendingString:preLogString]];
    
}
- (IBAction)setBadge:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"设置Badge" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *aliasField = alertController.textFields.firstObject;
        int value = aliasField.text.intValue;
        BOOL result = [IXPushSdkApi setBadge:value];
        if (result == FALSE) {
            [self addLogString:@"error:badge value should >=0"];
        } else {
            [self addLogString:[NSString stringWithFormat:@"badge is set to %d", value]];
        }
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end