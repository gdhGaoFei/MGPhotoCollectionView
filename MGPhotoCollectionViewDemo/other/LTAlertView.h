//
//  LTAlertView.h
//  LTAlertView
//
//  Created by Meeno3 on 16/3/31.
//  Copyright © 2016年 litao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LTAlertView : UIAlertView<UIAlertViewDelegate>
typedef void(^OnTapBlock)(LTAlertView* alert,NSInteger num);

typedef void(^ConfigBlock)(LTAlertView* alertView);

@property(nonatomic,strong)OnTapBlock onTapBlock;
+(void)showTitle:(NSString*)title message:(NSString*)message ButtonTitles:(NSArray*)titles OnTapBlock:(OnTapBlock)onTapBlock;

+(void)showConfigBlock:(ConfigBlock)configBlock Title:(NSString*)title message:(NSString*)message ButtonTitles:(NSArray*)titles OnTapBlock:(OnTapBlock)onTapBlock;
@end
