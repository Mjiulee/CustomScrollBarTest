//
//  PSSBViewController.m
//  SBTest
//
//  Created by mjlee on 14-2-20.
//  Copyright (c) 2014年 mjlee. All rights reserved.
//

#import "PSSBViewController.h"
//#import "UIImageView+PSSB.h"
#import <QuartzCore/QuartzCore.h>
#import "PCTimeScrollBar.h"

@interface PSSBViewController ()
<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIImageView* _ptrSBIndicators;
    UITableView* _scrollview;
    PCTimeScrollBar* _timeScrollBar;
}

-(void)SBIndicatorBesign:(NSNotification*)notificate;
@end

@implementation PSSBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))
                                                           style:UITableViewStylePlain];
    _scrollview.delegate   = self;
    _scrollview.dataSource = self;
    _scrollview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_scrollview];
    
//    UILabel* flowingview= [[UILabel alloc] initWithFrame:CGRectMake(230, 0,80, 30)];
//    flowingview.backgroundColor = [UIColor blackColor];
//    flowingview.tag = 100000;
//    flowingview.text= @"";
//    flowingview.textColor = [UIColor whiteColor];
//    flowingview.font= [UIFont systemFontOfSize:14];
//    [self.view addSubview:flowingview];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(SBIndicatorBesign:)
//                                                 name:kKeyUserMsgOnScrollviewIndicator
//                                               object:nil];
    _timeScrollBar = [[PCTimeScrollBar alloc] initWithFrame:CGRectMake(0, 0, 80, 60)
                                                  tableView:_scrollview];
    NSIndexPath* indexpath = [_timeScrollBar getIndexPath];
    if (indexpath) {
        _timeScrollBar.label.text = [NSString stringWithFormat:@"当前是：r%d行",[indexpath row]];        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                              forKeyPath:kKeyUserMsgOnScrollviewIndicator];
}

-(void)SBIndicatorBesign:(NSNotification*)notificate
{
//    NSObject* obj = [notificate object];
//    if (!_ptrSBIndicators && [obj isKindOfClass:[UIImageView class]]) {
//        _ptrSBIndicators = (UIImageView*)obj;
//    }
}

#pragma mark UITableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellid = @"favocellid";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellid];
        UIImageView* imagev = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5,70,70)];
        imagev.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:imagev];
        
        UILabel* labeb = [[UILabel alloc] initWithFrame:
                          CGRectMake(CGRectGetMaxX(imagev.frame)+5,0,
                                     tableView.frame.size.width-CGRectGetMaxX(imagev.frame)-10,20)];
        labeb.text = @"电商名称";
        labeb.font = [UIFont systemFontOfSize:15];
        labeb.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:labeb];
        
        UILabel* labBrief = [[UILabel alloc] initWithFrame:
                             CGRectMake(CGRectGetMaxX(imagev.frame)+5,
                                        CGRectGetMaxY(labeb.frame),
                                        tableView.frame.size.width-CGRectGetMaxX(imagev.frame)-10,40)];
        labBrief.text = @"一次性加载10条数据，上拉拖动到底部时，再加载10条。加载过程中下方显示文字正在努力加载中....";
        labBrief.numberOfLines = 2;
        labBrief.font = [UIFont systemFontOfSize:14];
        labBrief.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:labBrief];
        
        UILabel* labprice = [[UILabel alloc] initWithFrame:
                             CGRectMake(CGRectGetMaxX(imagev.frame)+5,
                                        CGRectGetMaxY(labBrief.frame),
                                        tableView.frame.size.width-CGRectGetMaxX(imagev.frame)-10,20)];
        labprice.text = @"价格";
        labprice.font = [UIFont systemFontOfSize:15];
        labprice.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:labprice];
    }
    return  cell;
}

-(UIImageView*)getIndecatorView{
    for (id subview in [_scrollview subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            UIImageView *imageView = (UIImageView *)subview;
            if (imageView.frame.size.width == 7.0f || imageView.frame.size.width == 3.5f)
            {
                imageView.clipsToBounds = NO;
                //_ptrSBIndicators = imageView;
                return imageView;
            }
        }
    }
    return nil;
}

#pragma mark -
#pragma mark @protocol UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*if (!_ptrSBIndicators) {
        _ptrSBIndicators = [self getIndecatorView];
        
        UILabel* flowingview= [[UILabel alloc] initWithFrame:CGRectMake(-90,0,80, 30)];
        flowingview.backgroundColor = [UIColor blackColor];
        flowingview.tag = 100000;
        flowingview.text= @"";
        flowingview.textColor = [UIColor whiteColor];
        flowingview.font= [UIFont systemFontOfSize:14];
        [_ptrSBIndicators addSubview:flowingview];
    }
    //NSLog(@"_ptrSBIndicators.frame=%@",NSStringFromCGRect(_ptrSBIndicators.frame));
    UILabel* flagview = (UILabel*)[_ptrSBIndicators viewWithTag:100000];
    flagview.frame    = CGRectMake(flagview.frame.origin.x,
                                   (CGRectGetHeight(_ptrSBIndicators.frame) / 2.0f) - (CGRectGetHeight(flagview.frame) / 2.0f),
                                   //[_ptrSBIndicators center].y,
                                   flagview.frame.size.width,
                                   flagview.frame.size.height);
    CGPoint point = [flagview center];
    point = [_ptrSBIndicators convertPoint:point toView:scrollView];
    
    UIView *view = [scrollView hitTest:point withEvent:UIEventTypeTouches];
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
        NSIndexPath* path = [_scrollview indexPathForCell:(UITableViewCell*)superv];
        flagview.text  = [NSString stringWithFormat:@"第：%d",[path row]];
    }*/
    
    [_timeScrollBar scrollViewDidScroll];
    NSIndexPath* indexpath = [_timeScrollBar getIndexPath];
    if (!indexpath) {
        return;
    }
    [_timeScrollBar.label setText:[NSString stringWithFormat:@"第%d行",[indexpath row]]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}


@end
