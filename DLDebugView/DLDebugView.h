//
//  DLDebugView.h
//  BaseProject
//
//  Created by DeliveLee on 18/08/2017.
//  Copyright © 2017 DeliveLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDAutoLayout/SDAutoLayout.h>


# define DLLog(type,fmt, ...) [[DLDebugView sharedManager] addDebugInfo:[NSString stringWithFormat:(fmt), ##__VA_ARGS__] withInfoType:type];

//#define DLLog

extern int const btnWidth;
extern int const btnOffsetForScreenEdge;

typedef enum : NSUInteger {
    DLDebugViewInfoMessage,
    DLDebugViewInfoError,
    DLDebugViewInfoWarning,
} DLDebugViewInfoType;

@interface DLDebugView : UIView

+ (instancetype)sharedManager;

-(void)addDebugInfo:(NSString *)str withInfoType:(DLDebugViewInfoType)infoType;
-(void)addDebugInfo:(NSString *)str;


@end
