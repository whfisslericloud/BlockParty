//
//  GUI Controller.h
//  KiiBlocks
//
//  Created by William Fissler on 2/25/14.
//  Copyright (c) 2014 William Fissler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#define SCORE_LABEL_COORD_X 10
#define SCORE_LABEL_COORD_Y 10
#define TIMER_LABEL_COORD_X 310
#define TIMER_LABEL_COORD_Y 85


@interface GUIController : SKNode <UIAlertViewDelegate>


//properties
@property (nonatomic, readwrite) NSUInteger _score;
@property (nonatomic, readwrite) NSUInteger _timeElapsed;
@property (nonatomic, readwrite) SKScene *_myScene;
@property (nonatomic, readwrite) SKLabelNode *_scoreLabel;
@property (nonatomic, readwrite) SKLabelNode *_timerLabel;

/**
 * Method Name: <#<Constructor>#>
 * Description: <#Initializes GUIController with scene reference#>
 * Parameters: <#(SKScene*) paramMyScene#>
 * @return <#Self#>
 */
-(GUIController*) initWithScene:paramMyScene;

/**
 * Method Name: <#DrawScore#>
 * Description: <#Draws GUI associated with gameplay elements#>
 * Parameters: <#(BOOL) drawGamePlayGUI#>
 * @return <#NONE#>
 */
-(void) DrawRoundScore: (NSUInteger) score;

/**
 * Method Name: <#DrawGameTimeElapsed#>
 * Description: <#Draws a GUI label showing the time elapsed since the round started#>
 * Parameters: <#(CFTimeInterval) timeElapsed#>
 * @return <#NONE#>
 */

-(void) DrawGameTimeElapsed: (NSUInteger) timeElapsed;

/**
 * Method Name: <#DrawGameEndAlert#>
 * Description: <#Draws an Alert View showing the options available at game end#>
 * Parameters: <#(NSUInteger) _score#>
 * @return <#NONE#>
 */
-(void) DrawGameEndAlert: (NSUInteger) score;


@end
