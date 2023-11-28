//
//  ParticleEffect.h
//  KiiBlocks
//
//  Created by William Fissler on 4/2/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BlockNode.h"


@interface ParticleEffect : SKEmitterNode

@property (nonatomic, readwrite) SKScene *_myScene;


/**
 * Method Name: <#<Constructor>#>
 * Description: <#Creates particle effect for block explosion#>
 * Parameters: <#initWithSize: (CGSize) size aroundNode: (BlockNode*) node inScene: (SKScene*) scene#>
 * @return <#NONE#>
 */
-(ParticleEffect*) initWithSize: (CGSize) size aroundNode:(BlockNode*) node inScene: (SKScene*) scene;


@end
