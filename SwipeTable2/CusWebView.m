//
//  CusWebView.m
//  SwipeTable2
//
//  Created by 宋元明 on 16/8/25.
//  Copyright © 2016年 宋元明. All rights reserved.
//

#import "CusWebView.h"

@interface CusWebView ()<UIWebViewDelegate>
{
    
}

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation CusWebView

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        [self addSubview:_webView];
    }
    
    return _webView;
}

-(void)refreshWishURLStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:req];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *bodyHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    webView.frame = CGRectMake(0, 0, self.frame.size.width, [bodyHeight floatValue]);
    self.contentSize = CGSizeMake(0, [bodyHeight floatValue] - self.contentInset.top);
}

@end
