//
//  AccountManager.h
//  FarmMonitor
//
//  Created by guyunlong on 6/18/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject
+(void)setUser:(NSString*)user;
+(void)setPwd:(NSString*)pwd;
+(NSString*)getUser;
+(NSString*)getPwd;
@end
