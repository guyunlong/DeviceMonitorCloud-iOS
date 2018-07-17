//
//  BoxModel.h
//  FarmMonitor
//
//  Created by guyunlong on 6/18/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxModel : NSObject
@property (nonatomic,assign) BOOL ste;
@property (nonatomic,strong) NSString *tit;
@property (nonatomic,strong) NSString *sip;
@property (nonatomic,strong) NSString *bid;
+(instancetype)BoxModelWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
