//
//  CusTableView.m
//  SwipeTable2
//
//  Created by 宋元明 on 16/8/22.
//  Copyright © 2016年 宋元明. All rights reserved.
//

#import "CusTableView.h"

#define RGBColor(r,g,b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface CusTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) NSInteger itemIndex;
@property (nonatomic, assign) NSInteger numberOfRows;

@end

@implementation CusTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorColor = RGBColor(175, 175, 175);
        [self registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
        self.tableFooterView = [UIView new];
        self.itemIndex = -1;
    }
    return self;
}

- (void)refreshWithData:(id)numberOfRows atIndex:(NSInteger)index {
    _numberOfRows = [numberOfRows integerValue];
    _itemIndex = index;
    
    [self reloadData];
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = RGBColor(150, 215, 200);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString * title = nil;
    if (_itemIndex >= 0) {
        title = [NSString stringWithFormat:@"[ ItemView_%ld ] ---- 第 %ld 行",_itemIndex,indexPath.row];
    }else {
        title = [NSString stringWithFormat:@"第 %ld 行",indexPath.row];
    }
    cell.textLabel.text = title;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    STRefreshHeader * header = self.header;
//    CGFloat orginY = - (header.st_height + self.swipeTableView.swipeHeaderView.st_height + self.swipeTableView.swipeHeaderBar.st_height);
//    if (header.st_y != orginY) {
//        header.st_y = orginY;
//    }
}


@end
