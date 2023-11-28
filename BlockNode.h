//
//  BlockNode.h
//  KiiBlocks
//
//  Created by William Fissler on 2/14/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"


@interface BlockNode : SKSpriteNode

@property (nonatomic, assign) NSUInteger _row;
@property (nonatomic, assign) NSUInteger _column;
@property (nonatomic, readwrite) SKScene *_myScene;

/**
 * Method Name: <#<Constructor>#>
 * Description: <#Initializes block node with scene reference#>
 * Parameters: <#(SKScene*) paramMyScene#>
 * @return <#Self#>
 */
-(BlockNode*) initWithScene:(SKScene*) paramMyScene;

/**
 * Method Name: <#<Constructor>#>
 * Description: <#Initializes block node with attributes#>
 * Parameters: <#(NSUInteger)row (NSUInteger)column (UIColor*)color (CGSize)size#>
 * @return <#Self#>
 */
-(BlockNode*) initWithRow: (NSUInteger)row
                andColumn: (NSUInteger)column
                withColor: (UIColor*)color
               andTexture: (SKTexture*) blockTexture
                  andSize: (CGSize)size;

/**
 * Method Name: <#<Destructor>#>
 * Description: <#Adds Particle effect to scene then destroys the block node#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) dealloc;

/**
 * Method Name: <#InRange#>
 * Description: <#Checks which neighboring blocks are in the range of the clicked block#>
 * Parameters: <#(BlockNode*)testNode#> <#(BlockNode*)baseNode#>
 * @return <#If the block is in the same row and is one off of the column OR if the block is in the same column and is one off of the row and the same color#>
 */
-(BOOL) InRange:(BlockNode*)testNode of:(BlockNode*)baseNode;

/**
 * Method Name: <#DestroySequence:void#>
 * Description: <#Performs actions prior to block node destruction#>
 * Parameters: <#NONE#>
 * @return <#NONE#>
 */
-(void) DestroySequence;

@end
