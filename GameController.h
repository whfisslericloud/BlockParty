//
//  GameController.h
//  KiiBlocks
//
//  Created by William Fissler on 3/26/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//



#import "MyScene.h"

@interface GameController : SKNode

//defines GameState options
typedef enum
{
    STARTING,
    STOPPED,
    PLAYING,
    PAUSED,
    QUITTING
    
} GameState;

@property (nonatomic, readwrite) BOOL _isGameOver;
@property (nonatomic, readwrite) NSInteger _getTime;
@property (nonatomic, readonly) CGFloat _screenWidth;
@property (nonatomic, readonly) CGFloat _screenHeight;
@property (nonatomic, readwrite) CFTimeInterval _startedTime;
@property (nonatomic, readwrite) GameState _gameState;
@property (nonatomic, readwrite) SKScene* _myScene;

/**
 * Method Name: <#<Constructor>#>
 * Description: <#Initializes game controller with scene reference#>
 * Parameters: <#(SKScene*) paramMyScene#>
 * @return <#Self#>
 */
-(GameController*) initWithScene: (SKScene*) paramMyScene;

/**
 * Method Name: <#InstantiateBlocks:void#>
 * Description: <#Instantiates block nodes in scene when called#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) InstantiateBlocks;

/**
 * Method Name: <#CheckGameState:GameState#>
 * Description: <#Checks for the state of the game and returns the new state#>
 * Parameters:  <#NONE#>
 * @return <#_gameState#>
 */
-(GameState) CheckGameState;

/**
 * Method Name: <#GameTimer:NSInteger#>
 * Description: <#Gets the game time from the scene's update method to use in gamestate check#>
 * Parameters:  <#(NSInteger) getTime#>
 * @return <#_getTime#>
 */
-(NSInteger) GameTimer: (NSInteger) getTime;


@end
