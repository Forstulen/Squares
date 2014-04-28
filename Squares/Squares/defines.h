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

#define     SQUARE_FRAME_INTERVAL               (2)

#define     SQUARE_SCORE_MAX                    (999999999)
#define     SQUARE_MULTIPLIER_MAX               (99)

#define     SQUARE_DELAY_MENU_SQUARE            (4.0)

#define     SQUARE_DELAY_GAME_LINES_GAME             (1.5)
#define     SQUARE_DELAY_GAME_LINES_MENU             (1.2)
#define     SQUARE_DELAY_GAME_LINES_MARGIN_PERCENT  (1)

#define     SQUARE_END_ANIMATION_DURATION       (0.2)
#define     SQUARE_BEGIN_ANIMATION_DURATION     (0.2)

#define     SQUARE_GRID_BLOCK_SIZE              (75)
#define     SQUARE_GRID_PADDING_PERCENT         (15)
#define     SQUARE_GRID_RANDOM_WINDOW           (10)
#define     SQUARE_GRID_MIN_SPACE_PERCENT       (10)

#define     SQUARE_GAME_MIN_CHAIN_NUMBER        (2)
#define     SQUARE_GAME_RESTART_DELAY           (0.5)
#define     SQUARE_GAME_STARTING_RESPAWN_DELAY  (2)

#define     SQUARE_DEMO                         [UIImage imageNamed:SQUARE_IMAGE_BASE];
#define     SQUARE_DEMO_SCORE                   (2)
#define     SQUARE_DEMO_DURATION                (7)
#define     SQUARE_DEMO_DELAY                   (0)
#define     SQUARE_DEMO_TOUCHES_NUMBER          (1)
#define     SQUARE_DEMO_STARTING_SIZE           (10)
#define     SQUARE_DEMO_ENDING_SIZE             (20)

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
#define     SQUARE_INDESTRUCTIBLE_STARTING_SIZE  (25)
#define     SQUARE_INDESTRUCTIBLE_ENDING_SIZE    (50)

#define     SQUARE_GAMEOVER                     [UIImage imageNamed:SQUARE_IMAGE_GAMEOVER];
#define     SQUARE_GAMEOVER_SCORE               (0)
#define     SQUARE_GAMEOVER_DURATION            (5)
#define     SQUARE_GAMEOVER_DELAY               (0)
#define     SQUARE_GAMEOVER_TOUCHES_NUMBER      (-1)
#define     SQUARE_GAMEOVER_STARTING_SIZE       (25)
#define     SQUARE_GAMEOVER_ENDING_SIZE         (50)

#define     SQUARE_RESILIENT                     [UIImage imageNamed:SQUARE_IMAGE_RESILIENT];
#define     SQUARE_RESILIENT_SCORE               (10)
#define     SQUARE_RESILIENT_DURATION            (3)
#define     SQUARE_RESILIENT_DELAY               (0)
#define     SQUARE_RESILIENT_TOUCHES_NUMBER      (3)
#define     SQUARE_RESILIENT_STARTING_SIZE       (25)
#define     SQUARE_RESILIENT_ENDING_SIZE         (100)

#define     SQUARE_EXPONENTIAL                     [UIImage imageNamed:SQUARE_IMAGE_EXPONENTIAL];
#define     SQUARE_EXPONENTIAL_SCORE               (5)
#define     SQUARE_EXPONENTIAL_FIRST_STEP_DURATION  (2)
#define     SQUARE_EXPONENTIAL_SECOND_STEP_DURATION (0.2)
#define     SQUARE_EXPONENTIAL_DELAY               (0)
#define     SQUARE_EXPONENTIAL_TOUCHES_NUMBER      (1)
#define     SQUARE_EXPONENTIAL_STARTING_SIZE       (25)
#define     SQUARE_EXPONENTIAL_MIDDLE_SIZE          (50)
#define     SQUARE_EXPONENTIAL_ENDING_SIZE         (100)

#define     SQUARE_COLOR_ORANGE                   [UIColor colorWithRed:(223.f / 255.f) green:(116.f / 255.f) blue:(12.f / 255.f) alpha:1]
#define     SQUARE_COLOR_YELLOW                 [UIColor colorWithRed:(255.f / 255.f) green:(230.f / 255.f) blue:(	77.f / 255.f) alpha:1]

#define     SQUARE_COLOR_PANE  [UIColor colorWithRed:(230.f / 255.f) green:1 blue:1 alpha:1]

#define     SQUARE_COLOR_CYAN               [UIColor colorWithRed:(111.f / 255.f) green:(195.f / 255.f) blue:(223.f / 255.f) alpha:1]
#define     SQUARE_COLOR_BASESTART               [UIColor colorWithRed:(12.f / 255.f) green:(20.f / 255.f) blue:(31.f / 255.f) alpha:1]
#define     SQUARE_COLOR_TRANSPARENT_WHITE               [UIColor colorWithRed:1 green:1 blue:1 alpha:.1f]



