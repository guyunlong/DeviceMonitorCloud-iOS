//
//  BoxModel.m
//  FarmMonitor
//
//  Created by guyunlong on 6/18/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "BoxModel.h"

@implementation BoxModel
+(instancetype)BoxModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];//kvc
       
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%s---%@",__func__,key);
}
@end
