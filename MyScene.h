//
//  MyScene.h
//  KiiBlocks
//

//  Copyright (c) 2014 William Fissler. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BlockNode.h"
#import "GUIController.h"
#import "GameController.h"
#import "ParticleEffect.h"
#import "TextureLoader.h"
#import "TitleMenuScene.h"

@interface MyScene : SKScene

@property (nonatomic, readwrite) NSUInteger _timeElapsed;
@property (nonatomic, readwrite) BOOL _isSceneReset;


/**
 * Method Name: <#SceneSetUp:void#>
 * Description: <#Sets up the scene with a background and a floor, sets physics properties, draws GUI componenets, adn initializes gameController#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) SceneSetUp;

/**
 * Method Name: <#ResetScene:void#>
 * Description: <#Resets the game to the original state at the end of the round#>
 * Parameters:  <#NONE#>
 * @return <#NONE#>
 */
-(void) ResetScene;

/**
 * Method Name: <#goToTitle:void#>
 * Description: <#Presents the Title Menu view#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) GoToTitle;

/**
 * Method Name: <#RefreshBlocks:void#>
 * Description: <#Instantiates a new selection of randomly generated blocks in the gameplay area#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) RefreshBlocks;

@end

