//
//  ViewController.m
//  IQBlueTooth
//
//  Created by 力王 on 16/10/21.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "IQBTControlViewController.h"
#import "IQBTTableViewCell.h"

@interface ViewController ()<CBCentralManagerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) CBCentralManager *manager;//建立中心角色
@property(nonatomic, strong) NSMutableArray <CBPeripheral *>*peripherals; //用于保存被发现设备;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"BlueTooth";
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.manager.delegate = self;
    
    self.peripherals = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[IQBTTableViewCell class] forCellReuseIdentifier:@"IQBTTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
 
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.tableView.frame = bounds;
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IQBTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IQBTTableViewCell"];
    cell.titleLabel.text = [NSString stringWithFormat:@"蓝牙名称：%@",self.peripherals[indexPath.row].name];
    cell.identifierLabel.text = [NSString stringWithFormat:@"identifier：%@",[self.peripherals objectAtIndex:indexPath.row].identifier];
    cell.rssiLabel.text = [NSString stringWithFormat:@"信号：捕捉失败"];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peripherals.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.manager connectPeripheral:[self.peripherals objectAtIndex:indexPath.row] options:nil];
}
#pragma mark - CBCentralManagerDelegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{//监视central管理器的状态变化
    switch (central.state) {
        case CBManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break; 
        case CBManagerStatePoweredOn:
        {
            NSLog(@">>>CBCentralManagerStatePoweredOn"); //开始扫描周围的外设
            if(![self.manager isScanning]){
                NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:false],CBCentralManagerScanOptionAllowDuplicatesKey, nil];
                [self.manager scanForPeripheralsWithServices:nil options:dic];
            
            }
        }
    }
}
    
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{//搜索到外围设备

    if (![self.peripherals containsObject:peripheral]) {
        [self.peripherals addObject:peripheral];
    }
    [self.tableView reloadData];
//    if ([peripheral.name isEqualToString:@"FieBot-Dock"]) {
//        [self.manager connectPeripheral:peripheral options:nil];
//        NSLog(@"RSSI:%@  name= %@",RSSI,peripheral.name);
//        
//    }
}
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{//当和一个periphereal 设备成功建立连接是调用    
    IQBTControlViewController *control = [[IQBTControlViewController alloc] init];
    control.connectPeripheral = peripheral;
    [self.navigationController pushViewController:control animated:YES];
    NSLog(@"连接成功");
}
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{//当central管理者与peripheral 建立链接失败时调用。
    NSLog(@"连接失败");
//    [central scn];
}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{//当已经与peripheral建立的连接断开时调用。
    NSLog(@"连接断开");
}
@end
