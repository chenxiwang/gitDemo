//
//  YTTextView.m
//  DongDong
//
//  Created by liuyifeng on 8/6/15.
//  Copyright (c) 2015年 深圳市易图资讯股份有限公司. All rights reserved.
//

#import "YTTextView.h"

#import "UITextView+APSUIControlTargetAction.h"



@interface YTTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end


@implementation YTTextView

/**
 *  释放
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    self.placeholder = nil;
    self.placeholderColor = nil;

    [self.placeHolderLabel removeFromSuperview];
    self.placeHolderLabel = nil;
}

/**
 *  初始化
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];

        UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, YTKeyBoardHideButtonHeight)];
        self.inputAccessoryView = accessoryView;

        UIButton *keyBoardHideButton = [[UIButton alloc] initWithFrame:CGRectMake(self.inputAccessoryView.frame.size.width - 36.0, 0.0, 36.0, YTKeyBoardHideButtonHeight)];
        keyBoardHideButton.alpha = 0.70;
        UIImage *normalImage =[UIImage imageNamed:@"KeyBoard_Hide_iOS7"];
        [keyBoardHideButton setImage:normalImage forState:UIControlStateNormal];
        [keyBoardHideButton addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
        [accessoryView addSubview:keyBoardHideButton];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];

        normalImage = nil;
        keyBoardHideButton = nil;
        accessoryView = nil;
    }
    return self;
}

/**
 *  改变占位符
 */
- (void)changeTextPlaceholder {
    [self textChanged:nil];
}

/**
 *  重载init方法 没有带accessory
 *
 *  @param frame frame description
 *
 *  @return return value description
 */
- (instancetype)initWithNoInputAccessory:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

/**
 *  通知
 *
 *  @param notification <#notification description#>
 */
- (void)textChanged:(NSNotification *)notification {
      self.handledTextLength = self.text.length;
     [self updateShouldDrawPlaceholder];
    
    if ([[self placeholder] length] == 0) {
        return;
    }

    [UIView animateWithDuration:0.1
                     animations:^{
                         if (([[self text] length] == 0) || [self.attributedText.string length] == 0) {
                             UIView *view = [self viewWithTag:999];
                             [view setAlpha:1];
                         } else {
                             UIView *view = [self viewWithTag:999];
                             [view setAlpha:0];
                         }
                     }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self textChanged:nil];
}

/**
 *  <#Description#>
 *
 *  @param placeholder <#placeholder description#>
 */
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.placeHolderLabel.text = placeholder;
    [self updateShouldDrawPlaceholder];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _attributedPlaceholder = attributedPlaceholder;
    
    [self setPlaceholderLabel];
    self.placeHolderLabel.attributedText = attributedPlaceholder;
    [self updateAttributedPlaceholder];
}

/**
 *  重绘
 *
 *  @param rect <#rect description#>
 */
- (void)drawRect:(CGRect)rect {
    if ([[self placeholder] length] > 0) {
        [self setPlaceholderLabel];
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }

    if ((([[self text] length] == 0) || [self.attributedText.string length] == 0) && [[self placeholder] length] > 0) {
        UIView *view = [self viewWithTag:999];
        [view setAlpha:1];
    }

    [super drawRect:rect];
}

- (void)setPlaceholderLabel{
    if (_placeHolderLabel == nil) {
        CGFloat left = [self placeHolderLabelLeft];
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, [self placeHolderLabelTop], self.bounds.size.width - left*2, 0)];
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.font = self.font;
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.textColor = self.placeholderColor;
        _placeHolderLabel.alpha = 0;
        _placeHolderLabel.tag = 999;
        [self addSubview:_placeHolderLabel];
    }
}

/**
 *  按钮触摸事件
 *
 *  @param sender <#sender description#>
 */
- (void)pressedButton:(UIButton *)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

/**
 *  textLength setter
 *
 *  @param textLength <#textLength description#>
 */
- (void)setTextLength:(NSInteger)textLength {
    _textLength = textLength;

    [self addTarget:self action:@selector(textViewDidChange:) forControlEvents:UIControlEventEditingChanged];
}


/**
 *  textView changed Method
 *
 *  @param sender <#sender description#>
 */
- (void)textViewDidChange:(UITextView *)sender {
    NSInteger kTextFieldLengthLimit = _textLength;
    if (self.isAttributed) {
        NSInteger length = sender.textStorage.length;
        
        // 键盘输入模式(判断输入模式的方法是iOS7以后用到的)
        NSArray *currentar = [UITextInputMode activeInputModes];
        UITextInputMode *current = [currentar firstObject];
        NSAttributedString *zeroAttributedString = [[NSAttributedString alloc] initWithString:@""];
        if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) {
            // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [sender markedTextRange];
            // 获取高亮部分
            UITextPosition *position = [sender positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (length > kTextFieldLengthLimit) {
                    [sender.textStorage replaceCharactersInRange:NSMakeRange(kTextFieldLengthLimit, length - kTextFieldLengthLimit) withAttributedString:zeroAttributedString];
                }
            }
        } else {
            // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (length > kTextFieldLengthLimit) {
                [sender.textStorage replaceCharactersInRange:NSMakeRange(kTextFieldLengthLimit, length - kTextFieldLengthLimit) withAttributedString:zeroAttributedString];
            }
        }
        zeroAttributedString = nil;
        return;
    }
    NSString *toBeString = sender.text;

    // 键盘输入模式(判断输入模式的方法是iOS7以后用到的)
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];

    if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) {
        // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [sender markedTextRange];
        // 获取高亮部分
        UITextPosition *position = [sender positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kTextFieldLengthLimit) {
                sender.text = [toBeString substringToIndex:kTextFieldLengthLimit];
            }
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kTextFieldLengthLimit) {
            sender.text = [toBeString substringToIndex:kTextFieldLengthLimit];
        }
    }
}

/**
 *  <#Description#>
 */
- (void)updateShouldDrawPlaceholder {
    if ([self.text isEqualToString:@""]) {
        self.placeHolderLabel.hidden = NO;
    } else {
        self.placeHolderLabel.hidden = YES;
    }
    
    CGSize textSize = CGSizeMake(self.frame.size.width - 16.0, CGFLOAT_MAX);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.placeHolderLabel.font, NSFontAttributeName, nil];
    CGSize sizeWithFont = [self.placeHolderLabel.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    CGFloat h = sizeWithFont.height, maxHeight = [self placeHolderLabelTop] * 2;
    if (h > self.frame.size.height - maxHeight) {
        h = self.frame.size.height - maxHeight;
    }
    self.placeHolderLabel.frame = CGRectMake([self placeHolderLabelLeft], [self placeHolderLabelTop], textSize.width, h);
}

/**
 <#Description#>
 */
- (void)updateAttributedPlaceholder {
    self.placeHolderLabel.hidden = self.text.length > 0 ? YES : NO;
    self.placeHolderLabel.alpha = _attributedPlaceholder.length > 0 ? 1.0 : 0.0;
    self.placeHolderLabel.frame = CGRectMake([self placeHolderLabelLeft], [self placeHolderLabelTop], self.attributedPlaceholder.size.width, self.attributedPlaceholder.size.height);
}

- (CGFloat)placeHolderLabelLeft {
    CGFloat left = 8.0;
    if (self.placeholderEdgeInset.left > 0) {
        left = self.placeholderEdgeInset.left;
    }
    return left;
}

- (CGFloat)placeHolderLabelTop {
    CGFloat top = 8.0;
    if (self.placeholderEdgeInset.top > 0) {
        top = self.placeholderEdgeInset.top;
    }
    return top;
}

@end
