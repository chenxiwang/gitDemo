//
//  YTTextView.h
//  DongDong
//
//  Created by liuyifeng on 8/6/15.
//  Copyright (c) 2015年 深圳市易图资讯股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YTKeyBoardHideButtonHeight (29.0)
@interface YTTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
/// 占位符的位置
@property (nonatomic, assign) UIEdgeInsets placeholderEdgeInset;
/// 长度限制
@property (nonatomic, assign) NSInteger textLength;
/// placeholder属性字符串
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
/// 是否为属性字符串 在限制textView字数的时候 用 textStorage 来处理
@property (nonatomic, assign) BOOL isAttributed;
/// 处理后的内容长度 可用于监听
@property (nonatomic, assign) NSUInteger handledTextLength;
/**
 *  重载init方法 没有带accessory
 *
 *  @param frame frame description
 *
 *  @return return value description
 */
- (instancetype)initWithNoInputAccessory:(CGRect)frame;

/**
 *  改变占位符
 */
- (void)changeTextPlaceholder;
@end
