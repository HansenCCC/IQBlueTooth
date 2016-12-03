//
//  NSData+GWDock.m
//  gwdock
//
//  Created by moon on 16/3/2.
//  Copyright © 2016年 heimavista. All rights reserved.
//

#import "NSData+GWDock.h"

@implementation NSData (GWDock)

@end
@implementation NSString (GWDockHexData)
- (NSData *)hexData_gwdock
{
    NSString *hexString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    for (int i = 0; i < ([hexString length] / 2); i++) {
        byte_chars[0] = [hexString characterAtIndex:i*2];
        byte_chars[1] = [hexString characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }
    return commandToSend;
}

@end
