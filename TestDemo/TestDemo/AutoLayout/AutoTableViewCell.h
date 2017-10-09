//
//  AutoTableViewCell.h
//  TestDemo
//
//  Created by wcx on 2017/9/30.
//  Copyright © 2017年 wcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, assign) BOOL showAdditionView;
@end
