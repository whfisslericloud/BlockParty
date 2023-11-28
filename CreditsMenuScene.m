//
//  CreditsMenuScene.m
//  Blocks
//
//  Created by William Fissler on 4/17/14.
//  Copyright (c) 2014 DoubleDose. All rights reserved.
//

#import "CreditsMenuScene.h"

@implementation CreditsMenuScene



-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        
#pragma mark Scene Setup
        
        //set up scene with helper method found below
        [self SceneSetUp];
        
    }
    return self;
}

/**
 * Method Name: <#SceneSetUp:void#>
 * Description: <#Sets this scene's attributes#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)SceneSetUp
{
    //Set background image
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"CreditsBackground"];
    
    //center the background
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    //name the background for reference
    background.name = @"CreditsBackground";
    
    [self addChild:background];
    
#pragma mark quitbutton button attributes
    SKSpriteNode *quitButton = [SKSpriteNode spriteNodeWithImageNamed:@"Button_Exit_Normal"];
    quitButton.name = @"QuitButton";
    quitButton.zPosition = 1.0f;
    quitButton.size  = CGSizeMake(256, 128);
    quitButton.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 10);
    
    [self addChild:quitButton];

    
}

/**
 * Method Name: <#goToTitle:void#>
 * Description: <#Presents the Title Menu view#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)goToTitle
{
    [self removeAllChildren];
    SKScene *titleMenu = [[ TitleMenuScene alloc]initWithSize:self.size];
    SKTransition *effect = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:titleMenu transition:effect];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //check to see which objects have been touched and where
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *node = (SKSpriteNode*) [self nodeAtPoint:location];
    
    if ([node.name  isEqualToString:@"QuitButton"])
    {
        NSLog(@"Play button clicked");
        [self goToTitle];
    }
    
}


@end
