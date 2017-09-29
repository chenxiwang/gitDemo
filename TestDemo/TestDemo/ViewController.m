//
//  ViewController.m
//  TestDemo
//
//  Created by wcx on 2017/9/27.
//  Copyright © 2017年 wcx. All rights reserved.
//

#import "ViewController.h"
#import "KeyBoardView.h"
#import "YTButton.h"
#import "NSObject+YYModel.h"

@interface People:NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@end

@implementation People
@end

@interface ViewController ()
@property (nonatomic, strong) KeyBoardView *theBoardView;
@property (weak, nonatomic) IBOutlet YTButton *ytButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ytButton.buttonName = @"hahahah";
    [self.ytButton setTitle:@"点我" forState:UIControlStateNormal];
    [self.ytButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    NSDictionary *dict = @{@"name":@"lili",@"age":[NSNull null]};
    
    People *people = [People yy_modelWithDictionary:dict];
    
    NSLog(@"默认:%ld",people.age.length);
    
    NSString *age = dict[@"age"];
     NSLog(@"默认:%ld",age.length);
}
- (IBAction)clickBtn:(YTButton *)sender {
    NSLog(@"我的名字是%@",sender.buttonName);
}


- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (IBAction)clickAction:(UIButton *)sender {
    [self.theBoardView show:^{
        
    }];
}

- (KeyBoardView *)theBoardView{
    if (!_theBoardView) {
        _theBoardView = [[KeyBoardView alloc] init];
    }
    return _theBoardView;
}

@end
