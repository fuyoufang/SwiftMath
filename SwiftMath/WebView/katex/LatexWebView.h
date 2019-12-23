//
//  LatexWebView.h
//  LATEX
//
//  Created by Netban on 2019/2/1.
//  Copyright © 2019年 scn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^LatexWebViewHeight)(CGFloat webViewHeight);
@interface LatexWebView : UIWebView
-(instancetype)initWithFrame:(CGRect)frame HTMLString:(NSString *)html;
@property(nonatomic, copy) LatexWebViewHeight laetxWebViewHeight;
@end

NS_ASSUME_NONNULL_END
