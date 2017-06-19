//
//  ViewController.m
//  calculator_beacomni
//
//  Created by beacomni on 6/19/17.
//  Copyright © 2017 beacomni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *CalculatorLabel;
@property (strong, nonatomic) IBOutlet UITextField *CalculatorDisplay;

@property Float64 currentResult;
@property bool wasReset;

typedef enum : NSUInteger {
    Add,
    Substract,
    Multiply,
    Divide
} Operations;

@property Operations lastOperation;

- (Float64)DoOperation:(Operations)operator WithOp:(Float64)operand1 AndOp:(Float64)operand2;
- (Float64)Add:(Float64)operand1 AndOp:(Float64)operand2;
- (Float64)Subtract:(Float64)operand1 AndOp:(Float64)operand2;
- (Float64)Multiply:(Float64)operand1 AndOp:(Float64)operand2;
- (Float64)Divide:(Float64)operand1 AndOp:(Float64)operand2;
- (Operations)ParseOperation:(NSString *)op;
- (bool)IsOperator:(NSString *) str;
- (void)Reset;
@end


/////////////
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self Reset];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Float64)DoOperation:(Operations)operator WithOp:(Float64)operand1 AndOp:(Float64)operand2 {
    if(operator == Add) return [self Add:operand1 AndOp:operand2];
    if(operator == Substract) return [self Subtract:operand1 AndOp:operand2];
    if(operator == Multiply) return [self Multiply:operand1 AndOp:operand2];
    if(operator == Divide) return [self Divide:operand1 AndOp:operand2];
    @throw NSGenericException;
}


//id is just a general object id
- (IBAction)ButtonHandle:(id)sender {
    
    //cast to button
    UIButton *inputButton = (UIButton *)sender;
    
    NSString *label = inputButton.titleLabel.text;
    
    //check if its an int
    NSInteger numberInput = [label integerValue];
    

    //  when it fails
    if ([label isEqualToString:@"AC"]) {
        [self Reset];
    }
    else if ([self IsOperator:label])
    {
        //it was an operator
        _lastOperation = [self ParseOperation:label];
    }
        //first check if its a 0, because the int conversion is absurd and will return a 0
    else if([label isEqualToString:@"0"] || [label isEqualToString:@"0.0"]){
        if(_wasReset)
        {
            _currentResult = 0;
            _wasReset = false;
        }
        else
        {
            _currentResult = [self DoOperation:_lastOperation WithOp:_currentResult AndOp:0];
        }
    }
    else if(![label isEqualToString: @"0"]){
        if(_wasReset)
        {
            _currentResult = numberInput;
            _wasReset = false;
        }
        else {
            _currentResult = [self DoOperation:_lastOperation WithOp:_currentResult AndOp:numberInput];
        }
        
    }
    else
    {
        @throw NSGenericException;
    }
    _CalculatorLabel.text = [NSString stringWithFormat:@"%g",_currentResult];
}

- (Operations)ParseOperation:(NSString *)op{
    if([op isEqualToString:@"+"]) return Add;
    if([op isEqualToString:@"-"]) return Substract;
    if([op isEqualToString:@"x"]) return Multiply;
    if([op isEqualToString:@"/"]) return Divide;
    @throw NSGenericException;
}

- (bool)IsOperator:(NSString *)str{
    return [str isEqualToString:@"+"] ||
    [str isEqualToString:@"-"] ||
    [str isEqualToString:@"/"] ||
    [str isEqualToString:@"x"];
}

- (void)Reset{
    _currentResult = 0;
    _wasReset = true;
    _CalculatorLabel.text = [NSString stringWithFormat:@"%g",_currentResult];
}

- (Float64)Add:(Float64)operand1 AndOp:(Float64)operand2{
    return operand1 + operand2;
}
- (Float64)Subtract:(Float64)operand1 AndOp:(Float64)operand2{
    return operand1 - operand2;
}
- (Float64)Multiply:(Float64)operand1 AndOp:(Float64)operand2{
    return operand1 * operand2;
}
- (Float64)Divide:(Float64)operand1 AndOp:(Float64)operand2{
    //TODO special case for div by 0
    return operand1 / operand2;
}


@end
