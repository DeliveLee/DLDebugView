//
//  DLDebugViewDataView.h
//  BaseProject
//
//  Created by DeliveLee on 18/08/2017.
//  Copyright © 2017 DeliveLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLDebugView.h"

@interface DLDebugViewDataView : UIView
-(void)addDebugInfo:(NSString *)str withInfoType:(DLDebugViewInfoType)infoType;
-(void)addDebugInfo:(NSString *)str;

-(void)setMessageMaxLimit:(long)maxLimit;

@end
