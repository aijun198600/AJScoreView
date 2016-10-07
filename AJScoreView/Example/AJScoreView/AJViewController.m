//
//  AJViewController.m
//  AJScoreView
//
//  Created by aijunx on 10/01/2016.
//  Copyright (c) 2016 aijunx. All rights reserved.
//

#import "AJViewController.h"
#import <AJScoreView/AJScoreView.h>

@interface AJViewController ()

@end

@implementation AJViewController{
    AJScoreView *scoreView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    scoreView= [[AJScoreView alloc] initWithFrame:CGRectMake(5, 40,250,50)];
    scoreView.backgroundColor = [UIColor greenColor];
    scoreView.enabled = YES;
    [scoreView addTarget:self action:@selector(valueChaneged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:scoreView];
    
    UIButton *btnChang = [[UIButton alloc] initWithFrame:CGRectMake(5, 100, 200, 30)];
    [btnChang setTitle:@"change sharp" forState:UIControlStateNormal];
    [btnChang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChang addTarget:self action:@selector(changeSharp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChang];
    
    UIButton *btnChangAlignment = [[UIButton alloc] initWithFrame:CGRectMake(5, 140, 200, 30)];
    [btnChangAlignment setTitle:@"change alignment" forState:UIControlStateNormal];
    [btnChangAlignment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangAlignment addTarget:self action:@selector(changeAlignment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangAlignment];
    
    UIButton *btnChangInsert = [[UIButton alloc] initWithFrame:CGRectMake(5, 180, 200, 30)];
    [btnChangInsert setTitle:@"change insert" forState:UIControlStateNormal];
    [btnChangInsert setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangInsert addTarget:self action:@selector(changeInsert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangInsert];
    
    UIButton *btnChangPadding = [[UIButton alloc] initWithFrame:CGRectMake(5, 220, 200, 30)];
    [btnChangPadding setTitle:@"change padding" forState:UIControlStateNormal];
    [btnChangPadding setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangPadding addTarget:self action:@selector(changePadding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangPadding];
    
    UILabel *labelChangeValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 260, 300, 30)];
    labelChangeValue.text = @"user slider to change value";
    labelChangeValue.textColor = [UIColor blackColor];
    [self.view addSubview:labelChangeValue];
    
    UISlider *sliderChangValue = [[UISlider alloc] initWithFrame:CGRectMake(5, 300, 200, 30)];
    sliderChangValue.minimumValue = scoreView.minimumValue;
    sliderChangValue.maximumValue = scoreView.maximumValue;
    sliderChangValue.value = scoreView.value;
    [sliderChangValue addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sliderChangValue];
    
    UIButton *btnChangNumber = [[UIButton alloc] initWithFrame:CGRectMake(5, 340, 200, 30)];
    [btnChangNumber setTitle:@"change number" forState:UIControlStateNormal];
    [btnChangNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangNumber addTarget:self action:@selector(changeNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangNumber];
    
    UIButton *btnSelectedColor = [[UIButton alloc] initWithFrame:CGRectMake(5, 380, 200, 30)];
    [btnSelectedColor setTitle:@"change selectedColor" forState:UIControlStateNormal];
    [btnSelectedColor setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSelectedColor addTarget:self action:@selector(changeSelectedColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelectedColor];
    
    UIButton *btnChangeUnselectedColor = [[UIButton alloc] initWithFrame:CGRectMake(5, 420, 200, 30)];
    [btnChangeUnselectedColor setTitle:@"change unselectedColor" forState:UIControlStateNormal];
    [btnChangeUnselectedColor setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangeUnselectedColor addTarget:self action:@selector(changeUnselectedColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangeUnselectedColor];
    
    UIButton *btnUseCustomPath = [[UIButton alloc] initWithFrame:CGRectMake(5, 460, 200, 30)];
    [btnUseCustomPath setTitle:@"use custom path" forState:UIControlStateNormal];
    [btnUseCustomPath setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnUseCustomPath addTarget:self action:@selector(changeCustomPath) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnUseCustomPath];
    
    UIButton *btnChangeFrame = [[UIButton alloc] initWithFrame:CGRectMake(5, 500, 200, 30)];
    [btnChangeFrame setTitle:@"change frame" forState:UIControlStateNormal];
    [btnChangeFrame setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangeFrame addTarget:self action:@selector(changeFrame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangeFrame];
    
    UIButton *btnChangeValueAnimation = [[UIButton alloc] initWithFrame:CGRectMake(5, 540, 200, 30)];
    [btnChangeValueAnimation setTitle:@"change value to 5.0" forState:UIControlStateNormal];
    [btnChangeValueAnimation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnChangeValueAnimation addTarget:self action:@selector(changeValueAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangeValueAnimation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChaneged{
    NSLog(@"------>value:%@",@(scoreView.value));
}

- (void)changeSharp{
    
    if (scoreView.type == AJScoreViewHeartType) {
        scoreView.type = AJScoreViewStarType;
    }else{
        scoreView.type = AJScoreViewHeartType;
    }
    
}

- (void)changeAlignment{
    
    if (scoreView.alignment + 1 <= AJScoreViewAlignmentRight) {
        scoreView.alignment = scoreView.alignment + 1;
    }else{
        scoreView.alignment = AJScoreViewAlignmentCenter;
    }
    
}

- (void)changeInsert{
    if (scoreView.insert.top == 2) {
        UIEdgeInsets insert = UIEdgeInsetsMake(20, 50, 10, 10);
        scoreView.insert = insert;
    }else{
        scoreView.insert = UIEdgeInsetsMake(2, 2, 2, 2);
    }
}

- (void)changePadding{
    if (scoreView.padding == 2.0) {
        scoreView.padding = 10.0;
    }else{
        scoreView.padding = 2.0;
    }
}

- (void)changeValue:(UISlider *)sender{
    scoreView.value = sender.value;
}

- (void)changeNumber{
    if (scoreView.number == 5) {
        scoreView.number = 3;
    }else{
        scoreView.number = 5;
    }
}

- (void)changeSelectedColor{
    if ([scoreView.selectedFillColor isEqual:[UIColor yellowColor]]) {
        scoreView.selectedFillColor = [UIColor blueColor];
    }else{
        scoreView.selectedFillColor = [UIColor yellowColor];
    }
}

- (void)changeUnselectedColor{
    if ([scoreView.unselectedFillColor isEqual:[UIColor grayColor]]) {
        scoreView.unselectedFillColor = [UIColor whiteColor];
    }else{
        scoreView.unselectedFillColor = [UIColor grayColor];
    }
}

- (void)changeCustomPath{
    if (scoreView.type == AJScoreViewCustomType) {
        scoreView.type = AJScoreViewStarType;
    }else{
        
        scoreView.type = AJScoreViewCustomType;
        scoreView.path = [self twitterPath];
        
    }
}

- (void)changeFrame{
    if (scoreView.frame.size.width == 250.0) {
        scoreView.frame = CGRectMake(5, 40, 150, 50);
    }else{
        scoreView.frame = CGRectMake(5, 40,250,50);
    }
}

- (void)changeValueAnimation{
    [scoreView setValue:5.0 animated:YES];
}

- (UIBezierPath *)twitterPath{
    
    UIBezierPath* path3611Path = [UIBezierPath bezierPath];
    [path3611Path moveToPoint: CGPointMake(93.72, 242.19)];
    [path3611Path addCurveToPoint: CGPointMake(267.68, 68.23) controlPoint1: CGPointMake(206.18, 242.19) controlPoint2: CGPointMake(267.68, 149.02)];
    [path3611Path addCurveToPoint: CGPointMake(267.5, 60.33) controlPoint1: CGPointMake(267.68, 65.58) controlPoint2: CGPointMake(267.62, 62.95)];
    [path3611Path addCurveToPoint: CGPointMake(298, 28.67) controlPoint1: CGPointMake(279.44, 51.7) controlPoint2: CGPointMake(289.82, 40.93)];
    [path3611Path addCurveToPoint: CGPointMake(262.89, 38.29) controlPoint1: CGPointMake(287.05, 33.54) controlPoint2: CGPointMake(275.26, 36.82)];
    [path3611Path addCurveToPoint: CGPointMake(289.78, 4.48) controlPoint1: CGPointMake(275.51, 30.72) controlPoint2: CGPointMake(285.2, 18.75)];
    [path3611Path addCurveToPoint: CGPointMake(250.95, 19.32) controlPoint1: CGPointMake(277.96, 11.48) controlPoint2: CGPointMake(264.88, 16.57)];
    [path3611Path addCurveToPoint: CGPointMake(206.32, 0) controlPoint1: CGPointMake(239.79, 7.43) controlPoint2: CGPointMake(223.91, 0)];
    [path3611Path addCurveToPoint: CGPointMake(145.18, 61.13) controlPoint1: CGPointMake(172.56, 0) controlPoint2: CGPointMake(145.18, 27.38)];
    [path3611Path addCurveToPoint: CGPointMake(146.76, 75.07) controlPoint1: CGPointMake(145.18, 65.93) controlPoint2: CGPointMake(145.71, 70.6)];
    [path3611Path addCurveToPoint: CGPointMake(20.74, 11.19) controlPoint1: CGPointMake(95.95, 72.52) controlPoint2: CGPointMake(50.89, 48.19)];
    [path3611Path addCurveToPoint: CGPointMake(12.46, 41.92) controlPoint1: CGPointMake(15.49, 20.23) controlPoint2: CGPointMake(12.46, 30.72)];
    [path3611Path addCurveToPoint: CGPointMake(39.67, 92.82) controlPoint1: CGPointMake(12.46, 63.13) controlPoint2: CGPointMake(23.25, 81.86)];
    [path3611Path addCurveToPoint: CGPointMake(11.98, 85.17) controlPoint1: CGPointMake(29.64, 92.51) controlPoint2: CGPointMake(20.21, 89.75)];
    [path3611Path addCurveToPoint: CGPointMake(11.97, 85.95) controlPoint1: CGPointMake(11.97, 85.43) controlPoint2: CGPointMake(11.97, 85.68)];
    [path3611Path addCurveToPoint: CGPointMake(61.02, 145.88) controlPoint1: CGPointMake(11.97, 115.56) controlPoint2: CGPointMake(33.04, 140.28)];
    [path3611Path addCurveToPoint: CGPointMake(44.9, 148.04) controlPoint1: CGPointMake(55.88, 147.28) controlPoint2: CGPointMake(50.48, 148.04)];
    [path3611Path addCurveToPoint: CGPointMake(33.41, 146.93) controlPoint1: CGPointMake(40.96, 148.04) controlPoint2: CGPointMake(37.13, 147.65)];
    [path3611Path addCurveToPoint: CGPointMake(90.52, 189.4) controlPoint1: CGPointMake(41.19, 171.23) controlPoint2: CGPointMake(63.76, 188.9)];
    [path3611Path addCurveToPoint: CGPointMake(14.58, 215.57) controlPoint1: CGPointMake(69.6, 205.8) controlPoint2: CGPointMake(43.23, 215.57)];
    [path3611Path addCurveToPoint: CGPointMake(-0, 214.72) controlPoint1: CGPointMake(9.66, 215.57) controlPoint2: CGPointMake(4.79, 215.29)];
    [path3611Path addCurveToPoint: CGPointMake(93.72, 242.19) controlPoint1: CGPointMake(27.06, 232.07) controlPoint2: CGPointMake(59.19, 242.19)];
    path3611Path.miterLimit = 4;
    
    return path3611Path;
}

@end
