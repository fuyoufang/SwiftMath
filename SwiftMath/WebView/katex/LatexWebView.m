//
//  LatexWebView.m
//  LATEX
//
//  Created by Netban on 2019/2/1.
//  Copyright © 2019年 scn. All rights reserved.
//

#import "LatexWebView.h"
#define DEFAULT_DELIMITER @"$"

@interface LatexWebView()<UIWebViewDelegate>
@property(nonatomic, strong) NSString *originHTML;
@end

@implementation LatexWebView

-(instancetype) initWithFrame:(CGRect)frame HTMLString:(NSString *)html{
    if (self = [super initWithFrame:frame]) {
        self.originHTML = html;
//        self.scalesPageToFit = YES;
        [self dealWithHTMLString:html];
    }
    return self;
}
-(void)dealWithHTMLString:(NSString *)html{
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    if([html rangeOfString:@"$"].location != NSNotFound) { // Expression inside text.
        NSRange r;
        BOOL intex = NO;
        while ((r = [html rangeOfString:DEFAULT_DELIMITER]).location != NSNotFound) {
            html = [html stringByReplacingCharactersInRange:r withString:(intex ? @"</span>" : @"<span class=\"tex\">")];
            intex = !intex;
        }
        if (intex) NSLog(@"没有闭合");
    }
    appHtml = [appHtml stringByReplacingOccurrencesOfString:@"$LATEX$"
                                                 withString:html];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self setDelegate:self];
    [self loadHTMLString:appHtml baseURL:baseURL];;
}

// 加载完成 这里主要用来计算高度
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"获取到高度");
    CGRect frames = webView.frame;
    frames.size.height = 1;
//    webView.frame = frames;
//    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
//    frames.size = fittingSize;
//    frames.origin = CGPointMake(self.frame.origin.x, frames.origin.y);
//    
//    NSLog(@"webHeight = %.2f",frames.size.height);
//    if (self.laetxWebViewHeight) {
//        self.laetxWebViewHeight(frames.size.height);
//    }
}

@end
