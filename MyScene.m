//
//  MyScene.m
//  KiiBlocks
//
//  Created by William Fissler on 2/14/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//

#import "MyScene.h"


//////////////////////////////////////////////
//#defines
//////////////////////////////////////////////
#define COLUMNS 8
#define ROWS 8
#define MIN_BLOCK_BUST 2
#define LEVEL_TIME 30
#define FLOOR_WIDTH 1536
#define FLOOR_HEIGHT 40
#define FLOOR_COORD_X 160
#define FLOOR_COORD_Y 20

@interface MyScene()
{
    //public variable for tracking score
    NSInteger _score;
    
    //public variable to track game start time and increment as the timer thereafter
    CFTimeInterval _startedTime;
    
    //create game controller object
    GameController *gameController;
    
    //create GUI controller Object
    GUIController *guiController;
}

@end

@implementation MyScene

//////////////////////////////////////////////
//Properties
//////////////////////////////////////////////
@synthesize _timeElapsed;
@synthesize _isSceneReset;

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
-(void) SceneSetUp
{
#pragma mark initialize reference objects

    //initialize game controller
    gameController  = [[GameController alloc]initWithScene:self];
    
        
    //init _score to -1 for debug
    _score = 0;
    
    _timeElapsed = LEVEL_TIME;

#pragma mark Scene attributes
    
    //sets gravity (for object to fall upward set positive gravity value, fall down negative gravity value
    self.physicsWorld.gravity = CGVectorMake(0, -16.0f);
    
    //Set background image
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Background_Purp.Pink.Yell_Gradient.png"];
    
    //center the background
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    //name the background for reference
    background.name = @"Purp.Pink.Yell_Gradient";
    
    [self addChild:background];
    
   
#pragma mark Floor attributes
    
    //creates a floor (spriteNode) size of 320x40px
    SKSpriteNode *floor = [SKSpriteNode spriteNodeWithImageNamed:@"Floor"];
    floor.size = CGSizeMake(FLOOR_WIDTH, FLOOR_HEIGHT);
    
    //adds physics body to the created floor of the same size of the floor
    floor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
    
    //adjust floor's energy in scene (equivalent of physics material?)
    floor.physicsBody.restitution = 0.05f;
    
    //make floor ignore gravity so it does not fall out of scene
    floor.physicsBody.dynamic = FALSE;
    
    //floor position in scene
    floor.position = CGPointMake(160, 20);
    
    //adds floor to the scene
    [self addChild:floor];

#pragma mark GUI attributes
    
#pragma mark UI header attributes
    SKSpriteNode *UIHeader = [SKSpriteNode spriteNodeWithImageNamed:@"Header"];
    UIHeader.name = @"UIheader";
    UIHeader.zPosition = 1.5f;
    UIHeader.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 256);
    UIHeader.position = CGPointMake(UIHeader.size.width/2, [UIScreen mainScreen].bounds.size.height - UIHeader.size.height/2);
    
    [self addChild:UIHeader];
    
#pragma mark refresh button attributes
    SKSpriteNode *refreshButton = [SKSpriteNode spriteNodeWithImageNamed:@"Button_Refresh_Normal"];
    refreshButton.name = @"RefreshButton";
    refreshButton.zPosition = 2.0f;
    refreshButton.size = CGSizeMake(256,128);
    refreshButton.position = CGPointMake(refreshButton.size.width/2, [UIScreen mainScreen].bounds.size.height - refreshButton.size.height/2);
    
    [self addChild:refreshButton];

    
#pragma mark credit button attributes
    SKSpriteNode *quitButton = [SKSpriteNode spriteNodeWithImageNamed:@"Button_Exit_Normal"];
    quitButton.name = @"QuitButton";
    quitButton.zPosition = 2.0f;
    quitButton.size  = CGSizeMake(256, 128);
    quitButton.position = CGPointMake([UIScreen mainScreen].bounds.size.width-quitButton.size.width/2, [UIScreen mainScreen].bounds.size.height - quitButton.size.height/2);
    
    [self addChild:quitButton];
    
    //initialize guiContoller object
    guiController = [[GUIController alloc] initWithScene:self];
    
    //Draw the Score and timer labels and show the round beginning alert
    [guiController DrawRoundScore:_score];
    [guiController DrawGameTimeElapsed:_timeElapsed];
    //[guiController DrawGameBeginAlert];
    
