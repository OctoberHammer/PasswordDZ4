//
//  myPassword.m
//  Password
//
//  Created by Ocotober Hammer on 3/17/15.
//  Copyright (c) 2015 Ocotober Hammer. All rights reserved.
//

#import "myPassword.h"

           
@implementation myPassword

//
-(instancetype) init{
    self =  [super init];
    if (self){
        self.password = @"";}
    return self;
}

-(instancetype) initWithString : (NSString*) initPassword {
    self =  [super init];
    if (self){
        self.password = [NSString stringWithFormat: @"%@",initPassword];}
    return self;
}

-(int) evaluateQuality{
    int result = 0;
    NSCharacterSet* digits = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet* smallLetters = [NSCharacterSet lowercaseLetterCharacterSet];
    NSCharacterSet* bigLetters = [NSCharacterSet uppercaseLetterCharacterSet];
    NSCharacterSet* specialCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    //NSLog(@"%i",[specialCharacters characterIsMember:'$' ]);//так, чисто проверить
    result = result + [self hasSymbolFromSet: self.password :digits] +
    [self hasSymbolFromSet: self.password :smallLetters] + [self hasSymbolFromSet: self.password :bigLetters] + [self hasSymbolFromSet: self.password :specialCharacters];

    result = result + [self orderIsMessed:self.password];


    return result;
}

-(int) orderIsMessed :(NSString*) aString{
    //нужно еще проверить, что символы идут неподряд.
    //вот тут уже перебираю строку посимвольно
    
    if (aString.length<2) {
    //если меньше двух символов, то какой подряд/неподряд?
        return 0;
    }
    
    char previousSymb = [aString characterAtIndex:1];
    
    //в эту переменную будем накапливать разницу между аски-кодами двух соседних симоволов
    //если по итогу эта накопленная разница будет равна длине строки, значит символы в строке шли "подряд". иначе - в ризалт добавим единицу
    
    int difference = ([aString characterAtIndex:1] - [aString characterAtIndex:0] > 0) ?  ([aString characterAtIndex:1] - [aString characterAtIndex:0]) :  ([aString characterAtIndex:0] - [aString characterAtIndex:1]);

    int previousAscendingOrdescending = ([aString characterAtIndex:1] - [aString characterAtIndex:0] > 0) ?  (1) :  (-1);
    int accumulatedDifference = difference;
    
    for (int i=2; i<aString.length; i++) {
        //во-первых сравним знак. если он изменился, то прерываем цикл, и возвращаем 1 - уже порядка никакого нет
    int currentAscendingOrdescending = ([aString characterAtIndex:i] - [aString characterAtIndex:i-1] > 0) ?  (1) :  (-1);
        if (currentAscendingOrdescending + previousAscendingOrdescending == 0) {
            return 1;
        }
        //перебираем строки начиная с третьего символа, сравниваем его с предыдущим
        //если разница равна единице, значит символы идут "подряд" по таблице АСКИ
        char symbol = [aString characterAtIndex:i];
        //разницу нужно взять по модулю, потому что если символы следуют в обратном порядке - это тоже "подряд",
        //кроме того, мы исключаем вариант, когда чисто арифметически мы сможем в итоге получить разнцу такую же, как длину строки
        difference = ( symbol - previousSymb > 0 ) ? (symbol - previousSymb) : (previousSymb - symbol );
        accumulatedDifference = accumulatedDifference + difference;
        //и потом текущий символ делаем предыдущим
        previousSymb = symbol;
    }
    //если накопленная разница меньше чем длина минус 1, значит символы следовали по-порядку.
    if (accumulatedDifference != aString.length-1) {
        return 1;
    } else {
        NSLog(@"символы в строке следовали по-порядку");
        return 0;
    }
}

//если в строке есть символ из набора, возвращаем единицу. нет - возвращаем 0
-(int) hasSymbolFromSet :(NSString*) aString  :(NSCharacterSet*) setOfCharacters{
    if ([aString rangeOfCharacterFromSet:setOfCharacters].location != NSNotFound) {return 1;}
    else {return 0;}
}
@end
