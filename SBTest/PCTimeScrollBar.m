//
//  PCTimeScrollBar.m
//  SBTest
//
//  Created by mjlee on 14-2-28.
//  Copyright (c) 2014年 mjlee. All rights reserved.
//

#import "PCTimeScrollBar.h"

@implementation PCTimeScrollBar

-(void)dealloc{
    _tableView      = nil;
    _scrolIndicator = nil;
    [_label release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame tableView:(UITableView*)scrollview
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tableView = scrollview;
        self.frame = CGRectMake(-frame.size.width-10,frame.origin.y,frame.size.width, frame.size.height);
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
        
        UILabel*label = [[UILabel alloc] initWithFrame:CGRectMake(4,4,CGRectGetWidth(frame)-4*2,
                                                                  CGRectGetHeight(frame)-4*2)];
        label.backgroundColor = [UIColor blackColor];
        label.numberOfLines   = 2;
        label.textColor       = [UIColor whiteColor];
        label.textAlignment   = NSTextAlignmentCenter;
        label.font= [UIFont systemFontOfSize:11];
        [self addSubview:label];
        self.label = label;
        [label release];
    }
    return self;
}

-(NSIndexPath*)getIndexPath
{
    CGPoint point = CGPointMake([self center].x, CGRectGetMaxY(self.frame));//[self center];
    point = [_scrolIndicator convertPoint:point toView:_tableView];
    
    UIView *view = [_tableView hitTest:point withEvent:UIEventTypeTouches];
    UIView *superv = view.superview;
    do
    {
        if ([superv isKindOfClass:[UITableViewCell class]]) {
            break;
        }
        superv = superv.superview;
    } while (NO);
    if ([superv isKindOfClass:[UITableViewCell class]])
    {
        NSIndexPath* path = [_tableView indexPathForCell:(UITableViewCell*)superv];
        return path;
    }
    return nil;
}

-(UIImageView*)getIndecatorView{
    for (id subview in [_tableView subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            UIImageView *imageView = (UIImageView *)subview;
            if (imageView.frame.size.width == 7.0f || imageView.frame.size.width == 3.5f)
            {
                imageView.clipsToBounds = NO;
                [imageView addSubview:self];
                return imageView;
            }
        }
    }
    return nil;
}

- (void)scrollViewDidScroll
{
    if (!_scrolIndicator) {
        _scrolIndicator = [self getIndecatorView];
        if (!_scrolIndicator) {
            return;
        }
    }
    _lastContentOffset = _tableView.contentOffset;
    
    self.frame = CGRectMake(self.frame.origin.x,
                           (CGRectGetHeight(_scrolIndicator.frame) / 2.0f) - (CGRectGetHeight(self.frame) / 2.0f),
                           self.frame.size.width,
                           self.frame.size.height);
}

- (void)scrollViewDidEndDecelerating{}
- (void)scrollViewWillBeginDragging{}



@end
