//
//  AutoTableViewCell.m
//  TestDemo
//
//  Created by wcx on 2017/9/30.
//  Copyright © 2017年 wcx. All rights reserved.
//

#import "AutoTableViewCell.h"
#import "Masonry.h"
#import "AdditionalView.h"
@interface AutoTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelBottomConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottomConstraints;
@property (weak, nonatomic) IBOutlet AdditionalView *theAdditionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraints;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelConstraints;

@end
@implementation AutoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
    
}



- (void)setShowAdditionView:(BOOL)showAdditionView{
    _showAdditionView = showAdditionView;
    
   
    if (_showAdditionView) {
        self.theAdditionView.hidden = NO;
        [self.labelConstraints setActive:YES];
        [self.imageConstraints setActive:YES];
    }else{
        self.theAdditionView.hidden = YES;
        [self.labelConstraints ];
        [self.imageConstraints setActive:NO];
    }
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
