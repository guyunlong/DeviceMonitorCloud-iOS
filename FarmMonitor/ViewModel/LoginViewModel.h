//
//  LoginViewModel.h
//  FarmMonitor
//
//  Created by guyunlong on 6/18/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
@interface LoginViewModel : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) RACSignal *validLoginSignal;
@property (nonatomic, assign) NSInteger uid;
-(RACSignal *)racLogin;
@end
