//
//  ViewController.h
//  PushChat
//
//  Created by Relly on 12/20/14.
//  Copyright (c) 2014 Relly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIApplicationDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;


@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

- (IBAction)btnGet:(id)sender;
- (IBAction)btnPost:(id)sender;
- (IBAction)btnClear:(id)sender;
- (IBAction)btnNotify:(id)sender;


- (IBAction)onStartIndicatorClick:(id)sender;
- (IBAction)onStopIndicatorClick:(id)sender;

@end
