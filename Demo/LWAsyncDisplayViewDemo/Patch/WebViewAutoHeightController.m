//
//  WebViewAutoHeightController.m
//  LWAsyncDisplayViewDemo
//
//  Created by fallen on 17/4/24.
//  Copyright © 2017年 WayneInc. All rights reserved.
//

#import "WebViewAutoHeightController.h"

@interface WebViewAutoHeightController () <UIWebViewDelegate>

@end

@implementation WebViewAutoHeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        self.title = @"webView自适应高度";
        self.view.backgroundColor = [UIColor lightGrayColor];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.backgroundColor = [UIColor lightGrayColor];
        webView.delegate = self;
        webView.tag = 1000;
        [self.view addSubview:webView];
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSURL *indexFileURL = [mainBundle URLForResource:@"index" withExtension:@"html"];
        [webView loadRequest:[[NSURLRequest alloc] initWithURL:indexFileURL]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //方法1
    CGFloat documentWidth = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').offsetWidth"] floatValue];
    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
    NSLog(@"documentSize = {%f, %f}", documentWidth, documentHeight);
    
    //方法2
    CGRect frame = webView.frame;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = 1;
    
    //    wb.scrollView.scrollEnabled = NO;
    webView.frame = frame;
    
    frame.size.height = webView.scrollView.contentSize.height;
    
    NSLog(@"frame = %@", [NSValue valueWithCGRect:frame]);
    webView.frame = frame;
}

@end
