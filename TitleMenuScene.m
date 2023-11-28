//
//  TitleMenuScene.m
//  Blocks
//
//  Created by William Fissler on 4/17/14.
//  Copyright (c) 2014 DoubleDose. All rights reserved.
//

#import "TitleMenuScene.h"

@interface TitleMenuScene()

@end


@implementation TitleMenuScene

@synthesize _infoButton;
@synthesize _playButton;

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
 * Description: <#Sets up the scene with a background and a floor, sets physics properties, draws GUI componenets, adn initializes gameController#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)SceneSetUp
{
    //Set background image
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"TitleBackground.png"];

    //center the background
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    //name the background for reference
    background.name = @"Purp.Pink.Yell_Gradient";
    
    [self addChild:background];

    
#pragma mark play button attributes
    _playButton  = [SKSpriteNode spriteNodeWithImageNamed:@"Button_Start_Normal"];
    _playButton.name = @"PlayButton";
    _playButton.zPosition = 1.0f;
    _playButton.size  = CGSizeMake(256, 128);
    _playButton.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 3);
    
    [self addChild:_playButton];
    
#pragma mark credit button attributes
    _infoButton = [SKSpriteNode spriteNodeWithImageNamed:@"Button_Info_Normal"];
    _infoButton.name = @"InfoButton";
    _infoButton.zPosition = 1.0f;
    _infoButton.size  = CGSizeMake(256, 128);
    _infoButton.position = CGPointMake(_playButton.position.x, _playButton.position.y - 192);
    
    [self addChild:_infoButton];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //check to see which objects have been touched and where
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *node = (SKSpriteNode*) [self nodeAtPoint:location];
    
    if ([node.name  isEqualToString:@"PlayButton"])
    {
        _playButton = [SKSpriteNode spriteNodeWithImageNamed:@"Button_Start_Action"];
        NSLog(@"Play button clicked");
        [self goToGame];
    }
    if ([node.name  isEqualToString:@"InfoButton"])
    {
        _infoButton = [SKSpriteNode spriteNodeWithImageNamed:@"Button_Info_Action"];
        NSLog(@"Info button clicked");
        [self gotoCredits];
    }

    
}

/**
 * Method Name: <#goToGame:void#>
 * Description: <#Presents the Game view#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)goToGame
{
    
    [self removeAllChildren];
    SKScene *gameLevel = [[ MyScene alloc]initWithSize:self.size];
    SKTransition *effect = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:gameLevel transition:effect];
}

/**
 * Method Name: <#goToCredits:void#>
 * Description: <#Presents the Credits Menu view#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)gotoCredits
{
    [self removeAllChildren];
    SKScene *creditsMenu = [[ CreditsMenuScene alloc]initWithSize:self.size];
    SKTransition *effect = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:creditsMenu transition:effect];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //do stuff
}

@end
