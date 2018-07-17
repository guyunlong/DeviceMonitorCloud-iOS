//
//  BoxCell.m
//  FarmMonitor
//
//  Created by guyunlong on 6/17/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "BoxCell.h"
#import "UIView+Common.h"
#import "NSString+Common.h"
@interface BoxCell()
@property(nonatomic,weak)IBOutlet UILabel * titleLb;
@property(nonatomic,weak)IBOutlet UILabel * statusLb;
@end
@implementation BoxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(BoxModel *)model{
    if (model) {
        _model = model;
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_titleLb setText:_model.tit];
    [_titleLb setWidth:[_model.tit getWidthWithFont:_titleLb.font constrainedToSize:CGSizeMake(750, 100)]];
    [_statusLb setText:_model.ste?@"ON":@"Off"];
    
}
+ (instancetype)BoxCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"BoxCellIdentify";//对应xib中设置的identifier
    BoxCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BoxCell" owner:self options:nil] objectAtIndex:0];
    }
    return cell;
    
}

@end
