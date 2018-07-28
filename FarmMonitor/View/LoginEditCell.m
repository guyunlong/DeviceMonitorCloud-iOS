//
//  LoginEditCell.m
//  imooc
//
//  Created by guyunlong on 5/18/16.
//  Copyright © 2016 cc. All rights reserved.
//

#import "LoginEditCell.h"
#import "OCHeader.h"
#import "AccountManager.h"
#import <Masonry/Masonry.h>
#define FFPadding 10
@interface LoginEditCell ()
@property (strong, nonatomic) UITextField *textField;
@end
@implementation LoginEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_textField) {
            _textField = [UITextField new];
            [_textField setFont:[UIFont systemFontOfSize:14]];
            [_textField setTextColor:[UIColor colorWithHexString:@"0x535353"]];
            @weakify(self);
            [_textField.rac_textSignal  subscribeNext:^(id x) {
                @strongify(self);
                if (self.textChangeBlock) {
                    _textChangeBlock(self.row,x);
                }
            }];
            [self.contentView addSubview:_textField];
        }
        if (_textField) {
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView.mas_left).with.offset(FFPadding);
                make.right.mas_equalTo(self.contentView.mas_right).with.offset(-FFPadding);
                make.height.mas_equalTo(30);
                make.centerY.mas_equalTo(self.contentView.mas_centerY);
            }];
        }
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (0 == _row) {
        [_textField setPlaceholder:@"账号"];
        [_textField setText:[AccountManager getUser]];
        _textField.secureTextEntry = false;
    }
    else{
        [_textField setPlaceholder:@"密码"];
         [_textField setText:[AccountManager getPwd]];
        _textField.secureTextEntry = true;
    }
}
+ (CGFloat)cellHeight{
    return 40;
}

@end
