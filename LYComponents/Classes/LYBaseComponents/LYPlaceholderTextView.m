/**
 * Create Author : lvy
 * Create Date   : 13-10-24
 * File Name     : PlaceHolderTextView.m
 *
 * Copyright (c) 2011-2014 by Shanghai k-net Information Co. Ltd
 * All rights reserved
 */

#import "LYPlaceholderTextView.h"

@interface LYPlaceholderTextView ()
{
    // 记录textView的初始frame
    CGRect _orignFrame;
}
//  显示默认填充文字的label
@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation LYPlaceholderTextView

/** override */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化方法
/** override */
- (void)awakeFromNib
{
    [super awakeFromNib];

    _orignFrame = self.frame;

    if (!self.placeholder) {
        self.placeholder = @"";
    }

    if (!self.placeHolderColor) {
        self.placeHolderColor = [UIColor lightGrayColor];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

/** override */
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }

    return self;
}

/** override */
- (void)drawRect:(CGRect)rect
{
    if ([[self placeholder] length] > 0) {
        if (_placeHolderLabel == nil) {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, self.bounds.size.width - 3, 0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeHolderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }

        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }

    if (([[self text] length] == 0) && ([[self placeholder] length] > 0)) {
        [[self viewWithTag:999] setAlpha:1];
    }

    [super drawRect:rect];
}

#pragma mark - setter
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}

#pragma mark - notification method
- (void)textChanged:(NSNotification *)notification
{
    if ([[self placeholder] length] == 0) {
        return;
    }

    if ([[self text] length] == 0) {
        [[self viewWithTag:999] setAlpha:1];
    } else {
        [[self viewWithTag:999] setAlpha:0];
    }
}

@end
