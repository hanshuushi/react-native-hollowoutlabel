//
//  LTHollowoutLabel.m
//  LTHollowoutLabel
//
//  Created by 范舟弛 on 2017/6/22.
//  Copyright © 2017年 范舟弛. All rights reserved.
//

#import "LTHollowoutLabel.h"

@interface InvertedMaskLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets edge;
@end

@implementation InvertedMaskLabel
@synthesize edge = _edge;

- (void)setEdge:(UIEdgeInsets)edge {
    _edge = edge;
    
    [self sizeToFit];
}

- (void)drawTextInRect:(CGRect)rect {
    
    CGRect textRect = UIEdgeInsetsInsetRect(rect, _edge);
    
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    if (gc == nil) {
        return;
    }
    
    CGContextSaveGState(gc);
    CGContextSetFillColorWithColor(gc, [UIColor whiteColor].CGColor);
    CGContextFillRect(gc, rect);
    CGContextSetBlendMode(gc, kCGBlendModeClear);
    
    [super drawTextInRect:textRect];
    
    CGContextRestoreGState(gc);
}

- (void)sizeToFit {
    [super sizeToFit];
    
    CGRect frame = self.frame;
    
    CGSize size = frame.size;
    
    size.width = size.width + _edge.left + _edge.right;
    
    size.height = size.height + _edge.top + _edge.bottom;
    
    frame.size = size;
    
    self.frame = frame;
}


@end

@interface LTHollowoutLabel()

@property (nonatomic, strong) InvertedMaskLabel *hollowoutLabel;
@property (nonatomic, strong) UIView *hollowoutView;
@property (nonatomic, assign) UIEdgeInsets edge;

@end

@implementation LTHollowoutLabel
@synthesize hollowoutLabel = _hollowoutLabel;
@synthesize hollowoutView = _hollowoutView;
@synthesize edge = _edge;

- (UILabel *)hollowoutLabel {
    if (_hollowoutLabel == nil) {
        _hollowoutLabel = [[InvertedMaskLabel alloc] init];
        
        _hollowoutLabel.font = [UIFont systemFontOfSize:12];
        
        [self.hollowoutView setMaskView:_hollowoutLabel];
    }
    
    return _hollowoutLabel;
}

- (UIView *)hollowoutView {
    if (_hollowoutView == nil) {
        _hollowoutView = [[UIView alloc] init];
        
        [self addSubview:_hollowoutView];
    }
    
    return _hollowoutView;
}

- (void)setText:(NSString *)text {
    self.hollowoutLabel.text = text;
    
    [self viewDidLayout];
}

- (void)setFontSize:(CGFloat)size {
    if (self.hollowoutLabel.font == nil) {
        self.hollowoutLabel.font = [UIFont systemFontOfSize:size];
    } else {
        NSString *fontName = self.hollowoutLabel.font.fontName;
        
        self.hollowoutLabel.font = [UIFont fontWithName:fontName
                                                   size:size];
    }
    
    [self viewDidLayout];
}

- (void)setIosFontName:(NSString *)fontName {
    CGFloat fontSize = 12;
    
    if (self.hollowoutLabel.font != nil) {
        fontSize = self.hollowoutLabel.font.pointSize;
    }
    
    UIFont *font = [fontName isEqualToString:@""] ? [UIFont systemFontOfSize:fontSize] : [UIFont fontWithName:fontName size:fontSize];
    
    self.hollowoutLabel.font = font;
    
    [self viewDidLayout];
}

- (void)setEdge:(UIEdgeInsets)edge {
    _edge = edge;
    
    self.hollowoutLabel.edge = edge;
    
    [self viewDidLayout];
}

- (void)setColor:(UIColor *)color {
    self.hollowoutView.backgroundColor = color;
}

- (void)viewDidLayout {
    
    CGFloat selfWidth = self.bounds.size.width;
    
    CGFloat selfHeight = self.bounds.size.height;
    
    if (selfWidth == 0 || selfHeight == 0) {
        
        self.hollowoutView.hidden = YES;
        
        return;
    }
    
    self.hollowoutView.hidden = NO;
    
    [self.hollowoutLabel sizeToFit];
    
    /// Layout View
    CGRect frame = self.hollowoutView.frame;
    
    CGSize size = frame.size;
    
    size.width = MIN(self.hollowoutLabel.bounds.size.width, selfWidth);
    
    size.height = MIN(self.hollowoutLabel.bounds.size.height, selfHeight);
    
    frame.size = size;
    
    self.hollowoutView.frame = frame;
    
    self.hollowoutLabel.frame = self.hollowoutView.bounds;
    
    /// center in containner
    self.hollowoutView.center = CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2.0,
                                            self.bounds.origin.y + self.bounds.size.height / 2.0);
}

- (void)layoutSubviews {
    [self viewDidLayout];
}

@end
