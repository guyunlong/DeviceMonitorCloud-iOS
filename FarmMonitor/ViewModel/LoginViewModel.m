//
//  LoginViewModel.m
//  FarmMonitor
//
//  Created by guyunlong on 6/18/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "LoginViewModel.h"
#import "FarmGetManager.h"
#import "AccountManager.h"
@implementation LoginViewModel

- (id)init {
    self = [super init];
    if (self) {
        [self initRacSignal];
    }

    return self;
   
}
-(void)initRacSignal{
   
    
    self.validLoginSignal = [[RACSignal
                              combineLatest:@[ RACObserve(self, username), RACObserve(self, password) ]
                              reduce:^(NSString *username, NSString *password) {
                                  return @(username.length > 0 && password.length > 0);
                              }]
                             distinctUntilChanged];
    
   
}

-(RACSignal *)racLogin{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //{"func":"globalForgetPwd","api":"Common","data":{"type":4,"name":"13062592896"}}
       
        @strongify(self)
        [FarmGetManager Login:self.username password:self.password success:^(id data) {
            self.uid =[data integerValue];
            [AccountManager setUser:self.username];
            [AccountManager setPwd:self.password];
            [subscriber sendNext:@1];
             [subscriber sendCompleted];
        } failure:^(int errorcode) {
            [subscriber sendNext:@(errorcode)];
             [subscriber sendCompleted];
        }];
        
        
//        [FarmGetManager get:svr parameters:dic success:^(id data){
//            //@strongify(self)
//            NSLog(@"view model response data is %@",data);
//            if ([[data objectForKey:@"success"] integerValue] == 1) {
//                _checkModel = [MessageCheckModel MessageCheckModelWithDict:data[@"data"][0]];
//                [subscriber sendNext:@1];
//            }
//            else{
//                [subscriber sendNext:data[@"code"]];//
//            }
//            [subscriber sendCompleted];
//        } failure:^(NSError * error){
//            [subscriber sendNext:@-1];//未知网络错误
//            [subscriber sendCompleted];
//        }];
        return nil;
    }];
    
}

@end
