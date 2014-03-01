//
//  UIImageView+PSSB.m
//  SBTest
//
//  Created by mjlee on 14-2-28.
//  Copyright (c) 2014年 mjlee. All rights reserved.
//

#import "UIImageView+PSSB.h"
#import <objc/runtime.h>

@implementation UIImageView (PSSB)

-(void)setAlpha:(float)alpha {
    static char overkey;
    NSString* hadsign = (NSString*)objc_getAssociatedObject(self,&overkey);
    if (hadsign == nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kKeyUserMsgOnScrollviewIndicator
                                                            object:self];
        NSString *hadsign = [[NSString alloc] initWithFormat:@"%@",@"kadsign"];
        objc_setAssociatedObject(self, &overkey,hadsign, OBJC_ASSOCIATION_RETAIN);
    }

    if (self.superview.tag == noDisableVerticalScrollTag) {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleLeftMargin) {
            if (self.frame.size.width < 10 && self.frame.size.height > self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.height < sc.contentSize.height) {
                    return;
                }
            }
        }
    }
    
    if (self.superview.tag == noDisableHorizontalScrollTag) {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
            if (self.frame.size.height < 10 && self.frame.size.height < self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.width < sc.contentSize.width) {
                    return;
                }
            }
        }
    }
    [super setAlpha:alpha];
}
@end
