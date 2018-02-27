//
//  BSBaseWebView.h
//  Pods
//
//  Created by Yang.Lv on 2017/4/1.
//
//

#import <UIKit/UIKit.h>
@class LYBaseWebView;

@protocol LYBaseWebViewDelegate <NSObject>

@optional
- (void)webView:(LYBaseWebView *)webView didChangeHeight:(float)height;

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end

/**
 *  基础的webview
 */
@interface LYBaseWebView : UIWebView

// 判断webview的高度是否跟contentSize的高度保持一致，default is YES
@property (nonatomic, assign) BOOL adjustHeight;

@property (nonatomic, weak) id<LYBaseWebViewDelegate> baseDelegate;

@end
