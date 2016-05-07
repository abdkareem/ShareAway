//
//  ViewController.m
//  ShareAway
//
//  Created by Abdul kareem Khaja mohammed on 11/17/15.
//  Copyright © 2015 Hello World Corporation. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIToolbar *tweetShare;
@property (weak, nonatomic) IBOutlet UIToolbar *genPost;
@property (weak, nonatomic) IBOutlet UIToolbar *doMore;
@property (weak, nonatomic) IBOutlet UIToolbar *nothingNow;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet UITextView *moreText;

-(void)changeTwitterBackground;
-(void)changeFacebookBackground;
-(void)changemoreTextBackground;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self changeTwitterBackground];
    [self changeFacebookBackground];
    [self changemoreTextBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TweetDo:(id)sender {
    if([self.tweetText isFirstResponder]) {
        [self.tweetText resignFirstResponder];
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController * twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSLog(@"SL condition satisfied");
        if ([self.tweetText.text length] <= 140) {
            NSLog(@"Length condition satified");
            [twitterVC setInitialText:self.tweetText.text];
            [self presentViewController:twitterVC animated:YES completion:nil];
            NSLog(@"fit");
        }
        else {
            [twitterVC setInitialText:[self.tweetText.text substringToIndex:139]];
            [self presentViewController:twitterVC animated:YES completion:nil];
            NSLog(@"made fit");
        }
        //NSString * subString = [self ]
            //NSString * subString = [NSString alloc[self.tweetText.text substringToIndex:139]];
    }
    else {
        UIAlertController * request = [UIAlertController alertControllerWithTitle:@"Twitter not signed in" message:@"Sign in to twitter to start tweeting" preferredStyle:UIAlertControllerStyleAlert];
        //UI ugly. does have no way to cancel the popped alert controller. needed to added an action to dismiss this button
        //first create an action then add the action to AlertController
        UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        [request addAction:cancelAction];
        [self presentViewController:request animated:YES completion:nil];
    }
}

-(void)changeTwitterBackground{
    self.tweetText.layer.cornerRadius = 12.0;
    self.tweetText.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetText.layer.borderWidth = 3.0;
}

-(void)changeFacebookBackground{
    self.postText.layer.cornerRadius = 12.0;
    self.postText.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.postText.layer.borderWidth = 3.0;
}

-(void)changemoreTextBackground{
    self.moreText.layer.cornerRadius = 12.0;
    self.moreText.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.moreText.layer.borderWidth = 3.0;
}

- (IBAction)postDo:(id)sender {
    if([self.postText isFirstResponder]) {
        [self.postText resignFirstResponder];
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController * facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookVC setInitialText:self.postText.text];
        [self presentViewController:facebookVC animated:YES completion:nil];
        
    }
    else {
        UIAlertController * request = [UIAlertController alertControllerWithTitle:@"Facebook not signed in" message:@"Sign in to facebook to start posting" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelRequest = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        [request addAction:cancelRequest];
        [self presentViewController:request animated:YES completion:nil];
    }
}

- (IBAction)moreDo:(id)sender {
    NSArray * data = [NSArray arrayWithObjects:self.moreText.text, nil];
    UIActivityViewController * moreVC = [[UIActivityViewController alloc]initWithActivityItems:data applicationActivities:nil];
    [self presentViewController:moreVC animated:YES completion:nil];
}
- (IBAction)nothingDo:(id)sender {
    UIAlertController * simpleAlert = [UIAlertController alertControllerWithTitle:@"Doing Nothing" message:@"Sample Alert" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
    [simpleAlert addAction:cancel];
    [self presentViewController:simpleAlert animated:YES completion:nil];
}
@end

