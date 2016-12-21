# IQBlueTooth
蓝牙学习和研究，Bluetooth

蓝牙开发的话，推荐各位下个手机app，名字：lightBlue，很有用哦。可以扫描附近的蓝牙，和发送指令并模拟蓝牙。
iOS 蓝牙连接和发送指令初级学习dome
代码不适合用来开发，适合用来学习。公司做硬件开发，app和蓝牙设备交互。虽然公司本来就有蓝牙这方面的框架，但是介于我还只是理论知识，并没有实践经验。于是便写了个dome，试试效果。dome可以实现获取去周围蓝牙设备，连接蓝牙，并发送指令。当然我的指令肯定和你的蓝牙指令不同


代码片段：
@interface ViewController ()<CBCentralManagerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) CBCentralManager *manager;//建立中心角色
@property(nonatomic, strong) NSMutableArray <CBPeripheral *>*peripherals; //用于保存被发现设备;
@property(nonatomic, strong) UITableView *tableView;
@end

代码片段：
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

![image] (https://raw.githubusercontent.com/HersonIQ/IQBlueTooth/master/B67421A1F87DAD1287B586135244E880.png)
