//
//  TextureLoader.m
//  Blocks_iPad
//
//  Created by William Fissler on 4/11/14.
//  Copyright (c) 2014 DoubleDose. All rights reserved.
//

#import "TextureLoader.h"

@implementation TextureLoader

@synthesize _textureNames;
@synthesize _textureColors;
@synthesize _textureIndex;

-(id) init
{
    
    self = [super init];

    if (self)
    {
        
        _textureNames = [[NSArray alloc]init];
        _textureColors = [[NSArray alloc] init];
        
        //array to hold all colors to be initialized
        //use file extentions in name
        _textureNames = @[@"Block_Blue_Gradient.png", @"Block_Red_Gradient.png", @"Block_Green_Gradient.png",  @"Block_Orange_Gradient.png", @"Block_Purple_Gradient.png"];
        
        _textureColors = @[[UIColor blueColor], [UIColor redColor ], [UIColor greenColor ], [UIColor orangeColor], [UIColor purpleColor]];
        
         _textureIndex = arc4random() % _textureNames.count;
        
    }
    
    return self;

}

/**
 * Method Name: <#GetTexture:SKTexture#>
 * Description: <#Obtains desired texture from resource path#>
 * Parameters: <#NONE#>
 * @return <#(SKTexture*) spriteTexture#>
 */
-(SKTexture*) GetTexture
{
    NSString *textureName = [_textureNames objectAtIndex:_textureIndex];
    
    SKTexture *spriteTexture;
    
    spriteTexture = [SKTexture textureWithImageNamed:textureName];
    
    return spriteTexture;
}

/**
 * Method Name: <#GetColor:UIColor#>
 * Description: <#Obtains a color to be used in the InRange sorting method#>
 * Parameters: <#NONE#>
 * @return <#UIColor*) spriteColor#>
 */

-(UIColor*) GetColor
{
    UIColor* spriteColor = [_textureColors objectAtIndex:_textureIndex];
    
    return spriteColor;
}


@end
