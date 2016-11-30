//
//  CTActionSheet.m
//  huizon
//
//  Created by Yang on 13-11-8.
//  Copyright (c) 2013年 zhaopin. All rights reserved.
//

#import "CTActionSheet.h"

@implementation CTActionSheet
-(instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles HandleBlock:(ActionHandleBlock)handle
{
    if (otherButtonTitles!=nil) {
        self=[super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    }else{
        self=[super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    }
    if (self) {
        self.handleBlock=handle;
    }
    return self;
}

+(instancetype)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles HandleBlock:(ActionHandleBlock)handle
{
    return [[CTActionSheet alloc] initWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles HandleBlock:handle];
}

+(instancetype)actionSheetWithTitle:(NSString*)title
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                       ButtonTitles:(NSArray *)titles
                        HandleBlock:(ActionHandleSheetBlock)handle{
    return [[CTActionSheet alloc] initWithTitle:title cancelButtonTitle:cancelButtonTitle ButtonTitles:titles HandleBlock:handle];
}

-(instancetype)initWithTitle:(NSString*)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
                ButtonTitles:(NSArray *)titles
                 HandleBlock:(ActionHandleSheetBlock)handle{
    if (titles.count > 0) {
        self=[super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        for (int i = 0; i < titles.count; i++) {
            [self addButtonWithTitle:titles[i]];
        }
    }else{
        self=[super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil];
    }
    if (self) {
        self.block = handle;
    }
    return self;
}

+(void)ShowActionSheetWithTitle:(NSString*)title
              cancelButtonTitle:(NSString *)cancelButtonTitle
                   ButtonTitles:(NSArray *)titles
                    HandleBlock:(ActionHandleSheetBlock)handle{
    CTActionSheet * sheet = [CTActionSheet actionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle ButtonTitles:titles HandleBlock:handle];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [sheet showInView:window];
}

-(void)dealloc
{
    self.handleBlock=nil;
    
    
}

#pragma mark -
#pragma mark actionSheet delegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int btnIndex = (int)buttonIndex;
    if (self.handleBlock!=nil) {
        self.handleBlock(btnIndex);
        self.handleBlock=nil;
    }
    
    if (self.block != nil) {
        self.block((CTActionSheet *)actionSheet, btnIndex);
    }
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet  // before animation and showing view
{
    
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet  // after animation
{
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex // before animation and hiding view
{
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex  // after animation
{
    
}

@end
