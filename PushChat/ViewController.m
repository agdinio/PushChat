//
//  ViewController.m
//  PushChat
//
//  Created by Relly on 12/20/14.
//  Copyright (c) 2014 Relly. All rights reserved.
//

#import "ViewController.h"
#import "MyResponder.h"

@interface ViewController ()
{
    MyResponder *myresponder;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    MyResponder *responder = [[UIApplication sharedApplication]delegate];
    NSUUID *uuid = [UIDevice currentDevice].identifierForVendor;
    NSLog(@"%@", uuid);
    
    //myresponder = [[MyResponder alloc] init];
    //[myresponder getName];
    //[self initWaitMessage];

    //MyResponder *responder = [[UIApplication sharedApplication]delegate];

    
}


/*
 * MYPUSH NOTIFICATION
 */
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My ViewController token is: %@", deviceToken);
}


-(void)initWaitMessage
{
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    self.loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.loadingView.clipsToBounds = YES;
    self.loadingView.layer.cornerRadius = 10.0;
    self.loadingView.center = self.view.center;
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.frame = CGRectMake(65, 40, self.activityView.bounds.size.width, self.activityView.bounds.size.height);
    [self.loadingView addSubview:self.activityView];
    
    self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.textColor = [UIColor whiteColor];
    self.loadingLabel.adjustsFontSizeToFitWidth = YES;
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.text = @"Please wait...";
    [self.loadingView addSubview:self.loadingLabel];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGet:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:@"http://pushchat.local:44447/simplepush/simplepush.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             self.txtName.text = [info objectForKey:@"name"];
             self.txtEmail.text = [info objectForKey:@"email"];
         }
     }];

//    NSError *error;
//    NSURL *url = [NSURL URLWithString:@"http://emrill.atwebpages.com/notification/simpleservice.php"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    NSData *data = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&error ];
//    if (!data)
//    {
//        NSLog(@"Download Error: %@", error.localizedDescription);
//    }
//    
//    // Parse the (binary) JSON data from the web service into an NSDictionary object
//    id dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    if (dictionary == nil) {
//        NSLog(@"JSON Error: %@", error);
//    }
    

}


-(IBAction)btnPost:(id)sender
{
    [self.txtEmail resignFirstResponder];
    
    NSError *error;
    NSString *url = [NSString stringWithFormat:@"http://pushchat.local:44447/simplepush/insert.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];

    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:[self.txtName text] forKey:@"name"];
    [dictionary setValue:[self.txtEmail text] forKey:@"email"];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:jsonData]; //set the data as the post body
    [request addValue:[NSString stringWithFormat:@"%lu",(long)jsonData.length] forHTTPHeaderField:@"Content-Length"];

    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //if(!connection){
    //    NSLog(@"Connection Failed");
    //}


    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[result objectForKey:@"result"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
             [alert show];
         }
     }];

    
}

- (IBAction)btnClear:(id)sender
{
    self.txtName.text = @"";
    self.txtEmail.text = @"";
}

- (IBAction)btnNotify:(id)sender
{
    
}

- (IBAction)onStartIndicatorClick:(id)sender {
    [self.view addSubview:self.loadingView];
    [self.activityView startAnimating];

    //[self.activityIndicatorView startAnimating];
}

- (IBAction)onStopIndicatorClick:(id)sender {
    [self.loadingView removeFromSuperview];
    [self.activityView stopAnimating];
    //[self.activityIndicatorView stopAnimating];
}


-(void)initFullScreenActivityIndicator
{
    UIActivityIndicatorView *activityIndicator= [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    activityIndicator.layer.cornerRadius = 05;
    activityIndicator.opaque = NO;
    activityIndicator.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    activityIndicator.center = self.view.center;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activityIndicator setColor:[UIColor colorWithRed:0.6 green:0.8 blue:1.0 alpha:1.0]];
    [self.view addSubview: activityIndicator];
    [activityIndicator startAnimating];
}

-(void)initActivityIndicator
{
    self.view.backgroundColor = [UIColor blackColor];

    CGRect frame = CGRectMake (120.0, 185.0, 80, 80);
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    
    [self.view addSubview:self.activityIndicatorView];
}

@end
