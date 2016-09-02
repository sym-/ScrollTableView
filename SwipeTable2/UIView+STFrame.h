//
//  UIView+STFrame.h
//  SwipeTableView
//
//  Created by Roy lee on 16/4/1.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface UIView (STFrame)

@property (nonatomic, assign) CGFloat st_x;
@property (nonatomic, assign) CGFloat st_y;
@property (nonatomic, assign) CGFloat st_width;
@property (nonatomic, assign) CGFloat st_height;
@property (nonatomic, assign) CGFloat st_centerX;
@property (nonatomic, assign) CGFloat st_centerY;
@property (nonatomic, assign) CGSize st_size;
@property (nonatomic, assign) CGFloat st_top;
@property (nonatomic, assign) CGFloat st_bottom;
@property (nonatomic, assign) CGFloat st_left;
@property (nonatomic, assign) CGFloat st_right;

@end
