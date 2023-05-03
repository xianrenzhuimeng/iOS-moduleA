//
//  Target_A.m
//  A
//
//  Created by 王猛 on 2023/5/3.
//

#import "Target_A.h"
#import "AViewController.h"

@implementation Target_A
- (UIViewController *)Action_viewController:(NSDictionary *)params{
    AViewController *viewController = [[AViewController alloc] init];
    return viewController;
}
@end
