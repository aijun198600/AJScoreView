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
    if (scoreView.insert.top == 0) {
        UIEdgeInsets insert = UIEdgeInsetsMake(20, 50, 10, 10);
        scoreView.insert = insert;
    }else{
        scoreView.insert = UIEdgeInsetsZero;
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
    if ([scoreView.selectedColor isEqual:[UIColor yellowColor]]) {
        scoreView.selectedColor = [UIColor blueColor];
    }else{
        scoreView.selectedColor = [UIColor yellowColor];
    }
}

- (void)changeUnselectedColor{
    if ([scoreView.unselectedColor isEqual:[UIColor grayColor]]) {
        scoreView.unselectedColor = [UIColor whiteColor];
    }else{
        scoreView.unselectedColor = [UIColor grayColor];
    }
}

- (void)changeCustomPath{
    if (scoreView.type == AJScoreViewCustomType) {
        scoreView.type = AJScoreViewStarType;
    }else{
        
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, 10, 10)];
        scoreView.type = AJScoreViewCustomType;
        scoreView.path = rectPath;
        
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

@end
