//
//  UCMHttpRequestNetworkManager.m
//  AFNetworking
//
//  Created by 恒  王 on 2020/9/25.
//

#import "UCMHttpRequestNetworkManager.h"
@implementation UCMHttpRequestNetworkManager
+ (instancetype)ucm_netManager {
    static UCMHttpRequestNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UCMHttpRequestNetworkManager alloc] init];
    });
    return manager;
}

- (void)ucm_netStatus {
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //开启监听，记得开启，不然不走block
    [manger startMonitoring];
    //2.监听改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown = -1,
         AFNetworkReachabilityStatusNotReachable = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            default:
                break;
        }
    }];
}
- (BOOL)ucm_isReachable {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}
- (NSInteger)ucm_getNetworkStatus {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        return  0;
    }else{
        return 1;
    }
}
@end
