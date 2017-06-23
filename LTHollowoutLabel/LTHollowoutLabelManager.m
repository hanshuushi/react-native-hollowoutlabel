//
//  LTHollowoutLabelManager.m
//  LTHollowoutLabel
//
//  Created by 范舟弛 on 2017/6/22.
//  Copyright © 2017年 范舟弛. All rights reserved.
//

#import "LTHollowoutLabelManager.h"
#import "LTHollowoutLabel.h"
#import <React/RCTBridge.h>

@implementation LTHollowoutLabelManager

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

- (UIView *)view
{
    return [[LTHollowoutLabel alloc] init];
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_VIEW_PROPERTY(text, NSString);
RCT_EXPORT_VIEW_PROPERTY(edge, UIEdgeInsets);
RCT_EXPORT_VIEW_PROPERTY(color, UIColor);
RCT_EXPORT_VIEW_PROPERTY(fontSize, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(iosFontName, NSString);

//RCT_CUSTOM_VIEW_PROPERTY(padding, UIEdgeInsets, LTHollowoutLabel) {
//    view.padding = json ? [RCTConvert UIEdgeInsets:json] : UIEdgeInsetsZero;
//}

@end
