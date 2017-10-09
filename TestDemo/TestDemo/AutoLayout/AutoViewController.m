//
//  AutoViewController.m
//  TestDemo
//
//  Created by wcx on 2017/9/30.
//  Copyright © 2017年 wcx. All rights reserved.
//

#import "AutoViewController.h"
#import "AutoTableViewCell.h"
@interface AutoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation AutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   // [self.tableView registerClass:[AutoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AutoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = 80;
    
    [self.dataArray addObjectsFromArray:@[@{@"title":@"你需要做的是為你的標籤提供合理的over-constrain"},@{@"title":@"然後，當你想讓它們向左移動時"},@{ @"title":@"一個重要的警告:如果你想要回你的左視圖圖中,不僅要將它添加回視圖層次,但你也必須同時重建所有的約束。 這意味著只要視圖顯示在視圖和標籤之間，你就需要一種方法來將 10個pt間距約束放在。"},@{@"title":@"在運行時添加或者刪除約束是一個嚴重影響性能的重量級操作。 然而，還有一個更簡單的選擇。",},@{@"title":@"我最後做的是創建 2 xibs 。 一個帶有左視圖，另一個沒有。 我在控制器中註冊了兩個，然後決定在cellForRowAtIndexPath時使用哪一個。他們使用相同的UITableViewCell類。 缺點是xibs之間的內容有一些重複，但是這些單元格非常基本。 好處是我沒有手工管理刪除視圖，更新約束等的代碼。一般來說，這可能是一個更好的解決方案，因為它們在技術上是不同的布局，因此應該有不同的xibs 。复制代码"},@{@"title":@"我的項目使用了一個定製的@IBDesignable 插件的UILabel ( 。以確保顏色，字體，等等的一致性，)，我已經實現了類似下面這樣的插件："},@{ @"title":@"如果這有助於別人，我構建了一個 helper 類"},@{ @"title":@"左視圖將會消",},@{@"title":@"時重建所有的約束。 這意味著只要視圖顯示在視圖和標籤之"}]];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AutoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.nameLabel.text = self.dataArray[indexPath.row][@"title"];
    cell.showAdditionView = (indexPath.row%2 == 0) ? YES : NO;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
