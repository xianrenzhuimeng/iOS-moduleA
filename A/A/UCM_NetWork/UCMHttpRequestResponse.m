//
//  UCMHttpRequestResponse.m
//  AFNetworking
//
//  Created by 猛  王 on 2020/9/25.
//

#import "UCMHttpRequestResponse.h"
#import "UCMHttpRequest.h"
#import <Toast/Toast.h>


@implementation UCMHttpRequestResponse
+ (UCMHttpRequestResponse *)ucm_responseWithRequest:(UCMHttpRequest *)request {
    UCMHttpRequestResponse *response = [UCMHttpRequestResponse new];
    [response ucm_updateStatusCodeWithRequest:request];
    return response;
}


/// 解析缓存数据
+ (UCMHttpRequestResponse *)ucm_cacheresponseWithRequest:(UCMHttpRequest *)request {
    UCMHttpRequestResponse *response = [UCMHttpRequestResponse new];
    [response ucm_CachedataparsingRequest:request];
    return response;
}




- (void)ucm_updateStatusCodeWithRequest:(UCMHttpRequest *)request {
    ///浏览器的请求成功的 code 码 和返回
    NSInteger statusCode = [request responseStatusCode];
    self.ucm_requestResponseStatusCode = statusCode;
    self.ucm_requestAlertStyle = request.ucm_requestAlertStyle;
//    self.ucm_responseMessage = @"服务器错误";
    self.ucm_responseMessage = request.responseObject[@"msg"];
    self.ucm_responseMark = request.ucm_requesetmark;
    self.ucm_requestparams = request.ucm_argument;
    if (statusCode > 200 && statusCode <300) {
        self.ucm_responseStatusType = ucm_ResponseStatusTypeRequestError;
    }else if(statusCode == 200){
        self.ucm_serverResponseStatusCode = [request.responseObject[@"code"] integerValue];
        self.ucm_responseObject = request.responseObject;
        self.ucm_responseString = request.responseString;
        self.ucm_responseStatusType = -1;
        if (self.ucm_serverResponseStatusCode == 200) {
            self.ucm_responseMessage = request.responseObject[@"msg"];
            self.ucm_responseStatusType = ucm_ResponseStatusTypeSuccess;
            self.ucm_success = YES;
        }
        if (self.ucm_serverResponseStatusCode == 401) {
            self.ucm_responseStatusType = ucm_ResponseStatusTypeExpirySign;
        }
        
        if (self.ucm_serverResponseStatusCode == 403) {
            self.ucm_responseStatusType = ucm_ResponseStatusTypeNoPermission;
        }
        
        if (self.ucm_serverResponseStatusCode == 502) {
            self.ucm_responseStatusType = ucm_ResponseStatusTypeDataNull;
        }
        
        if (self.ucm_serverResponseStatusCode == 600) {
            self.ucm_responseStatusType = ucm_ResponseStatusTypeNotLogin;
        }
        
        if (self.ucm_serverResponseStatusCode == 1001 ||
            self.ucm_serverResponseStatusCode == 1002 ||
            self.ucm_serverResponseStatusCode == 1003 ||
            self.ucm_serverResponseStatusCode == 1004 ||
            self.ucm_serverResponseStatusCode == 1012) {
            self.ucm_responseStatusType = ucm_ResponseStatusTypeLoginOut;
        }

        if ([self ucm_isAlert]) {
            [self ucm_alectSuccessMessage];
        }
    }else{
        self.ucm_serverResponseStatusCode = request.ucm_serverResponseStatusCode;
        self.ucm_success = NO;
        NSLog(@"%ld",request.ucm_serverResponseStatusCode);
        if (request.ucm_serverResponseStatusCode == 0) {
            if (request.ucm_serverResponseMessage.length) {
                self.ucm_responseMessage = request.ucm_serverResponseMessage;
            }
            if (request.error.code) {
                if (request.error.code == -1001) {
                    self.ucm_responseStatusType = req_ResponseStatusTypeTimeOut;
                }else if (request.error.code == -1009) {
                    self.ucm_responseStatusType = ucm_ResponseStatusTypeNoNotWork;
                }
            }else{
                self.ucm_responseStatusType = ucm_ResponseStatusTypeRequestError;
            }
        }
        
        if (request.ucm_serverResponseStatusCode == 1) {
            self.ucm_responseMessage = @"Not Net";
            self.ucm_success = NO;
            self.ucm_serverResponseStatusCode = ucm_ResponseStatusTypeNoNotWork;
        }
        
    }
}

