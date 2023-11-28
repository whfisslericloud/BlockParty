//
//  ViewController.m
//  Blocks
//
//  Created by William Fissler on 4/16/14.
//  Copyright (c) 2014 DoubleDose. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "TitleMenuScene.h"
#import "CreditsMenuScene.h"

@implementation ViewController

-(void)viewWillLayoutSubviews
{
    //layout subviews
    [super viewWillLayoutSubviews];
    [self loadTitleMenu];
    
    //load scene
    
}

-(void)loadTitleMenu
{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene)
    {
        //configure the scene
        TitleMenuScene *titleMenu;
        titleMenu = [TitleMenuScene sceneWithSize:skView.bounds.size];
        titleMenu.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:titleMenu];
    }

}

-(void)loadGameScene
{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene)
    {
        //configure the scene
        MyScene *gameScene;
        gameScene = [MyScene sceneWithSize:skView.bounds.size];
        gameScene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:gameScene];
    }
    
}

-(void)loadCreditsScene
{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene)
    {
        //configure the scene
        CreditsMenuScene *creditsScene;
        creditsScene = [CreditsMenuScene sceneWithSize:skView.bounds.size];
        creditsScene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:creditsScene];
    }
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Music_Background_Game" withExtension:@".mp3"] error:nil];
    self.musicPlayer.numberOfLoops = -1;
    [self.musicPlayer prepareToPlay];
    self.musicPlayer.volume = .5;
    [self.musicPlayer setMeteringEnabled:YES];
    [self.musicPlayer play];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
