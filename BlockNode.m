//
//  BlockNode.m
//  KiiBlocks
//
//  Created by William Fissler on 2/14/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//
@class BlockNode;

#import "BlockNode.h"

@implementation BlockNode

//synthesize properties
@synthesize _myScene;
@synthesize _row;
@synthesize _column;

//definitions
#define COLUMNS 8 //width of game board
#define ROWS 8 //height of game board

/**
 * Method Name: <#BlockNode Default Constructor#>
 * Description: <#Initializes empty block node#>
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
 * Method Name: <#BlockNode Constructor#>
 * Description: <#Initializes block node with scene reference#>
 * Parameters: <#(SKScene*) paramMyScene#>
 * @return <#Self#>
 */
-(BlockNode*) initWithScene:(SKScene*) paramMyScene
{
    self = [super init];
    
    if (self)
    {
        //initialize property with scene reference
        _myScene = paramMyScene;
        
    }
    
    return self;
}

/**
 * Method Name: <#BlockNode <Constructor>#>
 * Description: <#Initializes block node with attributes#>
 * Parameters: <#(NSUInteger)row (NSUInteger)column (UIColor*)color (CGSize)size#>
 * @return <#Self#>
 */
-(BlockNode*) initWithRow: (NSUInteger)row
                andColumn: (NSUInteger)column
                withColor: (UIColor*)color
               andTexture: (SKTexture*) blockTexture
                  andSize: (CGSize)size
{
    self = [super initWithTexture:blockTexture color:color size:size];
    
    if (self)
    {
        
        //initialize properties
        _row = row;
        _column = column;
        
        //adds physics body to the created block of slightly smaller size than the block
        //a slightly smaller size of physics body allows blocks to rest on each other with less of a gap (or no gap)
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(size.width - 2, size.height - 2)];
        
        //adjust block's energy in scene (equivalent of physics material?)
        self.physicsBody.restitution = 0.3f;
        
        //remove rotation ability from blocks
        self.physicsBody.allowsRotation = false;
        
        //xPosition & yPosition line up the the created blocks evenly across the screen
        CGFloat xPosition = (size.width / 2) + (_column * size.width);
        CGFloat yPosition = [UIScreen mainScreen].bounds.size.height + ( (size.height / 2 ) + (_row * size.height));
        
        //gives block a position for instantiation
        self.position = CGPointMake(xPosition, yPosition);
        self.zPosition = 1.2f;
    }
    
    return self;
}//end BlockNode constructor

/**
 * Method Name: <#BlockNode <Destructor>#>
 * Description: <#Adds Particle effect to scene then destroys the block node#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) dealloc
{
        
    NSLog(@"blocknode destroyed");
}

/**
 * Method Name: ;
 * Description: <#Checks which neighboring blocks are in the range of the clicked block#>
 * Parameters: <#(BlockNode*)testNode#> <#(BlockNode*)baseNode#>
 * @return <#If the block is in the same row and is one off of the column OR if the block is in the same column and is one off of the row and the same color#>
 */
-(BOOL) InRange:(BlockNode*)testNode of:(BlockNode*)baseNode
{
    //comparisons
    BOOL isRow = (baseNode._row == testNode._row);
    BOOL isCol = (baseNode._column == testNode._column);
    BOOL oneOffCol = (baseNode._column +1 == testNode._column || baseNode._column -1 == testNode._column);
    BOOL oneOffRow = (baseNode._row +1 == testNode._row || baseNode._row -1 == testNode._row);
    BOOL sameColor = [baseNode.color isEqual:testNode.color];
    
    //If the block is in the same row AND is one off of the column OR if the block is in the same column AND is one off of the row AND the same color
    return ((isRow && oneOffCol) || (isCol && oneOffRow)) && sameColor;
    
}//end InRange

/**
 * Method Name: <#DestroySequence:void#>
 * Description: <#Performs actions prior to block node destruction#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void)DestroySequence
{
    SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:1.0];
    SKAction *playSound = [SKAction playSoundFileNamed:@"Sound_Destroy.mp3" waitForCompletion:NO];
    
    SKAction *destroySequence = [SKAction sequence:@[playSound, fadeOut]];
    
    [self runAction:destroySequence];

}



@end
