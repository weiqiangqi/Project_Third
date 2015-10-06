//
//  Categories.m
//  UItest
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "Categories.h"

@implementation Categories

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"subcategories"]) {
        [_array addObject:value];
    }

    NSLog(@"异常的key:%@",key);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"category_name :%@,数组:%@",self.category_name,_array];
}


@end
