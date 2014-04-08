//
//  defines.h
//  Squares
//
//  Created by Romain on 4/5/14.
//
//

#ifndef Squares_defines_h
#define Squares_defines_h

//Defines
#define     SQUARE_END_ANIMATION_DURATION       (0.2)
#define     SQUARE_BEGIN_ANIMATION_DURATION     (0.2)

#define     SQUARE_GRID_BLOCK_SIZE              (75)
#define     SQUARE_GRID_PADDING_PERCENT         (15)
#define     SQUARE_GRID_RANDOM_WINDOW           (10)
#define     SQUARE_GRID_MIN_SPACE_PERCENT       (10)

#define     SQUARE_GAME_MIN_CHAIN_NUMBER        (3)
#define     SQUARE_GAME_BONUS_CHAIN             (10)
#define     SQUARE_GAME_RESTART_DELAY           (0.5)
#define     SQUARE_GAME_STARTING_RESPAWN_DELAY  (2)

#define     SQUARE_BASE                         [UIImage imageNamed:SQUARE_IMAGE_BASE];
#define     SQUARE_BASE_SCORE                   (2)
#define     SQUARE_BASE_DURATION                (5)
#define     SQUARE_BASE_DELAY                   (0)
#define     SQUARE_BASE_TOUCHES_NUMBER          (1)
#define     SQUARE_BASE_STARTING_SIZE           (25)
#define     SQUARE_BASE_ENDING_SIZE             (150)

#define     SQUARE_INDESTRUCTIBLE                [UIImage imageNamed:SQUARE_IMAGE_INDESTRUCTIBLE];
#define     SQUARE_INDESTRUCTIBLE_SCORE          (0)
#define     SQUARE_INDESTRUCTIBLE_DURATION       (3)
#define     SQUARE_INDESTRUCTIBLE_DELAY          (0)
#define     SQUARE_INDESTRUCTIBLE_TOUCHES_NUMBER (-1)
#define     SQUARE_INDESTRUCTIBLE_STARTING_SIZE  (10)
#define     SQUARE_INDESTRUCTIBLE_ENDING_SIZE    (25)

#define     SQUARE_GAMEOVER                     [UIImage imageNamed:SQUARE_IMAGE_GAMEOVER];
#define     SQUARE_GAMEOVER_SCORE               (0)
#define     SQUARE_GAMEOVER_DURATION            (3)
#define     SQUARE_GAMEOVER_DELAY               (0)
#define     SQUARE_GAMEOVER_TOUCHES_NUMBER      (-1)
#define     SQUARE_GAMEOVER_STARTING_SIZE       (10)
#define     SQUARE_GAMEOVER_ENDING_SIZE         (25)

#define     SQUARE_RESILIENT                     [UIImage imageNamed:SQUARE_IMAGE_RESILIENT];
#define     SQUARE_RESILIENT_SCORE               (10)
#define     SQUARE_RESILIENT_DURATION            (3)
#define     SQUARE_RESILIENT_DELAY               (0)
#define     SQUARE_RESILIENT_TOUCHES_NUMBER      (3)
#define     SQUARE_RESILIENT_STARTING_SIZE       (25)
#define     SQUARE_RESILIENT_ENDING_SIZE         (150)

#define     SQUARE_EXPONENTIAL                     [UIImage imageNamed:SQUARE_IMAGE_EXPONENTIAL];
#define     SQUARE_EXPONENTIAL_SCORE               (10)
#define     SQUARE_EXPONENTIAL_FIRST_STEP_DURATION  (2)
#define     SQUARE_EXPONENTIAL_SECOND_STEP_DURATION (0.5)
#define     SQUARE_EXPONENTIAL_DELAY               (0)
#define     SQUARE_EXPONENTIAL_TOUCHES_NUMBER      (1)
#define     SQUARE_EXPONENTIAL_STARTING_SIZE       (25)
#define     SQUARE_EXPONENTIAL_MIDDLE_SIZE          (50)
#define     SQUARE_EXPONENTIAL_ENDING_SIZE         (150)

#define     SQUARE_COLOR_BLUE                   [UIColor colorWithRed:0 green:0 blue:1 alpha:1]
#define     SQUARE_COLOR_GREEN                  [UIColor colorWithRed:0 green:1 blue:0 alpha:1]
#define     SQUARE_COLOR_RED                    [UIColor colorWithRed:1 green:0 blue:0 alpha:1]
#define     SQUARE_COLOR_YELLOW                 [UIColor colorWithRed:1 green:1 blue:0 alpha:1]

// Images (TEST)
static NSString     *SQUARE_IMAGE_BASE = @"square-clip-art-15.png";
static NSString     *SQUARE_IMAGE_GAMEOVER = @"HAL9000-2001_A_Space_Odyssey.jpg";
static NSString     *SQUARE_IMAGE_EXPONENTIAL = @"square diago.gif";
static NSString     *SQUARE_IMAGE_RESILIENT = @"square tiles.jpeg";
static NSString     *SQUARE_IMAGE_INDESTRUCTIBLE = @"square white.png";


// Events
static NSString     *SQUARE_DESTROYED = @"square_destroyed";
static NSString     *SQUARE_BONUS = @"square_bonus";
static NSString     *SQUARE_GAME_OVER = @"square_game_over";

#endif
