//
//  DLDebugView.m
//  BaseProject
//
//  Created by DeliveLee on 18/08/2017.
//  Copyright © 2017 DeliveLee. All rights reserved.
//

#import "DLDebugView.h"
#import "DLDebugViewDataView.h"

int const btnWidth = 40;
int const btnOffsetForScreenEdge = 15;


typedef enum : NSUInteger {
    DebugViewClose,
    DebugViewOpen,
} DebugViewStatus;

typedef enum : NSUInteger {
    DebugViewLeft,
    DebugViewRight,
} DebugViewSideStatus;


@interface DLDebugView ()<UIGestureRecognizerDelegate>{
    UIImageView *buttonView;
    DLDebugViewDataView *debugViewDataView;
    DebugViewStatus debugViewStatus;
    DebugViewSideStatus debugViewSideStatus;
}

@end

static DLDebugView *manager = nil;
static dispatch_once_t pred;


@implementation DLDebugView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharedManager {
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithFrame:CGRectZero];
    });
    return manager;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(btnWidth/2, 64+btnWidth, 0, 0)];
    if (!self) {
        return nil;
    }
    [self createUI];
    
    return self;
}


-(instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self createUI];
    
    return self;
}

-(void)createUI{
    

    
    buttonView = [UIImageView new];
    buttonView.userInteractionEnabled = YES;
    buttonView.image = [UIImage imageNamed:@"icon_drag"];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonViewTaped:)];
    [buttonView addGestureRecognizer:tapGR];
    [self addSubview:buttonView];
    buttonView.sd_layout
    .heightIs(btnWidth)
    .widthIs(btnWidth)
    .leftSpaceToView(self, -btnWidth/2)
    .topSpaceToView(self, -btnWidth/2);
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panButtonHandler:)];
    [buttonView addGestureRecognizer:panGestureRecognizer];
    
    debugViewDataView = [DLDebugViewDataView new];
    [self addSubview:debugViewDataView];
    debugViewDataView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);

    [self bringSubviewToFront:buttonView];

}

-(void)buttonViewTaped:(UITapGestureRecognizer *)recognizer{
    [self sd_clearAutoLayoutSettings];
    if(debugViewStatus == DebugViewOpen){
        debugViewStatus = DebugViewClose;
        self.sd_layout
        .heightIs(0)
        .widthIs(0);
        
    }else{
        debugViewStatus = DebugViewOpen;
        self.sd_layout
        .heightIs([UIScreen mainScreen].bounds.size.height/2)
        .widthIs([UIScreen mainScreen].bounds.size.width - btnWidth);
    }
    
    if(debugViewSideStatus == DebugViewLeft){
        self.sd_layout.leftSpaceToView(self.superview, btnWidth/2);
    }else{
        self.sd_layout.rightSpaceToView(self.superview, btnWidth/2);
    }
    
    
}

-(void)panButtonHandler:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint point = [recognizer translationInView:buttonView];
    
    if(debugViewStatus == DebugViewOpen){
        self.center = CGPointMake(self.center.x, self.center.y + point.y);
        recognizer.view.center = CGPointMake(recognizer.view.center.x + point.x, recognizer.view.center.y);
    }else{
        self.center = CGPointMake(self.center.x + point.x, self.center.y + point.y);
    }

    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];

    if(recognizer.state == UIGestureRecognizerStateEnded){
        CGRect btnFrame = [buttonView convertRect:buttonView.bounds toView:nil];
        
        
        [recognizer.view sd_clearAutoLayoutSettings];
        if (btnFrame.origin.x+(btnWidth/2) < [UIScreen mainScreen].bounds.size.width/2) {
            debugViewSideStatus = DebugViewLeft;
            [UIView animateWithDuration:0.2 animations:^{
                recognizer.view.sd_layout
                .heightIs(btnWidth)
                .widthIs(btnWidth)
                .leftSpaceToView(self, -btnWidth/2);
                [recognizer.view updateLayout];
                if(debugViewStatus == DebugViewClose){
                    [self sd_clearAutoLayoutSettings];
                    self.sd_layout
                    .heightIs(0)
                    .widthIs(0)
                    .leftSpaceToView(self.superview, btnWidth/2);
                    [self updateLayout];
                }
            }];

        }else{
            debugViewSideStatus = DebugViewRight;
            [UIView animateWithDuration:0.2 animations:^{
                recognizer.view.sd_layout
                .heightIs(btnWidth)
                .widthIs(btnWidth)
                .rightSpaceToView(self, -btnWidth/2);
                [recognizer.view updateLayout];
                if(debugViewStatus == DebugViewClose){
                    [self sd_clearAutoLayoutSettings];
                    self.sd_layout
                    .heightIs(0)
                    .widthIs(0)
                    .rightSpaceToView(self.superview, btnWidth/2);
                    [self updateLayout];

                }
            }];

        }
        
    }

}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    CGPoint tempoint = [buttonView convertPoint:point fromView:self];
    if (CGRectContainsPoint(buttonView.bounds, tempoint))
    {
        view = buttonView;
    }
    return view;
}

-(void)addDebugInfo:(NSString *)str withInfoType:(DLDebugViewInfoType)infoType{
    [debugViewDataView addDebugInfo:str withInfoType:infoType];
}
-(void)addDebugInfo:(NSString *)str{
    [debugViewDataView addDebugInfo:str];
}



@end
