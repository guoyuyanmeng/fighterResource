//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import "SSCAppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "SSCViewController.h"
#import <RennSDK/RennSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//新浪微博SDK头文件
#import "WeiboSDK.h"

@implementation SSCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [ShareSDK registerApp:@"iosv1101"
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeTencentWeibo),
                            @(SSDKPlatformTypeDouBan),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeKaixin),
                            @(SSDKPlatformTypeYouDaoNote),
                            @(SSDKPlatformTypeInstapaper)
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeRenren:
                             [ShareSDKConnector connectRenren:[RennClient class]];
                             break;
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeTencentWeibo:
                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                                 redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"100371282"
                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeDouBan:
                      [appInfo SSDKSetupDouBanByApiKey:@"02e2cbe5ca06de5908a863b15e149b0b"
                                                secret:@"9f1e7b4f71304f2f"
                                           redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeRenren:
                      [appInfo SSDKSetupRenRenByAppId:@"226427"
                                               appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                            secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                             authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeKaixin:
                      [appInfo SSDKSetupKaiXinByApiKey:@"358443394194887cee81ff5890870c7c"
                                             secretKey:@"da32179d859c016169f66d90b6db2a23"
                                           redirectUri:@"http://www.sharesdk.cn/"];
                      break;
                  case SSDKPlatformTypeYouDaoNote:
                      [appInfo SSDKSetupYouDaoNoteByConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
                                                 consumerSecret:@"d98217b4020e7f1874263795f44838fe"
                                                  oauthCallback:@"http://www.sharesdk.cn/"];
                      break;
                  case SSDKPlatformTypeInstapaper:
                      [appInfo SSDKSetupInstapaperByConsumerKey:@"4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA"
                                                 consumerSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"];
                      break;
                  default:
                      break;
              }
          }];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *vc = [[SSCViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window makeKeyAndVisible];
    
    return YES;
    

}

@end
