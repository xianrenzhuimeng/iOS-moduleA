//
//  UCMHttpRequest.h
//  AFNetworking
//
//  Created by  王猛 on 2021/9/25.
//
//每个请求都创建一个 requeset 对象
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface UCMHttpRequest: YTKRequest
/// 响应数据的返回状态码
@property (nonatomic, readonly, assign)NSInteger ucm_serverResponseStatusCode;
/// 请求数据的状态码
@property (nonatomic, readonly, assign)NSInteger ucm_serverRequestStatusCode;
///返回的提示信息
@property (nonatomic, readonly, copy)NSString *ucm_serverResponseMessage;
///请求的弹框类型
@property (nonatomic, readonly, assign) NSInteger ucm_requestAlertStyle;
/// 请求地址
@property (nonatomic , strong) NSString *ucm_requesetmark;
/// 请求类型
@property (nonatomic , assign) YTKRequestMethod ucm_requestType;
/// 请求参数
@property (nonatomic , strong) id ucm_argument;
/// 这个参数 默认 -1 不缓存 不更新
/// 0 代表更新本地数据 1 更新本地并且回调给使用方 
@property (nonatomic , assign) NSInteger ucm_updatetype;

+ (instancetype)setuprequesetclass:(Class)requesetclasee;
/// 给子类去修改默认配置
- (void)ucm_changeDafult;
///请求的返回
- (void)ucm_startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure;
@end

NS_ASSUME_NONNULL_END
