//
//  UCMHttpRequest.m
//  AFNetworking
//
//  Created by  王猛 on 2021/9/25.
//

#import "UCMHttpRequest.h"
#import "KWLoginedManager.h"
@interface UCMHttpRequest()
/// 响应数据的返回状态码
@property (nonatomic, readwrite, assign)NSInteger ucm_serverResponseStatusCode;
/// 请求数据的状态码
@property (nonatomic, readwrite, assign)NSInteger ucm_serverRequestStatusCode;
///返回的提示信息
@property (nonatomic, readwrite, copy)NSString *ucm_serverResponseMessage;
///请求的弹框类型
@property (nonatomic, readwrite, assign)NSInteger ucm_requestAlertStyle;
@end
@implementation UCMHttpRequest

+ (instancetype)setuprequesetclass:(Class)requesetclasee {
    return [[requesetclasee alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self ucm_changeDafult];
    }
    return self;
}
#pragma mark - **************** 重写Request的方法 ****************
- (NSString *)requestUrl {
    return self.ucm_requesetmark;
}

- (id)requestArgument {
    return self.ucm_argument;
}

- (YTKRequestMethod)requestMethod {
    return self.ucm_requestType;
}
- (NSTimeInterval)requestTimeoutInterval {
    return 30.0;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (![[KWLoginedManager.shareInstance getCurrentLoginedUser].token isEqualToString:@""]){
        [dic setValue:[KWLoginedManager.shareInstance getCurrentLoginedUser].token forKey:@"token"];
    }
    return dic;
}
#pragma mark - **************** 公开方法 ****************
- (void)ucm_startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure {
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (success) {
            success(request);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request);
        }
    }];
}


///自定义方法
- (void)ucm_changeDafult {
    self.ucm_updatetype = -1;
}
@end
