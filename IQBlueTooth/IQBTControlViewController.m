//
//  IQBTControlViewController.m
//  IQBlueTooth
//
//  Created by 力王 on 16/11/16.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "IQBTControlViewController.h"
#import "NSData+GWDock.h"
#import "NSData+GWConversion.h"
@interface IQBTControlViewController ()<CBPeripheralDelegate>

@end

@implementation IQBTControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.connectPeripheral setDelegate:self]; //查找服务
    [self.connectPeripheral discoverServices:nil];
    
}
#pragma mark - action
//这些命令是dock设备转动的命令
- (IBAction)topClick:(UIButton *)sender {
    [self sendCommod:@"05 AF 21 00 02 02"];
}
- (IBAction)leftClick:(UIButton *)sender {
    [self sendCommod:@"05 AF 21 02 00 02"];
}
- (IBAction)rightClick:(UIButton *)sender {
    [self sendCommod:@"05 AF 22 02 00 02"];
}
- (IBAction)bottomClick:(UIButton *)sender {
    [self sendCommod:@"05 AF 23 00 02 02"];
}
- (IBAction)InitializationClick:(UIButton *)sender {
    NSLog(@"初始化");
    [self sendCommod:@"05 AF 02 00 00 00"];
    //@"05 AF 02 00 00 00"
}
-(void)sendCommod:(NSString *)commodString{
    CBService *service = self.connectPeripheral.services.firstObject;
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([[c UUID] isEqual:[CBUUID UUIDWithString:@"FFE1"]])
        { //你的动作}
            NSMutableData *cmdData = [[NSMutableData alloc] initWithData:[commodString hexData_gwdock]];
            [self.connectPeripheral writeValue:cmdData forCharacteristic:c type:CBCharacteristicWriteWithResponse];
        }
    }
}
#pragma mark - CBPeripheralDelegate
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"发现服务");
    if (error)
    {
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        //        if ([self respondsToSelector:@selector(DidNotifyFailConnectService:withPeripheral:error:)])
        //            [self DidNotifyFailConnectService:nil withPeripheral:nil error:nil];
        return;
    }
    for (CBService *service in peripheral.services)
    {
        [peripheral discoverCharacteristics:nil forService:service];
    }
}
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error{
    if (error)
    {
        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    NSLog(@"服务：%@",service.UUID);
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        //发现特征
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        NSLog(@"%@",characteristic.UUID);
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%@",[characteristic.value hexadecimalString]);
    NSLog(@"%@",[[[characteristic.value hexadecimalString] stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString]);
    if (error)
    {
        NSLog(@"Error updating value for characteristic %@ error: %@", characteristic.UUID, [error localizedDescription]);
        return;
    }    
//    NSLog(@"收到的数据：%@",characteristic.value);
//    NSLog(@"%@",[@"05 AF 02 00 00 00" hexData_gwdock]);
}

@end
