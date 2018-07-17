//
//  AccountManager.m
//  FarmMonitor
//
//  Created by guyunlong on 6/18/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager
+(void)setUser:(NSString*)user{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:user forKey:@"user"];
}
+(void)setPwd:(NSString*)pwd{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:pwd forKey:@"pwd"];
}
+(NSString*)getUser{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * user =[userDefault objectForKey:@"user"];
    return  user;
}
+(NSString*)getPwd{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * pwd =[userDefault objectForKey:@"pwd"];
    return  pwd;
}
@end
