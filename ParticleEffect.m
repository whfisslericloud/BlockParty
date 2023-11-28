//
//  ParticleEffect.m
//  KiiBlocks
//
//  Created by William Fissler on 4/2/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//

#import "ParticleEffect.h"

@implementation ParticleEffect

@synthesize _myScene;

/**
 * Method Name: <#<Constructor>#>
 * Description: <#Initializes empty particle node#>
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
 * Description: <#Initializes empty particle nonde#>
 * Parameters: <#NONE#>
 * @return <#Self#>
 */
-(ParticleEffect*) initWithSize: (CGSize) size aroundNode: (BlockNode*) node inScene:(SKScene *)scene
{
    
        self = [super init];
        
        if (self)
        {
            
#pragma mark Particle Emmitter attributes
            
            //assign scene reference
            _myScene = scene;
            
            //block particle effects to be displayed upon block deletion
            NSString *BlockParticlePath;
            SKEmitterNode *BlockParticle;
            
            //get the effect from the resource folder
            BlockParticlePath = [[NSBundle mainBundle] pathForResource:@"particle" ofType:@"sks"];
            BlockParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:BlockParticlePath];
            
             //set position to block position
            BlockParticle.position = CGPointMake(node.position.x, node.position.y);
            
            //draw in front of blocks
            BlockParticle.particleZPosition = 1.0f;
            
            //change channel speeds so color adapts immediately
            BlockParticle.particleColorRedSpeed = 1.0f;
            BlockParticle.particleColorBlueSpeed = 1.0f;
            BlockParticle.particleColorGreenSpeed = 1.0f;
            BlockParticle.alpha = 1.0f;
            
            //change color to block color
            BlockParticle.particleColor = node.color;
            
            BlockParticle.userInteractionEnabled = NO;

            
            [_myScene addChild:BlockParticle];
            
        }
        
        return self;
}

@end
