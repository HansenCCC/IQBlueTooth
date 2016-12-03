//
//  IQBTTableViewCell.m
//  IQBlueTooth
//
//  Created by 力王 on 16/11/15.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "IQBTTableViewCell.h"

@interface IQBTTableViewCell ()

@end

@implementation IQBTTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.identifierLabel = [[UILabel alloc] init];
        self.identifierLabel.numberOfLines = 0;
        [self.contentView addSubview:self.identifierLabel];
        
        self.rssiLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.rssiLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    
    CGRect f1 = bounds;
    f1.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f1.origin.x = 10;
    f1.origin.y = 10;
    self.titleLabel.frame = f1;
    
    CGRect f2 = bounds;
    f2.size = [self.rssiLabel sizeThatFits:CGSizeZero];
    f2.origin = CGPointMake(bounds.size.width - f2.size.width - 10, 10);
    self.rssiLabel.frame = f2;
    
    CGRect f3 = bounds;
    f3.size = [self.identifierLabel sizeThatFits:CGSizeMake(bounds.size.width - 20, 0)];
    f3.origin.x = 10;
    f3.origin.y = CGRectGetMaxY(f1) + 10;
    self.identifierLabel.frame = f3;
}
@end
