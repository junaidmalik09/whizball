int rad = 30;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 0;  // Speed of the shape
float yspeed = 9;  // Speed of the shape

float yacceleration = 0; // Y Acceleration
float xacceleration = 0; // X Acceleration

float xdirection = 1;  // Left or Right
float ydirection = 1;  // Top to Bottom
PImage img1;
String userName = "";

/*** Game State Boolean Variables ****/
boolean gameStarted = false;
boolean userNameInput = false;
boolean firstStart = true; // determines the first starting of the game, so that the backround story is only shown once

PFont font;
String time = "";     // time as a string
int t = 0;            //time as a numer
int interval = 20;    //the time for one level
int prestartTime = 0; // counts the time until the user name is given

float placeX2 = 0; //Ending X coordinate for a platform
float placeY2 = 0; //Ending Y coordinate for a platform
float placeX = 0;  //Starting X coordinate for a platform
float placeY = 0;  //Starting Y coordinate for a platform

float [] ArrPlaceX2 = new float[10]; // Array to store ending X coordinates 
float [] ArrPlaceY2 = new float[10]; // Array to store ending Y coordinates 
float [] ArrPlaceX = new float[10];  // Array to store starting X coordinates 
float [] ArrPlaceY = new float[10];  // Array to store starting Y coordinates 

boolean platformsDrawn; // True if platform arrays are full

float dY = 2;
int boardL=1000;
int boardH=400;
PImage bg1;
PImage bg2;
String endText = "Congratulation You are now in Level 2";
int score;
PImage ball;
int rect1=40;
int rect2=60;
int rposx=100;
int rposy=100;



boolean gameEnded = false;
boolean floorDone = false;

// depth of the ground and ceiling
float depth = 10;
// size of the hole
float holeLenght = 100;

// places of holes in ceiling and ground
float holeC = 0;
float holeG = 0;


void setup()   
{
  img1 = loadImage("1.jpg");
  size(800, 600);

  size(boardL, boardH);
  bg1 = loadImage("back1.jpg");
  bg2 = loadImage("back2.jpg");

  frameRate(30);
  noStroke();
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
  font = createFont("Arial", 30);
}

void draw() 
{

  if (!gameStarted && firstStart) {
    // Show start up image
    //image(img1, 0, 0);
    textSize(36);
    //textAlign(CENTER);
    text("BREAKOUT BALL", 300, 40);
    textSize(28);
    text("The ball was wrongly convicted to jail and now it wants revenge.", 35, 100);
    text("It is now on a runaway to get out of the prison grounds.", 35, 150);
    text("There are many prison walls and guards on the way.", 35, 200);
    text("But the further away the ball runs the more difficult it gets...", 35, 250);
    //text("It has to run faster and get away from more guards.", 30, 250);
    //text("Luckily there are weapons to collect on the way to make the escape easier.", 30, 290);
    text("Help the ball to get out!", 35, 330);
    firstStart = false;
  } else if (gameEnded)
  {
    //text("Time run out",40,60);

    background(0, 0, 0);
    // Get user input 
    textSize(120);
    text("GAME OVER", 75, 250);
    textSize(30);
    text("press ENTER to continue", 100, 350);
  } else if (!gameStarted ) {
    // Show start up image
    //image(img1, 0, 0);
  } else if (gameStarted && !userNameInput) {
    background(0);
    // Get user input 
    textSize(36);
    text("BREAKOUT BALL", 300, 40);


    textSize(28);
    text("Please write your name and hit enter to start playing. ", 30, 100);


    text(userName, 300, 150);
    fill(0, 255, 0);
  } else if (gameStarted && userNameInput ) {


    background(255, 255, 255);
    image(bg1, xpos-(xpos*1.5), 0);
    //image(bg2, xpos-(xpos*1.1), 340);
    //rect(rect1, rect2, rposx, rposy);

    score = frameCount;

    if (xpos > boardL)
    {        
      background(0, 0, 0);
      noLoop();
      text(endText, boardL/2, boardH/2);
      text("You played: ", 50, 30);
      text(score, 50, 50);
    }

    ypos = ypos+dY;
    if (ypos > boardH-(120)) {
      dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
    }
    if (ypos < 0) 
    {
      dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
    } 

    timer();
    textSize(35);
    text(time, width/2, height/8);
    platforms();
    //collisionPlatform();

    if (yacceleration < 0) {
      if (yspeed > 0.1) {
        yspeed += yacceleration*0.1;
      }
    } else if (yacceleration > 0) {
      if (yspeed < 100) {
        yspeed += yacceleration*0.1;
      }
    }


    // Update the position of the shape
    //xpos = xpos + ( (xspeed) * (xdirection) );
    ypos = ypos + ( (yspeed) * (ydirection) );

    // Test to see if the shape exceeds the boundaries of the screen
    // If it does, reverse its direction by multiplying by -1
    if (xpos > width-rad || xpos < rad) {
      xdirection *= -1;
    } else {
      fill(255);
    }
    
    collisionPlatform();


    if (ypos > height-rad -depth || ypos < rad +depth) {
      ydirection *= -1;

      // if ball goes to the hole the game ends
      if (xpos > holeC && xpos <holeC+holeLenght || xpos >holeG && xpos < holeG+holeLenght)
      {
        gameEnded = true;
      }
    }


    // Draw the shape
    stroke(0);
    ellipse(xpos, ypos, rad, rad);
    stroke(0);
    ellipse(xpos-15, ypos-8, rad/5, rad/4);
    stroke(0);
    ellipse(xpos+15, ypos-8, rad/5, rad/4);
    stroke(0);
    ellipse(xpos, ypos+15, rad/2, rad/6);



    textSize(12);
    text(userName, 40, 40);

    // Debug Info
    text("Acceleration: ", 40, 55);
    text(yacceleration, 150, 55);
    /*text("YSpeed: ",40,70);
     text(yspeed,150,70);
     text("XSpeed: ",40,85);
     text(xspeed,150,85);*/

    if (ypos > boardH) {
      dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
    }
    if (ypos < 0) 
    {
      dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
    }
  }
}




