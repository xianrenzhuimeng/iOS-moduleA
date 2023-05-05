//
//  KWLoginedManager.h
//  westkissMob
//
//  Created by 王猛 on 2022/9/5.
//

#import <Foundation/Foundation.h>
#import "KWLoginedUserModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface KWLoginedManager : NSObject
+ (instancetype)shareInstance;

@property (nonatomic, strong) KWLoginedUserModel *userModel;
#pragma mark 1. 保存用户细信息
-(void)saveLoginedUserJsonDictionary:(NSDictionary *)userJsonDic ;

#pragma mark 2. 读取用户信息

-(KWLoginedUserModel *)getCurrentLoginedUser ;

-(NSDictionary *)getLoginedUserJsonDictionary ;
//
//-(NSString *)tool_getLoginedUserJsonString ;

#pragma mark 3.清空用户信息
-(void)clearLoginedUser ;

@end

NS_ASSUME_NONNULL_END
