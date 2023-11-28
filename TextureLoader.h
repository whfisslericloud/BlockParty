//
//  TextureLoader.h
//  Blocks_iPad
//
//  Created by William Fissler on 4/11/14.
//  Copyright (c) 2014 DoubleDose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@interface TextureLoader : NSObject

@property (nonatomic, readwrite)NSArray* _textureNames;
@property (nonatomic, readwrite)NSArray* _textureColors;
@property (nonatomic, readwrite)NSUInteger _textureIndex;

/**
 * Method Name: <#GetTexture:SKTexture#>
 * Description: <#Obtains desired texture from resource path#>
 * Parameters: <#NONE#>
 * @return <#(SKTexture*) spriteTexture#>
 */
-(SKTexture*) GetTexture;

/**
 * Method Name: <#GetColor:UIColor#>
 * Description: <#Obtains a color to be used in the InRange sorting method#>
 * Parameters: <#NONE#>
 * @return <#UIColor*) spriteColor#>
 */
-(UIColor*) GetColor;

@end