void keyPressed() {
  if (!gameStarted  ) {
    gameStarted = true;
  } else if (!userNameInput  ) {
    // Keep on taking user input until enter is pressed
    if (key != '\n') {
      userName = userName + key;
      prestartTime = millis();
    } else {
      userNameInput = true;
    }
  } else if (gameStarted && userNameInput) {
    if (key == CODED) {
      if (keyCode == UP) {
        //yacceleration += 3;
      } else if (keyCode == DOWN) {
        //yacceleration -= 3;
      } else if (keyCode == LEFT) {
        collisionPlatform();
        //xspeed -= 1;
        xpos -= 3;
      } else if (keyCode == RIGHT) {
        collisionPlatform();
        xpos += 3;
      }
      collisionPlatform();
    }
  }


  if ( gameEnded )
  {
    if (key == '\n') {

      userName = "";
      xpos = width/2;
      ypos = height/2;
      xspeed = 0;
      yspeed = 3;
      yacceleration = 0;
      xacceleration = 0;

      time = "";
      interval = 20;
      t = interval;
      prestartTime = 0;

      gameEnded = false; 
      gameStarted= false;
      userNameInput =false;
    }
  }
}

//Name: platforms
//use: for creating and drawing the platforms
void platforms()
{
  boolean accepted = false;

  if (!platformsDrawn)
  {  
    int counter = 0;

    //new platforms are created 10 times. 
    //However, not all of them are saved, if they are on top of each other
    while ( counter < 10 )
    {
      accepted = false; // true if plaforms are not on top of each other
      placeX = random(0, 700); 
      placeY = random(300, 550);
      placeX2 = random(placeX + 10, placeX + 55);
      placeY2 = 600;

      for ( int j = 0; j < counter; ++j )
      {
        accepted = true;

        // check if the new platform is on top of earlier one  
        if ( placeX <= ArrPlaceX[j] && placeX2 > ArrPlaceX[j])
        { 
          accepted = false;
          break;
        }
        if ( ArrPlaceX2[j] > placeX && placeX2 > ArrPlaceX2[j])
        { 
          accepted = false;
          break;
        }
        if ( placeX > ArrPlaceX[j] &&  placeX2 < ArrPlaceX2[j] || placeX < ArrPlaceX[j] &&  placeX2 > ArrPlaceX2[j])
        {
          accepted = false;
          break;
        }
      }

      // if the new platform is not on top of any previous platform, save it
      if (accepted)
      {
        ArrPlaceX2[counter] = placeX2;
        ArrPlaceY2[counter] = placeY2;
        ArrPlaceX[counter] = placeX;
        ArrPlaceY[counter] = placeY;
      }  

      counter++;
    }


    platformsDrawn = true;
  } 

  // draw the floor and the ceiling
  if (!floorDone)
  {
    holeC = random(0, 800);

    holeG = random(0, 800);
    floorDone = true;
  }
  rectMode(0);
  fill(102);
  //ceiling
  rect(0, 0, holeC, depth);
  rect(holeC+holeLenght, 0, boardL, depth);

  // floor
  rect(0, 600, holeG, -depth);
  rect(holeG+holeLenght, boardH, boardL, -depth);

  //draw the platforms
  for ( int i = 0; i < 10; ++i)
  {
    rectMode(CORNERS);
    fill(102);
    rect(ArrPlaceX[i], ArrPlaceY[i], ArrPlaceX2[i], ArrPlaceY2[i]);
  }
}


