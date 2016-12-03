//
//  NSData+GWConversion.m
//  Grasswonder
//
//  Created by Grasswonder on 2014/8/19.
//  Copyright (c) 2014年 Grasswonder. All rights reserved.
//

#import "NSData+GWConversion.h"

@implementation NSData (GWConversion)

#pragma mark - String Conversion
- (NSString *)hexadecimalString {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [self length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

@end
