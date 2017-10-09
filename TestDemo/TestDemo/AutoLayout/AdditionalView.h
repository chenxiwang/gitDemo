//
//  AdditionalView.h
//  TestDemo
//
//  Created by wcx on 2017/9/30.
//  Copyright © 2017年 wcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdditionalView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic, strong) AdditionalView *customView;
@end
