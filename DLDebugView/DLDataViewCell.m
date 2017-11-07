//
//  DLDataViewCell.m
//  BaseProject
//
//  Created by DeliveLee on 21/08/2017.
//  Copyright © 2017 DeliveLee. All rights reserved.
//

#import "DLDataViewCell.h"

@implementation DLDataViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lblInfo = [UILabel new];
        _lblInfo.font = [UIFont systemFontOfSize:11];

        [self.contentView addSubview:_lblInfo];
        
        _lblInfo.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 2)
        .autoHeightRatio(0);
        
    }
    return self;
}

- (void)setModel:(DLDataViewCellModel *)model
{
    _model = model;
    _lblInfo.text = model.info;
    UIColor *textColor;
    DLDebugViewInfoType type = model.type;
    switch (type) {
        case DLDebugViewInfoMessage:{
            textColor = UIColor.whiteColor;
            break;
        }
        case DLDebugViewInfoError:{
            textColor = UIColor.redColor;
            break;
        }
        case DLDebugViewInfoWarning:{
            textColor = UIColor.blueColor;
            break;
        }
        default:
            break;
    }
    _lblInfo.textColor = textColor;

    [self setupAutoHeightWithBottomViewsArray:@[_lblInfo] bottomMargin:2];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLDataViewCellModel

+ (DLDataViewCellModel *)initModel:(NSString *)info withType:(DLDebugViewInfoType)type {
    DLDataViewCellModel *model = [DLDataViewCellModel new];
    model.info = info.length > 0 ? info : @"";
    model.type = type;
    return model;
}

@end

