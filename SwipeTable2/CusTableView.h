//
//  CusTableView.h
//  SwipeTable2
//
//  Created by 宋元明 on 16/8/22.
//  Copyright © 2016年 宋元明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusTableView : UITableView

- (void)refreshWithData:(id)data atIndex:(NSInteger)index;

@end