//Name: timer
//use: counts dowm the time
void timer()
{
  t = interval-int((millis()-prestartTime)/1000);
  time = nf(t, 2);

  if (t < 5)
  {
    textSize(50);
    text( "HURRY UP!! ", width/4, height/4); 

    text( "Time is runnig out!", width/4, height/3);
  }
  if (t == 0)
  {

    gameEnded= true;
  }
  // text(time, width/2, height/2);
}

/*
//Name: platforms
 //use: for creating and drawing the platforms
 void platforms()
 {
 boolean accepted = false;
 
 if (!platformsDrawn)
 {  
 int counter = 0;
 
 //new platforms are created 7 times. 
 //However, not all of them are saved, if they are on top of each other
 while ( counter < 7 )
 {
 accepted = false; // true if plaforms are not on top of each other
 placeX = random(0, 700); 
 placeY = random(300, 550);
 placeX2 = random(placeX + 10, placeX + 55);
 placeY2 = 600;
 
 for ( int j = 0; j < counter; ++j )
 {
 accepted = true;
 
 // check if the new platform is on top of earlier one  
 if ( placeX <= ArrPlaceX[j] && placeX2 > ArrPlaceX[j])
 { 
 accepted = false;
 break;
 }
 if ( ArrPlaceX2[j] > placeX && placeX2 > ArrPlaceX2[j])
 { 
 accepted = false;
 break;
 }
 if ( placeX > ArrPlaceX[j] &&  placeX2 < ArrPlaceX2[j] || placeX < ArrPlaceX[j] &&  placeX2 > ArrPlaceX2[j])
 {
 accepted = false;
 break;
 }
 }
 
 // if the new platform is not on top of any previous platform, save it
 if (accepted)
 {
 ArrPlaceX2[counter] = placeX2;
 ArrPlaceY2[counter] = placeY2;
 ArrPlaceX[counter] = placeX;
 ArrPlaceY[counter] = placeY;
 }  
 
 counter++;
 }
 
 
 platformsDrawn = true;
 
 } 
 
 //draw the platforms
 for ( int i = 0; i < 7; ++i)
 {
 rectMode(CORNERS);
 fill(102);
 rect(ArrPlaceX[i], ArrPlaceY[i], ArrPlaceX2[i], ArrPlaceY2[i]);
 }
 }*/

//Name: collisionPlatform
//use: tests if the ball-shape collides with any of the platforms and if it does, it changes the balls direction
void collisionPlatform()
{
  for ( int i = 0; i < 10; ++i )
  {
    // test if the ball is about to go inside a platform
    if ( xpos >= ArrPlaceX[i] - rad && xpos <= ArrPlaceX2[i] + rad &&  ypos <= ArrPlaceY2[i] && ypos >= ArrPlaceY[i] - rad )
    {
      // test if the ball arrives top of the platfrom
      if ( ypos < ArrPlaceY[i] && ( abs(ArrPlaceY[i] - ypos) > abs(xpos - ArrPlaceX2[i]) || abs(ArrPlaceY[i] - ypos) > abs(ArrPlaceX[i] -xpos)) )
      {
        ydirection *= -1;
        continue;
      }

      if ( xpos <= ArrPlaceX[i] + rad || xpos >= ArrPlaceX2[i] - rad )//if it arrives from the sides
      {
        xdirection *= -1;
      }
    }
  }
}


