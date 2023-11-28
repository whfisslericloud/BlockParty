//
//  GameController.m
//  KiiBlocks
//
//  Created by William Fissler on 2/25/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//

#import "GameController.h"


@implementation GameController

//synthesize properties
@synthesize _isGameOver;
@synthesize _getTime;
@synthesize _screenWidth;
@synthesize _screenHeight;
@synthesize _startedTime;
@synthesize _gameState;
@synthesize _myScene;

//definitions
#define COLUMNS 8//width of game board
#define ROWS 8 //height of game board
#define REMOVE_LINE_OFFSET 1 //removes a line dividing blocks in scene
#define LEVEL_TIME 30

/**
 * Method Name: <#<Constructor>#>
 * Description: <#Initializes empty game controller#>
 * Parameters: <#NONE#>
 * @return <#Self#>
 */
-(id) init
{
    self = [super init];
    
    if (self)
    {
        //do stuff
    }
    
    return self;
}


/**
 * Method Name: <#<Constructor>#>
 * Description: <#Initializes game controller with scene reference. Initializes _gameState#>
 * Parameters: <#(SKScene*) paramMyScene#>
 * @return <#Self#>
 */
-(GameController*) initWithScene:(SKScene *)paramMyScene
{
    
    self = [super init];
    
        if (self)
        {
            //assign scene reference
            _myScene = paramMyScene;
            
            //initialize screen dimension variables
            _screenWidth = [UIScreen mainScreen].bounds.size.width;
            _screenHeight = [UIScreen mainScreen].bounds.size.height;
            
            //create gamestate object
            _gameState = STARTING;
            
            //init boolean
            _isGameOver = false;
            
        }
        
        return self;

}

/**
 * Method Name: <#CheckGameState:GameState#>
 * Description: <#Checks for the state of the game and returns the new state#>
 * Parameters:  <#NONE#>
 * @return <#_gameState#>
 */
-(GameState) CheckGameState
{
    //if time has run out... change gamestate to stopped
    if (_getTime <= 0 && _gameState == PLAYING)
    {
        _gameState = STOPPED;
        _isGameOver = true;
    }
    
    //return the gamestate
    return _gameState;
}

/**
 * Method Name: <#InstantiateBlocks:void#>
 * Description: <#Instantiates block nodes in scene when called#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) InstantiateBlocks
{
    //loop to create rows of blocks
    for (int row = 0; row < ROWS; row++)
    {
        //loop to create columns of blocks
        for (int col = 0; col < COLUMNS; col++)
        {
            TextureLoader *textureLoader = [[TextureLoader alloc]init];
            SKTexture* blockTexture = [textureLoader GetTexture];
            UIColor* blockColor = [textureLoader GetColor];
            //the dimensions of the blocks will equal the width of the screen, minus 1, divided by the defined COLUMNS (6)
            //this will give us 6 evenly sized blocks
            //the minus 1 removes a screen division line thay occurs upon draw
            CGFloat dimension = (self._screenWidth - REMOVE_LINE_OFFSET) / COLUMNS;
            
            //instantiate block
            BlockNode *node = [[BlockNode alloc] initWithRow:row andColumn:col withColor:blockColor andTexture:blockTexture andSize:CGSizeMake(dimension,dimension)];
            
            //instantiate blocks
            [_myScene addChild:node];
            
        }
    }
}//end InstantiateBlocks

/**
 * Method Name: <#GameTimer:NSInteger#>
 * Description: <#Gets the game time from the scene's update method to use in gamestate check#>
 * Parameters:  <#(NSInteger) getTime#>
 * @return <#_getTime#>
 */
-(NSInteger) GameTimer: (NSInteger) getTime
{
    //get the time from update
    _getTime = getTime;
    
    return _getTime;
    
}


@end