/// 解析缓存数据
- (void)ucm_CachedataparsingRequest:(UCMHttpRequest *)request {
    self.ucm_responseMark = request.ucm_requesetmark;
    self.ucm_requestparams = request.ucm_argument;
    ///服务端 返回的code码
    NSLog(@"%@",request.responseObject);
    self.ucm_serverResponseStatusCode = [request.responseObject[@"code"] integerValue];
    if ([request.responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
        self.ucm_responseMessage = request.responseObject[@"data"][@"errMsg"];
    }
    self.ucm_responseObject = request.responseObject[@"data"];
    self.ucm_responseString = request.responseString;
    self.ucm_responseStatusType = -1;
    if (self.ucm_serverResponseStatusCode == 200) {
        self.ucm_responseMessage = request.responseObject[@"msg"];
        self.ucm_responseStatusType = ucm_ResponseStatusTypeSuccess;
    }
    
    if (self.ucm_serverResponseStatusCode == -1) {
        self.ucm_responseStatusType = ucm_ResponseStatusTypeNotLogin;
    }
    if (self.ucm_serverResponseStatusCode == 401) {
        self.ucm_responseStatusType = ucm_ResponseStatusTypeExpirySign;
    }
    
    if (self.ucm_serverResponseStatusCode == 403) {
        self.ucm_responseStatusType = ucm_ResponseStatusTypeNoPermission;
    }
    if (self.ucm_serverResponseStatusCode == 502) {
        self.ucm_responseStatusType = ucm_ResponseStatusTypeDataNull;
    }
    if ([self ucm_isAlert]) {
        [self ucm_alectSuccessMessage];
    }
}

#pragma mark - **************** Tool ****************

///是否有弹框
- (BOOL)ucm_isAlert {
    if (self.ucm_responseStatusType == ucm_ResponseStatusTypeRequestError ||
        self.ucm_responseStatusType == ucm_ResponseStatusTypeNoNotWork ||
        self.ucm_responseStatusType == ucm_ResponseStatusTypeNoPermission ||
        self.ucm_responseStatusType == ucm_ResponseStatusTypeServiceError ||
        self.ucm_responseStatusType == ucm_ResponseStatusTypeDataNull) {
        return YES;
    }
    return NO;
}

//////弹框类型
- (ucm_requestAlertStyle)ucm_alertStyle {
    if (self.ucm_requestAlertStyle) {
        return ucm_requestAlertStyleSystem;
    }
    return ucm_requestAlertStyleCustom;
}

///判断是否有网络
- (BOOL)ucm_isNoNetwork {
    if (self.ucm_responseStatusType == ucm_ResponseStatusTypeNoNotWork) {
        return YES;
    }
    return NO;
}

///sign是否失效
- (BOOL)ucm_isExpiryToken {
    if (self.ucm_requestAlertStyle == ucm_ResponseStatusTypeExpirySign) {
        return YES;
    }
    return NO;
}

///服务器错误
- (BOOL)ucm_isRequestServerError {
    if (self.ucm_responseStatusType == ucm_ResponseStatusTypeRequestError) {
        return YES;
    }
    return NO;
}

///后台发生错误
- (BOOL)ucm_isServerServiceError {
    if (self.ucm_responseStatusType == ucm_ResponseStatusTypeServiceError) {
        return YES;
    }
    return NO;
}

///是否登陆
- (BOOL)ucm_isLogin {
    if (self.ucm_responseStatusType == ucm_ResponseStatusTypeNotLogin) {
        return YES;
    }
    return NO;
}
- (void)ucm_alectSuccessMessage{
    if (self.ucm_responseMessage.length >  0) {
        UIViewController *tempVc = topViewController();
        [tempVc.view makeToast:self.ucm_responseMessage duration:2 position:CSToastPositionCenter];
    }
    
}
@end
