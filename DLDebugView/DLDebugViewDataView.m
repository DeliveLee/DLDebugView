//
//  DLDebugViewDataView.m
//  BaseProject
//
//  Created by DeliveLee on 18/08/2017.
//  Copyright © 2017 DeliveLee. All rights reserved.
//

#import "DLDebugViewDataView.h"
#import "DLDataViewCell.h"

@interface DLDebugViewDataView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UITableView *debugView;
    NSMutableArray<DLDataViewCellModel *> *debugInfoArr;
    BOOL currentIsInBottom;
}

@end

@implementation DLDebugViewDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self createUI];
    
    return self;
}

-(void)createUI{
    debugInfoArr  = [NSMutableArray new];
    self.layer.borderColor = [UIColor.blackColor colorWithAlphaComponent:0.4].CGColor;
    self.layer.borderWidth = 1;
    self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    [self createDebugView];
}

-(void)createDebugView{
    
    debugView = [UITableView new];
    debugView.delegate = self;
    debugView.dataSource = self;
    debugView.backgroundColor = UIColor.clearColor;
    debugView.separatorStyle = UITableViewCellSeparatorStyleNone;
    debugView.separatorColor = UIColor.whiteColor;
    debugView.tableFooterView = [UIView new];
    [self addSubview:debugView];
    debugView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
}

-(void)addDebugInfo:(NSString *)str withInfoType:(DLDebugViewInfoType)infoType{
    NSString *typeStr;
    switch (infoType) {
        case DLDebugViewInfoError:
            typeStr = @"Error";
            break;
        case DLDebugViewInfoMessage:
            typeStr = @"Message";
            break;
        case DLDebugViewInfoWarning:
            typeStr = @"Warning";
            break;

        default:
            break;
    }
    
    CGFloat distanceFromBottom = debugView.contentSize.height - debugView.frame.size.height;
    if(distanceFromBottom<0){
        currentIsInBottom = YES;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    str = [NSString stringWithFormat:@"%@   TYPE:%@\n%@",[formatter stringFromDate:[NSDate date]], typeStr,str];
    [debugInfoArr addObject:[DLDataViewCellModel initModel:str withType:infoType]];
    [debugView reloadData];

    if(currentIsInBottom){
        [debugView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(debugInfoArr.count-1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(void)addDebugInfo:(NSString *)str{
    [self addDebugInfo:str withInfoType:DLDebugViewInfoMessage];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return debugInfoArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [debugView cellHeightForIndexPath:indexPath model:debugInfoArr[indexPath.row] keyPath:@"model" cellClass:[DLDataViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width - btnWidth];

    return height;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY - 3;
    if (bottomOffset <= height)
    {
        currentIsInBottom = YES;
    }
    else
    {
        currentIsInBottom = NO;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *flag=@"cell";
    DLDataViewCell *cell=[debugView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[DLDataViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    [cell setModel:debugInfoArr[indexPath.row]];
    return cell;

}

-(void)viewDidLayoutSubviews {
    
    if ([debugView respondsToSelector:@selector(setSeparatorInset:)]) {
        [debugView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([debugView respondsToSelector:@selector(setLayoutMargins:)])  {
        [debugView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//}


@end
