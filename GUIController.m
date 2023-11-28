//
//  GUI Controller.m
//  KiiBlocks
//
//  Created by William Fissler on 2/25/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//

#import "GUIController.h"

@implementation GUIController

//synthesize properties//
@synthesize _score;
@synthesize _timeElapsed;
@synthesize _myScene;
@synthesize _timerLabel;
@synthesize _scoreLabel;


/**
 * Method Name: <#<Constructor>#>
 * Description: <#Initializes GUIController with scene reference#>
 * Parameters: <#(SKScene*) paramMyScene#>
 * @return <#Self#>
 */
-(GUIController*) initWithScene:paramMyScene
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
 * Method Name: <#DrawRoundScore#>
 * Description: <#Draws a GUI label showing player's score#>
 * Parameters: <#(NSUInteger) score;#>
 * @return <#NONE#>
 */
-(void) DrawRoundScore: (NSUInteger) score;
{
    [_scoreLabel removeFromParent];
    
    //all attributes associated with the GUI label "Score"
    _score = score;
    _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier-BoldOblique"];
    _scoreLabel.text = [NSString stringWithFormat:@"0%ld", (unsigned long)_score ];
    _scoreLabel.fontColor = [UIColor whiteColor];
    _scoreLabel.fontSize = 48.0f;
    _scoreLabel.zPosition = 2.1f;
    _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _scoreLabel.position = CGPointMake(([UIScreen mainScreen].bounds.size.width/2) + 30, [UIScreen mainScreen].bounds.size.height - TIMER_LABEL_COORD_Y - 100);
    
    [_myScene addChild:_scoreLabel];
    
}//end DrawRoundScore

/**
 * Method Name: <#DrawGameTimeElapsed#>
 * Description: <#Draws a GUI label showing the time elapsed since the round started#>
 * Parameters: <#(CFTimeInterval) timeElapsed#>
 * @return <#NONE#>
 */
-(void) DrawGameTimeElapsed: (NSUInteger) timeElapsed
{
    
    [_timerLabel removeFromParent];
    
    //all attributes associated with the GUI label "Time"
    _timeElapsed = timeElapsed;
    _timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier-BoldOblique"];
    _timerLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)_timeElapsed];
    _timerLabel.fontColor = [UIColor whiteColor];
    _timerLabel.fontSize = 48.0f;
    _timerLabel.zPosition = 2.1f;
    _timerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    _timerLabel.position = CGPointMake(([UIScreen mainScreen].bounds.size.width/2) + 90, [UIScreen mainScreen].bounds.size.height - TIMER_LABEL_COORD_Y);
    
    [_myScene addChild:_timerLabel];
    
}//end DrawGameTimeElapsed



/**
 * Method Name: <#DrawGameEndAlert#>
 * Description: <#Draws an Alert View showing the options available at game end#>
 * Parameters: <#(NSUInteger) _score#>
 * @return <#NONE#>
 */
-(void) DrawGameEndAlert: (NSUInteger) score
{
    //display message to user
    NSString *message = [NSString stringWithFormat:@"You scored %ld this time", (unsigned long)_score];
    
    //display an Alert view to user and provide options for navigation
    UIAlertView *endAlert = [[UIAlertView alloc] initWithTitle:@"Game Over!"
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
    
    //show message
    [endAlert show];
    
    }//end DrawGameEndAlert

@end