#pragma mark Initial Block Instantiation
    
    [gameController InstantiateBlocks];
    
    _isSceneReset = true;
}

/**
 * Method Name: <#GetAllBlocks#>
 * Description: <#iterates through all blocks in scene#>
 * Parameters: <#None#>
 * @return <#blocks#>
 */
- (NSArray*) GetAllBlocks
{
    //create array for holding neighboring blocks
    NSMutableArray *blocks = [NSMutableArray array];
    
    for (SKNode *childNode in self.scene.children)
    {
        //safeguard if check
        if ([childNode isKindOfClass:[BlockNode class]])
        {
            //add to array
            [blocks addObject:childNode];
        }
    }
    
    return [NSArray arrayWithArray:blocks];
}//end GetAllBlocks

/**
 * Method Name: <#NodesToRemove#>
 * Description: <#Checks all blocks connected to clicked block and its neighbors with likeness#>
 * Parameters: <#(NSMutableArray*)removedNodes#> <#(BlockNode*)baseNode#>
 * @return <#The nodes to be removed#>
 */-(NSMutableArray*) NodesToRemove: (NSMutableArray*)removedNodes aroundNode:(BlockNode*)baseNode
{
    //add baseNode to removedNodes array
    [removedNodes addObject:baseNode];
    
    //recursively iterate through nodes neighboring the baseNode and child nodes with likeness
    for (BlockNode *childNode in [self GetAllBlocks])
    {
        //if neighboring node is of likeness
        if ([childNode InRange:childNode of:baseNode])
        {
            //ensure node has node been added to removedNodes
            if (![removedNodes containsObject:childNode])
            {
                //if not, add it to array
                removedNodes = [self NodesToRemove:removedNodes aroundNode:childNode];
            }
        }
    }
    
    //return array with nodes to be removed
    return removedNodes;
}

/**
 * Method Name: <#ResetScene:void#>
 * Description: <#Resets the game to the original state at the end of the round#>
 * Parameters:  <#NONE#>
 * @return <#NONE#>
 */
-(void) ResetScene
{
    //clear the scene
    [self removeAllChildren];
    
    //re initialize the screen
    [self SceneSetUp];
    
    
}

