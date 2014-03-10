//
//  PCTimeScrollBar.h
//  SBTest
//
//  Created by mjlee on 14-2-28.
//  Copyright (c) 2014年 mjlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCTimeScrollBar : UIView
{
    CGPoint       _lastContentOffset;
    
    int           _scrollDirection;// 1:向上 2：向下
    UITableView*  _tableView;
    UIImageView*  _scrolIndicator;
}
@property(nonatomic,retain)UILabel* label;

- (id)initWithFrame:(CGRect)frame tableView:(UITableView*)scrollview;

// scrollviewdelegate
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDecelerating;
- (void)scrollViewWillBeginDragging;

// get current index
-(NSIndexPath*)getIndexPath;

@end
