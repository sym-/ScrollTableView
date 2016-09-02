//
//  CollectionViewCell.m
//  SwipeTable2
//
//  Created by 宋元明 on 16/8/22.
//  Copyright © 2016年 宋元明. All rights reserved.
//

#import "CollectionViewCell.h"


@interface CollectionViewCell ()


@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(CusTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CusTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    }
    
    return _tableView;
}

-(CusWebView *)webView{
    if (!_webView) {
        _webView = [[CusWebView alloc] init];
    }
    
    return _webView;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_collectionItemModel.urlStr.length == 0) {
        self.tableView.frame = self.bounds;
        
        CGFloat minRequireHeight = [UIScreen mainScreen].bounds.size.height - 44;
        minRequireHeight  -= self.tableView.contentInset.bottom;
        CGSize contentSize = self.tableView.contentSize;
        contentSize.height = MAX(minRequireHeight, contentSize.height);
        self.tableView.contentSize = contentSize;
        
    }
    else{
        self.webView.frame = self.bounds;
        
        CGFloat minRequireHeight = [UIScreen mainScreen].bounds.size.height - 44;
        minRequireHeight  -= self.webView.contentInset.bottom;
        CGSize contentSize = self.webView.contentSize;
        contentSize.height = MAX(minRequireHeight, contentSize.height);
        self.webView.contentSize = contentSize;
        
    }
    
    
}


-(void)setCollectionTableItemModel:(CollectionCellModel *)collectionItemModel{
    _collectionItemModel = collectionItemModel;
    
    [self.tableView refreshWithData:collectionItemModel.collectionItemTableData atIndex:collectionItemModel.index];
    self.tableView.contentInset = UIEdgeInsetsMake(collectionItemModel.tableViewInsetTop, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, collectionItemModel.tableViewOffSet) ;
    
    [self.contentView addSubview:self.tableView];
    [self.webView removeFromSuperview];
    
    
//    CGFloat minRequireHeight = [UIScreen mainScreen].bounds.size.height - 44;
//    minRequireHeight  -= self.tableView.contentInset.bottom;
//    CGSize contentSize = self.tableView.contentSize;
//    contentSize.height = MAX(minRequireHeight, contentSize.height);
//    self.tableView.contentSize = contentSize;
//    contentSize.height = MAX(minRequireHeight, 10000);
//    [self layoutIfNeeded];
    [self setNeedsLayout];
    
}

-(void)setCollectionWebItemModel:(CollectionCellModel *)collectionItemModel{
    _collectionItemModel = collectionItemModel;
    
    [self.webView refreshWishURLStr:collectionItemModel.urlStr];
    
    [self.tableView removeFromSuperview];
    [self.contentView addSubview:self.webView];
    
    self.webView.contentInset = UIEdgeInsetsMake(collectionItemModel.tableViewInsetTop, 0, 0, 0);
    self.webView.contentOffset = CGPointMake(0, collectionItemModel.tableViewOffSet) ;
    
    [self setNeedsLayout];
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    webView.scrollView.contentInset = UIEdgeInsetsMake(self.collectionItemModel.tableViewInsetTop, 0, 0, 0);
//    webView.scrollView.contentOffset = CGPointMake(0, self.collectionItemModel.tableViewOffSet) ;
//    
//    return YES;
//}
//-(void)webViewDidStartLoad:(UIWebView *)webView{
//    webView.scrollView.contentInset = UIEdgeInsetsMake(self.collectionItemModel.tableViewInsetTop, 0, 0, 0);
//    webView.scrollView.contentOffset = CGPointMake(0, self.collectionItemModel.tableViewOffSet) ;
//}
//


@end
