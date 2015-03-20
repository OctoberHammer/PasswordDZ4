//
//  myPassword.h
//  Password
//
//  Created by Ocotober Hammer on 3/17/15.
//  Copyright (c) 2015 Ocotober Hammer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myPassword : NSObject {}
//свойство, котрое хранит пароль в текстовом виде
@property (nonatomic) NSString *password;

- (int) evaluateQuality;
- (instancetype) init;
- (instancetype) initWithString :(NSString*) initString;

@end