/**
 * Method Name: <#RefreshBlocks:void#>
 * Description: <#Instantiates a new selection of randomly generated blocks in the gameplay area#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) RefreshBlocks
{
    for (BlockNode *childNode in [self GetAllBlocks])
    {
        [childNode removeFromParent];
    }
    
    [gameController InstantiateBlocks];
}

/**
 * Method Name: <#goToTitle:void#>
 * Description: <#Presents the Title Menu view#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) GoToTitle
{
    [self removeAllChildren];
    SKScene *titleMenu = [[ TitleMenuScene alloc]initWithSize:self.size];
    SKTransition *effect = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:titleMenu transition:effect];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    //if gameplay has begun
    if (gameController._gameState == STARTING)
    {
        //if the timer is running, the game state is in play mode
        gameController._gameState = PLAYING;
        
        _isSceneReset = false;
    }

    
    //check to see which objects have been touched and where
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *node = (SKSpriteNode*) [self nodeAtPoint:location];
    
    if ([node.name  isEqualToString:@"QuitButton"])
    {
        NSLog(@"Quit button clicked");
        [self GoToTitle];
    }
    
    if ([node.name  isEqualToString:@"RefreshButton"])
    {
        NSLog(@"Refresh button clicked");
        [self RefreshBlocks];
    }
    
    //check to see if node touched is block
    //safeguard if check
    if ([node isKindOfClass: [BlockNode class]])
    {
        //block object to get position of touch
        BlockNode *clickedBlock = (BlockNode*)node;
        
        //debug check for touch
        NSLog(@"Node Clicked: %@ => %ld, %ld", clickedBlock, (unsigned long)clickedBlock._row, (unsigned long)clickedBlock._column);
        
        //array to hold like blocks to remove
        //create an empty array to hold nodes to be removed neighboring clicked block
        NSMutableArray *objectsToRemove = [self NodesToRemove:[NSMutableArray array] aroundNode:clickedBlock];
        
        //check if there are [2](<- value can be changed) or more blocks to be removed prior to removing
        //otherwise you will be able to remove single blocks
        if (objectsToRemove.count >= MIN_BLOCK_BUST)
        {
            //gather all nodes in objects to remove array
            for (BlockNode *deleteNode in objectsToRemove)
            {
                //add particle effect to each block being deleted
                //at the position of each node being deleted
                //as the same color of the block being deleted
                ParticleEffect* blockParticle = [[ParticleEffect alloc] initWithSize:deleteNode.size aroundNode:deleteNode inScene:self];
                
                //once all blocks have been gathered, play a sequence and remove from scene
                
                
                
                [deleteNode removeFromParent];
                
                SKAction *playSound = [SKAction playSoundFileNamed:@"Sound_Destroy.mp3" waitForCompletion:NO];
                
                [self runAction:playSound];

                
                //fade particle to 0% then delete
                [blockParticle runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0 duration:0.35], [SKAction removeFromParent]]]];
                
                
                //shift blocks down
                for (BlockNode *testNode in [self GetAllBlocks])
                {
                    if (deleteNode._column == testNode._column && (deleteNode._row < testNode._row))
                    {
                        --testNode._row;
                    }
                }
                
                //increment score
                ++_score;
                
                //draw "Score"
                [guiController DrawRoundScore:_score];
                
            }
            
            //create array to hold total number of rows and initialize cells to 0
            NSUInteger totalRows[COLUMNS];
            for (int i = 0; i < COLUMNS; i++)
            {
                totalRows[i] = 0;
            }
            
            //iterate through everyblock on screen and get their column and row
            for (BlockNode *node in [self GetAllBlocks])
            {
                //find the maximum row in each column
                if (node._row > totalRows[node._column])
                {
                    totalRows[node._column] = node._row;
                }
            }
            
            for (int col = 0; col < COLUMNS; col++)
            {
                //debug
                NSLog(@"Rows [%d] = %lu", col, (unsigned long)totalRows[col]);
                
                while (totalRows[col] < ROWS -1)
                {
                    TextureLoader *textureLoader = [[TextureLoader alloc]init];
                    SKTexture* blockTexture = [textureLoader GetTexture];
                    UIColor* blockColor = [textureLoader GetColor];
                    
                    //the dimensions of the blocks will equal the width of the screen, minus 1, divided by the defined COLUMNS (6)
                    //this will give us 6 evenly sized blocks
                    //the minus 1 removes a screen division line thay occurs upon draw
                    CGFloat dimension = (self.scene.size.width - 1) / COLUMNS;
                    
                    //use color index for texture index so the blocks match
                    BlockNode *node = [[BlockNode alloc] initWithRow:totalRows[col]+1 andColumn:col withColor: blockColor andTexture: blockTexture andSize:CGSizeMake(dimension,dimension)];
                    
                    //instantiate blocks
                    [self.scene addChild:node];
                    
                    ++totalRows[col];
                }
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    //initialize timer label
    [guiController DrawGameTimeElapsed:_timeElapsed];
    
    //if gameplay has begun
    if (gameController._gameState == STARTING)
    {
        //initialize the timer
        _startedTime = currentTime;
    }
    
    //if the game is being played we need to UPDATE the GUI for time
    if (gameController._gameState == PLAYING)
    {
        //variable to round time to nearest integer
        NSUInteger timeLeftRounded = ceil(LEVEL_TIME + (_startedTime - currentTime));
        
        //assign time to property
        _timeElapsed = timeLeftRounded;
        
        //update the GUI label "Time" witht the rounded variable
        [guiController DrawGameTimeElapsed:timeLeftRounded];
        
        //send time to gamestate to check if <0
        [gameController GameTimer:timeLeftRounded];
    }
    
    //if time runs out change game state to STOPPED
    if (gameController._gameState == STOPPED && gameController._isGameOver == true)
    {
        [guiController DrawGameEndAlert:_score];
        
        if (_isSceneReset == false)
        {
            [self ResetScene];
        }
        
    }
    
    //iterate through all child objects to ensure they stay within their bounds
    for (SKNode *node in self.scene.children)
    {
        node.position = CGPointMake(roundf(node.position.x), roundf(node.position.y));
    }
    
    //check the game state on each update call
    [gameController CheckGameState];
}

@end
