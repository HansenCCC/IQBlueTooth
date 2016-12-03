//
//  IQBTControlViewController.h
//  IQBlueTooth
//
//  Created by 力王 on 16/11/16.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface IQBTControlViewController : UIViewController
@property(nonatomic, strong) CBPeripheral *connectPeripheral;//连接上的设备
@end
