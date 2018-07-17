//
//  MDockerGetManager.h
//  ZOOM
//
//  Created by guyunlong on 6/8/18.
//  Copyright © 2018 Weshape3D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FarmGetManager : NSObject
+(void)Login:(NSString*) usr password:(NSString*)password success:(void (^)(id))success failure:(void (^)(int ))failure;
+(void)getBoxList:(NSString*) usr password:(NSString*)password success:(void (^)(id))success failure:(void (^)(int ))failure;
+(void)getBoxList:(NSString*) usr password:(NSString*)password success:(void (^)(id))success failure:(void (^)(int ))failure;
@end
