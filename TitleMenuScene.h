//
//  TitleMenuScene.h
//  Blocks
//
//  Created by William Fissler on 4/17/14.
//  Copyright (c) 2014 DoubleDose. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
#import "CreditsMenuScene.h"

@interface TitleMenuScene : SKScene

@property (nonatomic,readwrite) SKSpriteNode *_playButton;
@property (nonatomic,readwrite) SKSpriteNode *_infoButton;


/**
 * Method Name: <#SceneSetUp:void#>
 * Description: <#Sets up the scene with a background and a floor, sets physics properties, draws GUI componenets, adn initializes gameController#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)SceneSetUp;

/**
 * Method Name: <#goToGame:void#>
 * Description: <#Presents the Game view#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)goToGame;

/**
 * Method Name: <#goToCredits:void#>
 * Description: <#Presents the Credits Menu view#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)gotoCredits;

@end
