//
//  KWLoginedUserModel.h
//  westkissMob
//
//  Created by 王猛 on 2022/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWLoginedUserModel : NSObject


@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *group_id;

// true=这个月生日 false=这个月不是生日
@property (nonatomic, assign) NSInteger isBirthday;
@property (nonatomic, copy) NSString *dob;
@property (nonatomic, copy) NSString *cartNums;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, assign) BOOL is_subscribed;

//@property (nonatomic, assign) NSInteger vipLevel;
//@property (nonatomic, copy) NSString *vipDes;

@end

NS_ASSUME_NONNULL_END
