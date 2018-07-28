//
//  LoginEditCell.h
//  imooc
//
//  Created by guyunlong on 5/18/16.
//  Copyright © 2016 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LoginEditCellIdentify @"LoginEditCellIdentify"
@interface LoginEditCell : UITableViewCell

@property NSInteger row;
@property (copy, nonatomic) void (^textChangeBlock)(NSInteger row,id text);
+ (CGFloat)cellHeight;
@end

