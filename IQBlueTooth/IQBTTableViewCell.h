//
//  IQBTTableViewCell.h
//  IQBlueTooth
//
//  Created by 力王 on 16/11/15.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IQBTTableViewCell : UITableViewCell
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *identifierLabel;
@property(nonatomic, strong) UILabel *rssiLabel;
@end
