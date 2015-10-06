//
//  Detail.m
//  UItest
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "Detail.h"

@implementation Detail


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        _MyDescription = value;
    }
    NSLog(@"异常的Key:%@",key);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@,description:%@", _title,_MyDescription];
}



@end
