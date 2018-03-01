//
//  ViewController.m
//  MusicPlayInBackground
//
//  Created by Zeeshan Khan on 3/1/18.
//  Copyright © 2018 Murtuza. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVAudioPlayerDelegate> {
    AVAudioPlayer *audioPlayer;
}
@property (nonatomic, strong) NSTimer *secondsTimer;
- (IBAction)musicPlay:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBackgroundTaskIdentifier bgTask =0;
    UIApplication  *app = [UIApplication sharedApplication];
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
    }];
    
    self.secondsTimer = [NSTimer
                         scheduledTimerWithTimeInterval:5
                         target:self
                         selector:@selector(timerFireMethod:)
                         userInfo:nil
                         repeats:NO];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //Once the view has loaded then we can register to begin recieving controls and we can become the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //End recieving events
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) timerFireMethod:(NSTimer *) theTimer {
    NSLog(@"ok");
    [self play];
    /*NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"iphone_ring"
                                                        ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:soundFilePath];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc]
                   initWithContentsOfURL:url
                   error:&error];
    
    audioPlayer.delegate=self;
    audioPlayer.volume=0.2;
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
        [audioPlayer play];
    }
    
    [self becomeFirstResponder]; [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];*/
    
}


- (BOOL)canBecomeFirstResponder {
    return YES;
}


- (void)play {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"iphone_ring"
                                                              ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:soundFilePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer setNumberOfLoops:-1];
    audioPlayer.volume = 0.1;
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    } else {
        //Make sure the system follows our playback status
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        //Load the audio into memory
        [audioPlayer prepareToPlay];
        [audioPlayer play];
    }
}


- (IBAction)musicPlay:(id)sender {
    [self play];
    /*
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"iphone_ring"
                                                              ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:soundFilePath];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc]
                                  initWithContentsOfURL:url
                                  error:&error];
    
    audioPlayer.delegate=self;
    audioPlayer.volume=0.2;
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
        [audioPlayer play];
    }
    
    [self becomeFirstResponder]; [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
     */
    
    /*NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"iphone_ring"
                                                        ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    audioPlayer.numberOfLoops = -1;
    [audioPlayer prepareToPlay];
    [audioPlayer play];*/
}
@end
