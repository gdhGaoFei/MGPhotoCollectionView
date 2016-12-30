//
//  LTAlertView.m
//  LTAlertView
//
//  Created by Meeno3 on 16/3/31.
//  Copyright © 2016年 litao. All rights reserved.
//
#import "LTAlertView.h"
LTAlertView* alertView = nil;
@implementation LTAlertView

-(void)showTitle:(NSString*)title message:(NSString*)message ButtonTitles:(NSArray*)titles{
    self.title = title;
    self.message = message;
    for (int i = 0; i < titles.count; i++) {
        [self addButtonWithTitle:titles[i]];
    }
    self.delegate = self;
    //    [self show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (((LTAlertView*)alertView).onTapBlock) {
        ((LTAlertView*)alertView).onTapBlock((LTAlertView*)alertView,buttonIndex);
    }
}
+(void)configAlertView:(ConfigBlock)configBlock{
    
}
+(void)showTitle:(NSString*)title message:(NSString*)message ButtonTitles:(NSArray*)titles OnTapBlock:(OnTapBlock)onTapBlock{
    alertView = [LTAlertView new];
    if (onTapBlock) {
        alertView.onTapBlock = onTapBlock;
    }
    alertView.title = title;
    alertView.message = message;
    for (int i = 0; i < titles.count; i++) {
        [alertView addButtonWithTitle:titles[i]];
    }
    alertView.delegate = alertView;
    [alertView show];
}

+(void)showConfigBlock:(ConfigBlock)configBlock Title:(NSString*)title message:(NSString*)message ButtonTitles:(NSArray*)titles OnTapBlock:(OnTapBlock)onTapBlock{
    alertView = [LTAlertView new];
    
    if (onTapBlock) {
        alertView.onTapBlock = onTapBlock;
    }
    
    if(configBlock){
        configBlock(alertView);
    }
    

    alertView.title = title;
    alertView.message = message;
    for (int i = 0; i < titles.count; i++) {
        [alertView addButtonWithTitle:titles[i]];
    }
    alertView.delegate = alertView;
    [alertView show];
}
@end
