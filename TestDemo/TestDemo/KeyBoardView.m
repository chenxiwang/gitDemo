//
//  KeyBoardView.m
//  TestDemo
//
//  Created by wcx on 2017/9/27.
//  Copyright © 2017年 wcx. All rights reserved.
//

#import "KeyBoardView.h"
#import "YTTextView.h"

static const CGFloat kTextViewHeight = 230;
@interface KeyBoardView()
@property (nonatomic, strong) UIView *containView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inputBgView;
@property (weak, nonatomic) IBOutlet YTTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *launchButton;


@end
@implementation KeyBoardView

- (void)dealloc{
    NSLog(@"KeyBoardView 销毁了");
   [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.textView removeObserver:self forKeyPath:@"handledTextLength"];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.5;
        [self addSubview:bgView];
        
        
        KeyBoardView *content = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        [self addSubview:content];
        self.containView = content;
        content.frame = CGRectMake(0,self.bounds.size.height - kTextViewHeight, self.bounds.size.width, kTextViewHeight);
        
        [self setUp];
       
    }
    return self;
}

- (void)setUp{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    UIImage *bgImage = [UIImage imageNamed:@"KeyBoardInputBoard"];
    self.inputBgView.image = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch];
    
    self.textView.placeholder = @"客户会看到这段话，告诉客户你的优势，提高抢客成功的几率";
    self.textView.placeholderColor = [UIColor lightGrayColor];
    self.textView.placeholderEdgeInset = UIEdgeInsetsMake(10, 10, 0, 10);
    self.textView.textLength = 100;
    
    [self.textView addObserver:self forKeyPath:@"handledTextLength" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
   
   
    [self registerForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications
{
 //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}


- (void)keyBoardWillChangeFrame:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
   
    CGRect endFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLog(@"keyBoardWillChangeFrame , beginFrame: %@, endFrame: %@",NSStringFromCGRect(beginFrame),NSStringFromCGRect(endFrame));
    UIViewAnimationCurve curve = (UIViewAnimationCurve)[info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    void (^animations)(void) = ^{
        [self willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
   
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:nil];
}
- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame{
    CGRect textViewFrame = self.containView.frame;
    if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height) {
        // hide
        textViewFrame.origin.y = self.bounds.size.height - kTextViewHeight;
    }else{
        textViewFrame.origin.y = self.bounds.size.height  - kTextViewHeight - toFrame.size.height;
    }
    self.containView.frame = textViewFrame;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"handledTextLength"]) {
        NSUInteger newValue = [change[NSKeyValueChangeNewKey] integerValue];
        
        newValue =  MIN(newValue, 100);
        newValue =  MAX(newValue, 0);
        NSString *title = [NSString stringWithFormat:@"发送(100/%ld)",(long)newValue];
        [self.launchButton setTitle:title forState:UIControlStateNormal];
        
    }
}

- (void)tap:(UITapGestureRecognizer *)recongnizer{
    [self.textView resignFirstResponder];
    
}
- (UIWindow *)keyWindow{
    return [UIApplication sharedApplication].keyWindow;
}

- (void)hidden:(void(^)(void))complete{
    NSLog(@"隐藏啦");
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (complete) {
            complete();
        }
    }];
}
- (void)show:(void (^) (void))completeBlock{
    
    if (self.superview) {
        NSLog(@"已经显示了啊");
        return;
    }
    

    [[self keyWindow] addSubview:self];
    self.alpha=0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        
        [self.textView becomeFirstResponder];
    }];
    
}

- (IBAction)cancleAction:(UIButton *)sender {
    [self hidden:nil];
}




@end
