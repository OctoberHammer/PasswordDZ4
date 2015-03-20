//
//  ViewController.m
//  Password
//
//  Created by Ocotober Hammer on 3/17/15.
//  Copyright (c) 2015 Ocotober Hammer. All rights reserved.
//

#import "ViewController.h"
#import "myPassword.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *passwordQuality;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *serviceMessage;

@end


@implementation ViewController

- (IBAction)didExitPassword:(UITextField *)sender {
    NSDate *begin = [NSDate date];//начало выполнения
    //наши рейтинги
    NSDictionary *passwordRatings = @{@0 : @"empty password",
                                      @1 : @"poor",
                                      @2 : @"so-so",
                                      @3 : @"average",
                                      @4 : @"strong enough",
                                      @5 : @"very strong!"
                                      };
    //цвета, соответсвующие рейтингам
    NSDictionary *passwordColors = @{@0 : [UIColor whiteColor],
                                     @1 : [UIColor redColor],
                                     @2 : [UIColor orangeColor],
                                     @3 : [UIColor blueColor],
                                     @4 : [UIColor greenColor],
                                     @5 : [UIColor purpleColor]
                                      };
    
    myPassword* newPassword = [[myPassword alloc] initWithString: self.passwordField.text];
    //оцениваем качество пароля
    int quality = [newPassword evaluateQuality];
    //даем знать пользователю о качестве его пароля цветом и текстом надписи
    self.passwordQuality.textColor = passwordColors[@(quality)];//использую краткий способ создания объекта из числа
    self.passwordQuality.text = passwordRatings[@(quality)];
    self.serviceMessage.text = [[NSString alloc] initWithFormat:@"Evaluation of your password has been performing for %f seconds",-[begin timeIntervalSinceNow]];
    //NSLog(@"hello %@, %i", newPassword.password, quality);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}



@end
