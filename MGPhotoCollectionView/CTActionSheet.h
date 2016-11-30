//
//  CTActionSheet.h
//  huizon
//
//  Created by Yang on 13-11-8.
//  Copyright (c) 2013年 zhaopin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CTActionSheet;

typedef void(^ActionHandleBlock)(int btnIndex);
typedef void(^ActionHandleSheetBlock)(CTActionSheet * actionSheet, int btnIndex);

#define ActionSheet(title,cancelButton,destructiveBtn,otherButton,view) [[DQJKActionSheet actionSheetWithTitle:title cancelButtonTitle:cancelButton destructiveButtonTitle:destructiveBtn otherButtonTitles:otherButton HandleBlock:handle] showInView:view];

@interface CTActionSheet : UIActionSheet<UIActionSheetDelegate>

-(instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles HandleBlock:(ActionHandleBlock)handle;

+(instancetype)actionSheetWithTitle:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles HandleBlock:(ActionHandleBlock)handle;

+(instancetype)actionSheetWithTitle:(NSString*)title
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                       ButtonTitles:(NSArray *)titles
                        HandleBlock:(ActionHandleSheetBlock)handle;

-(instancetype)initWithTitle:(NSString*)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
                ButtonTitles:(NSArray *)titles
                 HandleBlock:(ActionHandleSheetBlock)handle;

+(void)ShowActionSheetWithTitle:(NSString*)title
              cancelButtonTitle:(NSString *)cancelButtonTitle
                   ButtonTitles:(NSArray *)titles
                    HandleBlock:(ActionHandleSheetBlock)handle;

@property (nonatomic,copy) ActionHandleBlock handleBlock;
@property (nonatomic,copy) ActionHandleSheetBlock block;

@end
