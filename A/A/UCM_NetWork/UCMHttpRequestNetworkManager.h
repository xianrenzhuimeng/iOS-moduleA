//
//  UCMHttpRequestNetworkManager.h
//  AFNetworking
//
//  Created by 恒  王 on 2020/9/25.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface UCMHttpRequestNetworkManager : NSObject
+(instancetype)ucm_netManager;
- (void)ucm_netStatus;
- (BOOL)ucm_isReachable;
- (NSInteger)ucm_getNetworkStatus;
@end

NS_ASSUME_NONNULL_END
