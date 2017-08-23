//
//  DLDataViewCell.h
//  BaseProject
//
//  Created by DeliveLee on 21/08/2017.
//  Copyright © 2017 DeliveLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLDebugView.h"
@class DLDataViewCellModel;

@interface DLDataViewCell : UITableViewCell

@property (nonatomic, retain)UILabel *lblInfo;

@property (nonatomic, retain)DLDataViewCellModel *model;

@end


@interface DLDataViewCellModel : NSObject

@property (nonatomic,copy) NSString *info;
@property (nonatomic,assign) DLDebugViewInfoType type;

+ (DLDataViewCellModel *)initModel:(NSString *)info withType:(DLDebugViewInfoType)type;

@end
