boolean gameEnded = false;
boolean floorDone = false;
boolean killed = false;
boolean lostLife= false;
boolean shot = false;
boolean charged = false;
boolean gameStarted = false;
boolean userNameInput = false;
boolean firstStart = true; // determines the first starting of the game, so that the backround story is only shown once
boolean platformsDrawn = false; // True if platform arrays are full
boolean keyCollected = false;
boolean levelUp = false;
boolean weaponCollected = false;
boolean ballsFree = false;

int rad = 50;        // Width of the shape
int powermode=0;
int t = 0;            //time as a numer
int interval = 60;    //the time for one level
int prestartTime = 0; // counts the time until the user name is given
int AMOUNT = 7;
int boardL=1000;
int boardH=400;
int rect1=40;
int rect2=60;
int rposx=100;
int rposy=100;
int score;
int lives = 2;
int points = 0;//points shown on the screen during the game, and used for incrementing lives
int totalpoints = 0; //total points
int game = 0;
int line = 0;
int [] scoreboard = new int[20];
int levelCount = 1;
int keyX = 900;
int keyY = 100;


float xpos, ypos;    // Starting position of shape  
float xmov; // Smoothing the transitions
float xpower1 = random(100,300);
float ypower1 = random(10,300);
float xpower2 = random(200,500);
float ypower2 = random(300,500);
float nxpower1 = 0;
float nypower1 = 0;
float nxpower2 = 0;
float nypower2 = 0;
float radpower = 20;
float xspeed = 0;  // Speed of the shape
float yspeed = 7;  // Speed of the shape
float yacceleration = 0; // Y Acceleration
float xacceleration = 0; // X Acceleration
float xdirection = 1;  // Left or Right
float ydirection = 1;  // Top to Bottom
float placeX2 = 0; //Ending X coordinate for a platform
float placeY2 = 0; //Ending Y coordinate for a platform
float placeX = 0;  //Starting X coordinate for a platform
float placeY = 0;  //Starting Y coordinate for a platform
float [] ArrPlaceX2 = new float[AMOUNT]; // Array to store ending X coordinates 
float [] ArrPlaceY2 = new float[AMOUNT]; // Array to store ending Y coordinates 
float [] ArrPlaceX = new float[AMOUNT];  // Array to store starting X coordinates 
float [] ArrPlaceY = new float[AMOUNT];  // Array to store starting Y coordinates 
float dY = 2;
float depth = 10; // depth of the ground and ceiling
float holeLenght = 75; // size of the hole
float holeC = 0; // places of holes in ceiling and ground
float holeG = 0;
FloatList nastiesX = new FloatList();
FloatList nastiesY = new FloatList();
float bar = 0;
float xbeam = 0;
float ybeam = 0;
float weaponX = boardL-keyX;
float weaponY = boardH-keyY;
    


String userName = "";
String time = "";     // time as a string
String endText = "Congratulation You are now in Level 2";
String [] players = new String[20];

color c1 = #daa520;
color c2 = #ffff00;
color c3 = #ee8262;

PImage img1;
PImage img2;
PImage img3;
PImage bg1;
PImage bg2;
PImage ball;
PImage ball_dead;
PImage ball_happy;
PImage enemy;
PImage keyImage;
PImage weaponImage;

PFont font;
