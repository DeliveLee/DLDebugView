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
    BOOL lockInBottom;
    long messageMaxLimit;

    
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
    messageMaxLimit = 100;
    lockInBottom = YES;
    [self createUI];
    
    return self;
}

-(void)createUI{
    debugInfoArr  = [NSMutableArray new];
    self.layer.borderColor = [UIColor.blackColor colorWithAlphaComponent:0.4].CGColor;
    self.layer.borderWidth = 1;
    self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
    [self createDebugView];
    [self createButtonGroup];
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
    .topEqualToView(self)
    .rightEqualToView(self)
    .leftEqualToView(self)
    .bottomSpaceToView(self, 30);
    
}

-(void)createButtonGroup{
    UIView *buttonGroupView = [UIView new];
    buttonGroupView.backgroundColor = UIColor.yellowColor;
    [self addSubview:buttonGroupView];
    buttonGroupView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(debugView, 0)
    .bottomSpaceToView(self, 0);
    
    UIButton *btnClear = [UIButton new];
    [btnClear setTitle:@"Clear" forState:UIControlStateNormal];
    [btnClear setBackgroundColor: [UIColor colorWithRed:255.f/255 green:219.f/255 blue:9.f/255 alpha:1.f]];
    [btnClear setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
    [buttonGroupView addSubview:btnClear];
    btnClear.sd_layout
    .topSpaceToView(buttonGroupView, 0)
    .bottomSpaceToView(buttonGroupView, 0)
    .leftSpaceToView(buttonGroupView, 0);
    [btnClear addTarget:self action:@selector(clearMessage) forControlEvents:UIControlEventTouchUpInside];
    

    
    UIButton *btnLock = [UIButton new];
    [btnLock setTitle:@"UnLock" forState:UIControlStateNormal];
    [btnLock setBackgroundColor: [UIColor colorWithRed:128.f/255 green:128.f/255 blue:128.f/255 alpha:1.f]];
    [btnLock setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
    [buttonGroupView addSubview:btnLock];
    btnLock.sd_layout
    .topSpaceToView(buttonGroupView, 0)
    .bottomSpaceToView(buttonGroupView, 0)
    .leftSpaceToView(btnClear, 0)
    .rightSpaceToView(buttonGroupView, 0);
    [btnLock addTarget:self action:@selector(lockTableView:) forControlEvents:UIControlEventTouchUpInside];


    buttonGroupView.sd_equalWidthSubviews = @[btnClear,btnLock];
    
    
}

-(void)clearMessage{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Clear Message" message:@"Do you sure clear all Message?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Remove", nil];
    [alert show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"Remove"] ) {
        [debugInfoArr removeAllObjects];
        [debugView reloadData];
    }
 }


-(void)lockTableView:(UIButton *)sender{
    lockInBottom = !lockInBottom;
    
    if(lockInBottom){
        if(debugInfoArr.count>0){
            NSIndexPath *ipath = [NSIndexPath indexPathForRow: debugInfoArr.count - 1 inSection: 0];
            [debugView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated:NO];
        }

        [sender setTitle:@"UnLock" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"Lock" forState:UIControlStateNormal];
    }

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
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    str = [NSString stringWithFormat:@"%@   TYPE:%@\n%@",[formatter stringFromDate:[NSDate date]], typeStr,str];
    if(debugInfoArr.count >= messageMaxLimit && messageMaxLimit != 0){
        [debugInfoArr removeObjectAtIndex:0];
    }
    [debugInfoArr addObject:[DLDataViewCellModel initModel:str withType:infoType]];
    [debugView reloadData];
    
    if(lockInBottom){
        NSIndexPath *ipath = [NSIndexPath indexPathForRow: debugInfoArr.count - 1 inSection: 0];
        [debugView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated:YES];
    }

}

-(void)addDebugInfo:(NSString *)str{
    [self addDebugInfo:str withInfoType:DLDebugViewInfoMessage];
}

-(void)setMessageMaxLimit:(long)maxLimit{
    messageMaxLimit = maxLimit;
    NSUInteger count = debugInfoArr.count;
    if(messageMaxLimit != 0 && count > messageMaxLimit){
        [debugInfoArr removeObjectsInRange:NSMakeRange(0, count - messageMaxLimit)];
    }
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


@end
