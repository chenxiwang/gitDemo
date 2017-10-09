//
//  KeyBoardView.h
//  TestDemo
//
//  Created by wcx on 2017/9/27.
//  Copyright © 2017年 wcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyBoardView : UIView
@property (nullable, readwrite, strong) UIView *inputAccessoryView;
- (void)show:(void (^) (void))completeBlock;
@end