#define     SQUARE_FONT_SMALL                   [UIFont fontWithName:@"SquareFont" size:10];
#define     SQUARE_FONT_MEDIUM                   [UIFont fontWithName:@"SquareFont" size:16];
#define     SQUARE_FONT_BIG                   [UIFont fontWithName:@"SquareFont" size:24];
#define     SQUARE_FONT_HUGE                   [UIFont fontWithName:@"SquareFont" size:40];


// Images (TEST)
static NSString     *SQUARE_IMAGE_BASE = @"Square Base.png";
static NSString     *SQUARE_IMAGE_GAMEOVER = @"Square Death.png";
static NSString     *SQUARE_IMAGE_EXPONENTIAL = @"Square Exponential.png";
static NSString     *SQUARE_IMAGE_RESILIENT = @"Square Resilient";
static NSString     *SQUARE_IMAGE_INDESTRUCTIBLE = @"Square Indestructible.png";

static NSString     *SQUARE_SMALL_BUTTON = @"Button small.png";
static NSString     *SQUARE_LARGE_BUTTON = @"Button large.png";

// Audio
static NSString     *SQUARE_SOUND_CLICK = @"UI Sound.m4a";
static NSString     *SQUARE_SOUND_EXPLOSION = @"Explosion.m4a";
static NSString     *SQUARE_SOUND_MULTIPLIER = @"Multiplier.m4a";
static NSString     *SQUARE_SOUND_GAMEOVER = @"GameOver.m4a";
static NSString     *SQUARE_MUSIC_AMBIENT = @"Ambient BG.m4a";
static NSString     *SQUARE_MUSIC_INGAME = @"Music IG.m4a";

// Strings
static NSString     *SQUARE_LEVELS_PLIST = @"Levels";
static NSString     *SQUARE_LEVELS_TRAINING = @"Training";
static NSString     *SQUARE_LEVELS_HARDCORE = @"Hardcore";

static NSString     *SQUARE_LEVELS_REFRESH_DELAY = @"RefreshDelay";
static NSString     *SQUARE_LEVELS_SPAWN_DELAY = @"SpawnDelay";
static NSString     *SQUARE_LEVELS_RESPAWN = @"Respawn";
static NSString     *SQUARE_LEVELS_NEXT_LEVEL = @"NextLevel";
static NSString     *SQUARE_LEVELS_SQUARE_NUMBER = @"Number";
static NSString     *SQUARE_LEVELS_INACTIVITY_DELAY = @"InactivityDelay";
static NSString     *SQUARE_LEVELS_AVAILABLE_SQUARES = @"Squares";

static NSString     *SQUARE_BEST_SCORE_TRAINING = @"BestScoreTraining";
static NSString     *SQUARE_BEST_SCORE_HARDCORE = @"BestScoreHardcore";

static NSString     *SQUARE_MULTIPLIER_RESET = @"FAIL";

static NSString     *SQUARE_OPTIONS_SOUND = @"SoundOption";
static NSString     *SQUARE_OPTIONS_MUSIC = @"MusicOption";

static NSString     *SQUARE_PGM = @"PGM";
static NSString     *SQUARE_STUNNING = @"oO";


/*
static NSString     *SQUARE_ENUM_COLOR_BLUE = @"SquareBaseBlue";
static NSString     *SQUARE_ENUM_COLOR_RED = @"SquareBaseRed";
static NSString     *SQUARE_ENUM_COLOR_YELLOW = @"SquareBaseYellow";
static NSString     *SQUARE_ENUM_COLOR_GREEN = @"SquareBaseGreen";
static NSString     *SQUARE_ENUM_COLOR_NONE = @"SquareBaseNone";

static NSString     *SQUARE_ENUM_TYPE_BASE = @"SquareTypeBase";
static NSString     *SQUARE_ENUM_TYPE_INDESTRUCTIBLE = @"SquareTypeIndestructible";
static NSString     *SQUARE_ENUM_TYPE_GAMEOVER = @"SquareTypeGameOver";
static NSString     *SQUARE_ENUM_TYPE_RESILIENT = @"SquareTypeResilient";
static NSString     *SQUARE_ENUM_TYPE_EXPONENTIAL = @"SquareTypeExponential";
static NSString     *SQUARE_ENUM_TYPE_NONE = @"SquareTypeNone";
*/


// Facebook
static NSString     *SQUARE_FACEBOOK_ID = @"737859579566542";
static NSString     *SQUARE_FACEBOOK_PERMISSION = @"publish_stream";

// Events
static NSString     *SQUARE_UPDATE_SCORE = @"square_update";
static NSString     *SQUARE_DESTROYED = @"square_destroyed";
static NSString     *SQUARE_MULTIPLIER = @"square_multiplier";
static NSString     *SQUARE_PAUSE = @"square_pause";
static NSString     *SQUARE_GAME_OVER = @"square_game_over";
static NSString     *SQUARE_BEST_SCORE_EVER = @"BestScoreEver";

#endif
