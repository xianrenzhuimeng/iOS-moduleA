//
//  UCMHttpRequestBaseVM.h
//  UCMHttpRequest
//
//  Created by 王猛 on 2021/9/25.
//
/// 在VM 中解析的分类
#import <Foundation/Foundation.h>
#import "UCMHttpRequestResponse.h"
#import "UCMHttpRequest.h"
#import <YTKNetwork/YTKNetwork.h>
NS_ASSUME_NONNULL_BEGIN

@protocol UCM_baseVMprotocol <NSObject>
///获取网络请求的回调
-(void)pro_respnsParseData:(UCMHttpRequestResponse *)response
                   arrData:(NSMutableArray *)arrData
                   showMsg:(BOOL)is_showmsg
                      list:(BOOL)is_list
                    sucess:(BOOL)sucessOrFail
                  has_more:(BOOL)has_more
                      mark:(NSString *)mark
               extend_info:(NSDictionary *)extend_info;


///batch 网络请求的代理
-(void)pro_batchResponAry:(NSArray <UCMHttpRequestResponse *>*)responseAry success:(BOOL)success modelData:(NSMutableArray *_Nullable)modelAry;

@end

@interface UCMHttpRequestBaseVM : NSObject<YTKBatchRequestDelegate>
///网络回调的代理
@property (nonatomic, weak) id <UCM_baseVMprotocol> delegate;

//多个网络请求 的统一回调
@property (nonatomic , copy) void(^complete)(BOOL success,id object);

/// @param VMclass 子类继承VM--初始化
+ (instancetype)setupVMclass:(Class)VMclass;
#pragma mark - **************** requset请求 ****************

/// @param api 网络请求请求体
- (void)ucm_requestApi:(UCMHttpRequest *)api;

/// @param api 请求体，进行网络请求，并且获取respose 数据，ca
/// @param callback 网络请求
- (void)ucm_requestApi:(UCMHttpRequest *)api callback:(void(^)(UCMHttpRequestResponse *response))callback;

///直获取回调的参数
/// @param response 源数据
/// @param callback 通用回调
- (void)ucm_configresponseInterceptor:(UCMHttpRequestResponse *)response callback:(nullable void(^)(UCMHttpRequestResponse *response))callback;



#pragma mark - **************** VM拦截通用数据-重写 ****************
/// 给使用者方便数据拦截 请求成功
/// @param response 数据源
- (void)ucm_confignormalnetworksuccesswithresponse:(UCMHttpRequestResponse *)response;

/// 给使用者方便数据拦截 请求失败
/// @param response 数据源
- (void)ucm_confignormalnetworkfailwithresponse:(UCMHttpRequestResponse *)response;

-(void)ucm_batch_configNewsReposeAry:(NSArray <UCMHttpRequestResponse *>*)responseAry success:(BOOL)success modelData:(NSMutableArray *_Nullable)modelAry ;

#pragma mark - **************** 解析后VM回传给VC ****************
/// @param response 数据源
/// @param is_showmsg 是否显示msg
/// @param success 成功
/// @param mark 标示
- (void)ucm_configNewsRepose:(UCMHttpRequestResponse *)response
                  is_showmsg:(BOOL)is_showmsg
                     success:(BOOL)success
                        mark:(NSString *)mark
                 extend_info:(NSDictionary *)extend_info;

/// @param response 源数据
/// @param data 数据
/// @param success 成功
/// @param has_more 更多
/// @param mark 标示
- (void)ucm_configNewsRepose:(UCMHttpRequestResponse *)response
                        data:(NSMutableArray *_Nullable)data
                     success:(BOOL)success
                    has_more:(BOOL)has_more
                        mark:(NSString *)mark
                 extend_info:(NSDictionary *)extend_info;

/// @param response 数据源
/// @param data 数组源
/// @param is_showmsg 是否显示 后台返回的msg
/// @param is_list 是否是列表
/// @param success 网络成功 与 否
/// @param has_more 是否有更多数据
/// @param mark 请求标示
- (void)ucm_configNewsRepose:(UCMHttpRequestResponse *)response
                        data:(NSMutableArray *_Nullable)data
                  is_showmsg:(BOOL)is_showmsg
                     is_list:(BOOL)is_list
                     success:(BOOL)success
                    has_more:(BOOL)has_more
                        mark:(NSString *)mark
                 extend_info:(NSDictionary *)extend_info;




#pragma mark - **************** 多个网络请求 ****************
/// Batch多个网络请求
/// @param requsetAry 请求组
-(void)ucm_batchRequestApi:(NSArray *)requsetAry;
/// Batch多个网络请求
/// @param apis 请求组
/// @param complete 回调
- (void)ucm_batchrequsetsforapis:(NSArray  *)apis comple:(void(^)(BOOL success,id object))complete;


@end

NS_ASSUME_NONNULL_END
