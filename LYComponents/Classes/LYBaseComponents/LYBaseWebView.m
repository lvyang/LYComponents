//
//  BSBaseWebView.m
//  Pods
//
//  Created by Yang.Lv on 2017/4/1.
//
//

#import "LYBaseWebView.h"

static NSString *imageAutoFitJs = @"(function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
        var img = imgs[i];   \
        img.style.maxWidth = %f;   \
    } \
})();";

static NSString *videoAutoFitJs = @"(function videoAutoFit() { \
    var videos = document.getElementsByTagName('video'); \
    for (var i = 0; i < videos.length; ++i) {\
        var video = videos[i];   \
        video.setAttribute('style','max-width:100%;height:auto;')\
    } \
})()";

@interface LYBaseWebView () <UIWebViewDelegate>

@end

@implementation LYBaseWebView

/** @override */
- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

/** @override */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

/** @override */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    self.multipleTouchEnabled = NO;
    self.autoresizesSubviews = YES;
    [(UIScrollView *)self.subviews[0] setShowsHorizontalScrollIndicator:NO];
    [(UIScrollView *)self.subviews[0] setShowsVerticalScrollIndicator:NO];
    [(UIScrollView *)self.subviews[0] setBounces:NO];
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    self.adjustHeight = YES;
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    self.delegate = self;
}

- (void)startToChangeHeight
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(heightChanged) object:nil];
    [self performSelector:@selector(heightChanged) withObject:nil afterDelay:0.5];
}

- (void)heightChanged
{
    UIScrollView    *scrollView = self.scrollView;
    CGRect          frame = self.frame;
    
    frame.size.height = scrollView.contentSize.height;
    self.frame = frame;
    
    if ([self.baseDelegate respondsToSelector:@selector(webView:didChangeHeight:)]) {
        [self.baseDelegate webView:self didChangeHeight:self.scrollView.contentSize.height];
    }
}

#pragma mark - KVO method
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.adjustHeight) {
        return;
    }
    
    if ([self.request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return;
    }
    
    [self startToChangeHeight];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *requestURL =[request URL];
    if (([[requestURL scheme] isEqualToString: @"http"]
         || [[requestURL scheme] isEqualToString:@"https"]
         || [[requestURL scheme] isEqualToString: @"mailto" ])
        && (navigationType == UIWebViewNavigationTypeLinkClicked)) {
        return ![[UIApplication sharedApplication] openURL:requestURL];
    }
    
    if ([self.baseDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.baseDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([self.request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return;
    }
    
    if ([self.baseDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.baseDelegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString *js = [NSString stringWithFormat:imageAutoFitJs, self.frame.size.width - 20];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:videoAutoFitJs];
    
    if ([self.request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return;
    }
    
    if (self.adjustHeight) {
        CGRect frame = webView.frame;
        frame.size.height = 1;
        webView.frame = frame;
        CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
        frame.size = fittingSize;
        webView.frame = frame;
    }
    
    if ([self.baseDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.baseDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([self.request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return;
    }
    
    if ([self.baseDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.baseDelegate webView:webView didFailLoadWithError:error];
    }
}

@end
