//
//  MDockerGetManager.m
//  ZOOM
//
//  Created by guyunlong on 6/8/18.
//  Copyright © 2018 Weshape3D. All rights reserved.
//

#import "FarmGetManager.h"
#import "FFHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "BoxModel.h"
@implementation FarmGetManager
+(void)Login:(NSString*)usr password:(NSString*)password success:(void (^)(id))success failure:(void (^)(int ))failure;{
    NSString * url =[NSString stringWithFormat: @"http://www.mowa-cloud.com/svr/app.php?act=log&usr=%@&pwd=%@",usr,password];

    [FFHttpTool GET:url parameters:nil success:^(id succss) {
        
        NSError *error;
        //转化为json格式
        NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:succss options:NSJSONReadingMutableLeaves error:&error];
        if ([dictionary[@"uid"] integerValue] > 0) {
            success(dictionary[@"uid"]);
        }
        else{
             failure(-1);
        }
        NSLog(@"success is %@",dictionary);
    } failure:^(NSError * error) {
        NSLog(@"error is %@",error.localizedDescription);
         failure(10000);
    }];
}
+(void)getBoxList:(NSString*) usr password:(NSString*)password success:(void (^)(id))success failure:(void (^)(int ))failure{
    NSString * url =[NSString stringWithFormat: @"http://www.mowa-cloud.com/svr/app.php?act=lst&usr=%@&pwd=%@",usr,password];
    NSLog(@"url is %@",url);
    [FFHttpTool GET:url parameters:nil success:^(id succss) {
        
        NSError *error;
        //转化为json格式
        NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:succss options:NSJSONReadingMutableLeaves error:&error];
        NSMutableArray * list = [NSMutableArray new];
        NSArray * items = dictionary[@"itm"];
        for (NSDictionary * dic in  items) {
            BoxModel * model = [BoxModel BoxModelWithDict:dic];
            [list addObject:model];
        }
        success([list copy]);
        NSLog(@"success is %@",dictionary);
    } failure:^(NSError * error) {
        NSLog(@"error is %@",error.localizedDescription);
        failure(10000);
    }];
}

@end
