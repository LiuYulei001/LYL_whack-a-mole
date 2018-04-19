//
//  MouseItemView.h
//  LYL_whack-a-mole
//
//  Created by Rainy on 2018/4/18.
//  Copyright © 2018年 WealthOnline_iOS_team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MouseItemView;

@protocol MouseItemViewDelegate <NSObject>

- (void)hitMouse:(MouseItemView *)mouseItem;

@end

@interface MouseItemView : UIView

@property(nonatomic,weak)id<MouseItemViewDelegate> delegate;

- (void)mouseOutHole;
- (void)mouseInHole;

@end
