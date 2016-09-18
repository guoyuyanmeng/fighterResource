//
//  content.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/9.
//  Copyright © 2015年   何舒. All rights reserved.
//

//#ifndef content_h
//#define content_h
//
//
//#endif /* content_h */


/**
 *  定义Base_URL 公司IP=0,家里IP＝1
 */
#define SELECT_IP  0
#if SELECT_IP == 0
#define URL_HFB @"http://115.231.183.102:8888"
#endif




/**
 *  定义服务器URL
 */
#define QN_URL @"http://7xng1t.com1.z0.glb.clouddn.com"

/*--------------------Iphone5 的判断------------------------------------------------------*/
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/*--------------------ios7 的判断------------------------------------------------------*/
#define IOS8_OR_LATER  [[[UIDevice currentDevice]systemVersion] floatValue] >= 8
#define IOS9_OR_LATER [[[UIDevice currentDevice]systemVersion] floatValue] >= 9
#define IOS5 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0f && [[[UIDevice currentDevice] systemVersion] floatValue] < 6.0f)
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_7_DELTA(V,X,Y,W,H) if(IOS7_OR_LATER) {CGRect f = V.frame;f.origin.x += X;f.origin.y += Y;f.size.width +=W;f.size.height += H;V.frame=f;}
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
/*--------------------ios8 的判断------------------------------------------------------*/
//#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
//字体设置判断
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0 // iOS6 and later
#define UITextAlignmentCenter    NSTextAlignmentCenter
#define UITextAlignmentLeft      NSTextAlignmentLeft
#define UITextAlignmentRight     NSTextAlignmentRight
#define UILineBreakModeTailTruncation     NSLineBreakByTruncatingTail
#define UILineBreakModeMiddleTruncation   NSLineBreakByTruncatingMiddle
#endif


//获取当前屏幕宽高
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width        //屏幕宽
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height      //屏幕高
//版本
#define kDevice70 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)     //判断系统版本大于7.0
#define kDevice60 ([[[UIDevice currentDevice] systemVersion] doubleValue]<7.0)     //判断系统版本大于7.0
#define kDeviceSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]   //获得系统版本
//字符串空判断
#define kWipeNull(object) (object==[NSNull null]?@"暂无数据":object)
#define kWipeNullKong(object) (object==[NSNull null]?@"":object)
#define kWipeNullKongs(object) ((object==[NSNull null]?@"uploadFile/carlogo/mading.png":object))
//图片字符串判断
#define httpImage(base,string) [string hasPrefix:@"http"]?string:([NSString stringWithFormat:@"%@%@",base,string])
#define REST_API_KEY    @""

#define UMENG_APPKEY    @"4eeb0c7b527015643b000003"

// 网络请求常用
#define kErrorNetWork           @"网络请求出错,请稍后再试"
#define NQ_LOGIN_SUCCESS        @"NQ_LOGIN_SUCCESS"
#define NQ_MESSAGENUM_CHANGE    @"NQ_MESSAGENUM_CHANGE"
#define NQ_LOGOUT               @"NQ_LOGOUT"
#define NQ_ENTERHOME            @"NQ_ENTERHOME"
#define NQ_BADGEADD             @"NQ_BADGEADD"

static inline BOOL isoObjectEmpty(NSObject * proName ){
    
    if ([proName isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}
//判断空
static inline BOOL isStringEmpty(NSString *string){
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}