//
//  BoxCell.h
//  FarmMonitor
//
//  Created by guyunlong on 6/17/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxModel.h"
@interface BoxCell : UITableViewCell
+ (instancetype)BoxCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)BoxModel  *model;
@end
