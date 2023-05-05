//
//  UCMHttpRequestResponse.h
//  AFNetworking
//
//  Created by 猛  王 on 2021/9/25.
//

#import <Foundation/Foundation.h>
#import "UCM_GenerProfile.h"
@class UCMHttpRequestBaseVM;
NS_ASSUME_NONNULL_BEGIN
///请求状态
typedef NS_ENUM(NSInteger, ucm_ResponseStatusType){
    ucm_ResponseStatusTypeRequestUnKonw     = -1 ,//不知道类型
    ucm_ResponseStatusTypeRequestError      =   0,// 服务后台问题
    ucm_ResponseStatusTypeNoNotWork         =   1,// 没有网络
    ucm_ResponseStatusTypeSuccess           =   200,//请求成功
    ucm_ResponseStatusTypeExpirySign       =   401,//授权失效
    ucm_ResponseStatusTypeNoPermission      =   403,//无权限访问
    ucm_ResponseStatusTypeServiceError     =    500,//服务器错误
    ucm_ResponseStatusTypeDataNull         =    502,//数据接口为空
    ucm_ResponseStatusTypeNotLogin         =    -1,//没有登录
    ucm_ResponseStatusTypeTimeOut         =    10001,//响应超时
    req_ResponseStatusTypeTimeOut         =    10002,//请求超时
    ucm_ResponseStatusTypeLoginOut        =    100001,//退出登陆
};
///弹框类型
typedef NS_ENUM(NSInteger, ucm_requestAlertStyle){
    ucm_requestAlertStyleSystem    =   0,///系统的
    ucm_requestAlertStyleCustom    =   1,///自定义的
};
@class UCMHttpRequest;
@interface UCMHttpRequestResponse : NSObject
@property (nonatomic, assign) BOOL ucm_success;
@property (nonatomic, assign) ucm_ResponseStatusType ucm_responseStatusType;//请求类型
@property (nonatomic, assign) NSInteger ucm_serverResponseStatusCode; // 服务端返回的status code
@property (nonatomic, assign) NSInteger ucm_requestResponseStatusCode; // 请求返回的status code
@property (nonatomic, assign) NSInteger ucm_requestAlertStyle;//请求的弹框类型
@property (nonatomic, strong) id ucm_responseObject;   //返回数据
@property (nonatomic, strong) NSString *ucm_responseString; //返回json数据
@property (nonatomic, copy) NSString *ucm_responseMessage;  //提示信息
@property (nonatomic, copy) NSString *ucm_responseSubMessage;  //内部提示信息
@property (nonatomic, copy) NSString *ucm_responseSeverErrCode; //内部的错误信息的code
@property (nonatomic, copy) NSString *ucm_responseMark; // 接口标示
@property (nonatomic, strong) id ucm_requestparams; // 接口参数
/// 这个参数 默认 0 代表更新本地数据 1 更新本地并且回调给使用方
@property (nonatomic , assign) NSInteger ucm_updatetype;

///0  有网， 1没网
@property (nonatomic , assign) NSInteger nonetwork;
//@property (nonatomic, copy)void(^responseBlock)(UCMHttpRequestResponse *response);
+ (UCMHttpRequestResponse *)ucm_responseWithRequest:(UCMHttpRequest *)request;

/// 解析缓存数据
+ (UCMHttpRequestResponse *)ucm_cacheresponseWithRequest:(UCMHttpRequest *)request;

///是否需要提示
- (BOOL)ucm_isAlert;

///弹框类型
- (ucm_requestAlertStyle)ucm_alertStyle;

///是否有网络
- (BOOL)ucm_isNoNetwork;

///sign是否失效
- (BOOL)ucm_isExpiryToken;

///服务器错误
- (BOOL)ucm_isRequestServerError;

///后台发生错误
- (BOOL)ucm_isServerServiceError;

///是否登陆
- (BOOL)ucm_isLogin;

///弹窗信息
- (void)ucm_alectSuccessMessage;
@end

NS_ASSUME_NONNULL_END
