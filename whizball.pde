int rad = 50;        // Width of the shape
float xpos, ypos;    // Starting position of shape  

float xmov; // Smoothing the transitions

// Power Ups //

float xpower1 = 200;
float ypower1 = 100;
float xpower2 = 400;
float ypower2 = 100;
float nxpower1 = 0;
float nypower1 = 0;
float nxpower2 = 0;
float nypower2 = 0;
float radpower = 20;
color c1 = #daa520;
color c2 = #ffff00;
color c3 = #ee8262;
int powermode=0;


// ---------- //

float xspeed = 0;  // Speed of the shape
float yspeed = 9;  // Speed of the shape

float yacceleration = 0; // Y Acceleration
float xacceleration = 0; // X Acceleration

float xdirection = 1;  // Left or Right
float ydirection = 1;  // Top to Bottom
PImage img1;
PImage img2;
PImage img3;
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

int AMOUNT = 7;
float [] ArrPlaceX2 = new float[AMOUNT]; // Array to store ending X coordinates 
float [] ArrPlaceY2 = new float[AMOUNT]; // Array to store ending Y coordinates 
float [] ArrPlaceX = new float[AMOUNT];  // Array to store starting X coordinates 
float [] ArrPlaceY = new float[AMOUNT];  // Array to store starting Y coordinates 

boolean platformsDrawn; // True if platform arrays are full

float dY = 2;
int boardL=1000;
int boardH=400;
PImage bg1;
PImage bg2;
String endText = "Congratulation You are now in Level 2";
int score;
PImage ball;
PImage ball_dead;
PImage ball_happy;
int rect1=40;
int rect2=60;
int rposx=100;
int rposy=100;
PImage enemy;


boolean gameEnded = false;
boolean floorDone = false;
boolean killed = false;

// depth of the ground and ceiling
float depth = 10;
// size of the hole
float holeLenght = 100;

// places of holes in ceiling and ground
float holeC = 0;
float holeG = 0;


//scoreboard
String [] players = new String[20];
int [] scoreboard = new int[20];



boolean lostLife= false;
int lives = 2;
int points = 0;//points shown on the screen during the game, and used for incrementing lives
int totalpoints = 0; //total points
int game = 0;
int line = 0;

float[] nastiesX = {0,0,0,0,0,0};
float[] nastiesY = {0,0,0,0,0,0};

boolean shot = false;
boolean charged = false;
float bar = 0;
float xbeam = 0;
float ybeam = 0;



void setup()   
{
  img1 = loadImage("1.jpg");
  ball = loadImage("ball_normal.png");
  ball_dead = loadImage("ball_dead.png");
  ball_happy = loadImage("ball_powerup.png");
  enemy = loadImage("enemy.png");
  size(800, 600);
  
  size(boardL, boardH);
  bg1 = loadImage("back1.jpg");
  bg2 = loadImage("back2.jpg");
  
  frameRate(30);
  noStroke();
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = 50;
  ypos = 50;
  xmov = 0;
  font = createFont("zorque.ttf",30);
  textFont(font, 32);
  img2 = loadImage("shield1.png");
}

void draw() 
{
  
  if (!gameStarted && firstStart) {
        background(0);
        // Show background story
        
        textSize(50);
        fill(252,237,67);
        text("BREAKOUT BALL", 300, 60);
        
        image(ball,50,75,rad*3,rad*3);
        image(ball_happy,800,75,rad*3,rad*3);
        
        fill(190,130,50);
        textSize(20);
        textAlign(CENTER);
        String s = "The ball was wrongly convicted to jail and now it wants revenge. It is now on a runaway to get out of the prison grounds. There are many prison walls and guards on the way. But the further away the ball runs the more difficult it gets..."; 
        text(s,250,90,500,500);
        
        //text("It has to run faster and get away from more guards.", 30, 250);
        //text("Luckily there are weapons to collect on the way to make the escape easier.", 30, 290);
        fill(255,33,15);
        textSize(45);
        textAlign(LEFT);
        text("Help the ball to get out!", 180, 330);
        firstStart = false;
  }
  
  else if(gameEnded)
  {
  
  
      background(0,0,0);
      // Get user input 
      
      
      if (killed) {
        fill(255,33,15);
        textSize(70);
        text("THE GUARDS WON",200,70);
        textSize(20);
        image(ball_dead,200,100,rad*4,rad*4);
      }
      
      else {
        fill(255,33,15);
        textSize(90);
        text("GAME OVER",70,50);
        textSize(20);
        image(ball_dead,200,150,rad*4,rad*4);
      }
      
      fill(190,130,50);
      textSize(30);
      textAlign(LEFT);
      text("[ PRESS ENTER TO TRY AGAIN ]", 300, 370);
      
      //scoreboard
      if(game < 19)
      {
        players[game] = userName;
        scoreboard[game] = totalpoints;;
      }
      
      textSize(25);
      text("You Scored ",475,120);
      text(points,640,120);
      text("points",670,120);
      //text("Scoreboard", 475, 140);
      
      int n=0;
     
      while(n <= game && n<20)
      {
        line=line+20;
        textSize(20);
        text(players[n],475,140+line);
        text(scoreboard[n], 600,140+line);
        n++;
       
      }
      
      
      points = 0;
      line=0;
      
      
      
      
  }
  // TODO: why is this here??
  else if (!gameStarted ) {
    // Show start up image
    
  }
  
  else if (gameStarted && !userNameInput) {
    background(0);
    textSize(50);
    fill(252,237,67);
    text("BREAKOUT BALL", 300, 60);
    
    // Get user input 
    textSize(24);
    fill(190,130,50);
    text("Please write your name and hit enter to get moving ! ", 160, 120);
    
    //rect(370,155,250,30);
    fill(255,33,15);
    
    textAlign(CENTER);
    fill(255,255,255);
    text(userName,495,180);
    textAlign(LEFT);
    fill(0,255,0);
    
    image(ball,420,220,rad*3,rad*3);
    
  }
  
  else if (gameStarted && userNameInput ) {
    
          if (powermode == 1) {
            ball = loadImage("ball_powerup.png");
          }
          
          else if (powermode == 0) {
            ball = loadImage("ball_normal.png");
          }
          background(255, 255, 255);
          
          image(bg1, xpos-(xpos*1.5), 0);
          //image(enemy,0,0,30,30);
          //rect(rect1, rect2, rposx, rposy);
          
          score = frameCount;
          
          if (xpos > boardL)
          {        
           background(0, 0, 0);
           noLoop();
           text(endText,boardL/2,boardH/2);
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
          textSize(20);  
          text(userName + " points: " + totalpoints, 40, 50);
          text("lives " + lives, 40, 70 );
          platforms();
          
          if (yacceleration < 0) {
            if (yspeed > 0.1) {
              yspeed += yacceleration*0.1;    
            }
          }
          
          else if (yacceleration > 0) {
            if (yspeed < 100) {
              yspeed += yacceleration*0.1;    
            }
          }
          
      
          // Update the position of the shape
          //xpos = xpos + ( (xspeed) * (xdirection) );
          ypos = ypos + ( (yspeed) * (ydirection) );
      
      //check if the ball collides with floor/ceiling. 
       if (ypos > height-rad-depth || ypos < rad+depth)
       {
          ydirection *= -1;
          
           // if ball goes to the hole the game ends
      if((xpos > holeC && xpos <holeC+holeLenght && ypos < rad +depth )|| (xpos >holeG && xpos < holeG+holeLenght && ypos > height -rad -depth))
          {
            gameEnded = true;
          }  
          
          else
         {//if there is  collision, send the ball the other way
           ypos = ypos + ( (yspeed) * (ydirection) );
         }
      }
            
      
      
        // Test to see if the shape exceeds the boundaries of the screen
        // If it does, reverse its direction by multiplying by -1
        if (xpos > width-rad || xpos < rad) {
          xdirection *= -1;
        
          
          
        } 
    
        
        else {
          fill(255);
        }
        
        collisionPlatform();
      
        if (xmov > 0) {
          xpos+= 3;
          xmov--;
        } else if (xmov < 0) {
          xpos-= 3;
          xmov++;
        }
          
        stroke(0);
        image(ball,xpos, ypos, rad, rad); 
        
          
        
        
        image(img2, xpower1, ypower1);
        image(img2, xpower2, ypower2);
        
        textSize(12);
        text(userName,40,40);
        
        //---  Debug Info ---//
        text("Acceleration: ",40,55);
        text(yacceleration,150,55);
        text("xmov: ",40,70);
        text(xmov,150,70);
        // ------------- //
        
        if (ypos > boardH) {
          dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
        }
        if (ypos < 0) 
        {
          dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
        }
      
        
        
        
        powerup();
        powermove();  
        nasties();
        shoot();
        
        if (points >= 15)
        {
           lives += 1;
           points = 0; 
        }

        
        if (lives < 1)
        {
          gameEnded = true;
        }
        
  }
     

  
}

// Name: nasties()
// Use: put random nasty images on screen
void nasties() {
  float prevX = 0;
  float prevY = 0;
  float curX = 0;
  float curY = 0;
  
  for (int i=0;i<4;i++) {
    curX = 300 + i*100;
    curY = 100 + 1*100;
    if (nastiesX[i] == 0) {
      while (abs(prevX-curX) < 100) {
        curX = random(10,700);
      }
     nastiesX[i] = prevX = curX; 
    } 
    if (nastiesY[i] == 0) {
      while (abs(prevY-curY) < 100) {
        curY = random(10,500);
      }
     nastiesY[i] = prevY = curY;
     
    }
    fill(255,0,0);
    ellipse(nastiesX[i],nastiesY[i],25,25); // -(xpos*1.5) added to mimic parallax scrolling
    
    float dx = xpos - nastiesX[i]; // -(xpos*1.5) added to mimic parallax scrolling
    float dy = ypos - nastiesY[i]; 
    float distance = (float)Math.sqrt(dx * dx + dy * dy);
    
    
    if (powermode == 0) {
      //println(distance-rad);
      if (distance < rad + 25) {
        // collision detected!
        fill(255,0,0);
        int time = millis();
        
        
        //gameEnded = true;
        killed = true;
        if (lives >= 1)
        {
          lives -= 1;
          powermode = 1;
        }
        else
        {
          gameEnded = true;
        }    
      }
    }
    
    else if (powermode == 1) {
      if (distance < rad + 25) {
        // collision detected!
        println(i);
        fill(255,0,0);
        nastiesX[i] = -100;
        nastiesY[i] = -100;
        powermode = 0;
        //defeated a guard, more points
        points += 5;    
        totalpoints += 5;   
      }
    }
    
    if(shot)
    {
       if(ybeam < nastiesY[i] +25 && ybeam > nastiesY[i] -25)
       {
         if(xbeam > nastiesX[i] +10)
         {
           
          nastiesX[i] = -100;
          nastiesY[i] = -100;
          points += 100;
          totalpoints += 100;
         } 
       } 
    }

    
  }
  
  
  
  
}


void keyPressed() {
  boolean collision = false;
  if (!gameStarted  ) {
      gameStarted = true;
       
  } 
  
  else if (!userNameInput  ) {
     // Keep on taking user input until enter is pressed
     if (userName.length() < 25 && key!= CODED && key != BACKSPACE && key != '\n'){
        userName += key;
     }
     else if(key == BACKSPACE && userName.length() > 0){
        userName = userName.substring (0,userName.length()-1);
     }
     
     else if (key == '\n') {
       userNameInput = true;
       prestartTime = millis();
     }
     
     
  }
  
  else if (gameStarted && userNameInput) {
    if (key == CODED) {
      if (keyCode == UP) {
        //yacceleration += 3;
      } else if (keyCode == DOWN) {
        //yacceleration -= 3;
      } else if (keyCode == LEFT) {
        //xspeed -= 1;
        collision = collisionPlatform();
        if (!collision)
        {
          if (xmov > -100) { xmov -= 10; }
        }
      } else if (keyCode == RIGHT) {
        collision = collisionPlatform();
        if (!collision)
        {
          if (xmov < 100) { xmov += 10; }
        }
      }
    }
    
    // Shooting : jarkko
    else if(key==' '){
        if(charged)
        {
          shot = true;
          charged = false;
          bar = 0;
        }
     }
    
  }
  
  
  
   if( gameEnded )
  {
    if (key == '\n') {
      
      reset();
   
    }
  }
}

//Name: platforms
//use: for creating and drawing the platforms
void platforms()
{
  //boolean accepted = false;
 
  if (!platformsDrawn)
  {  
    int counter = 0;
    
    //new platforms are created on fixed places, their size is randomized. 
    //
    while ( counter > AMOUNT )
    {
    //  accepted = false; // true if plaforms are not on top of each other
      placeX = 100+(counter*100); 
      placeY = random(200, 500 );//300+(counter*20);
      placeX2 = random(placeX + 10, placeX + 55);
      placeY2 = 600;
   
         /*for ( int j = 0; j < counter; ++j )
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
         }*/
            //accepted = true;
            // if the new platform is not on top of any previous platform, save it
          //if (accepted)
           //{
            ArrPlaceX2[counter] = placeX2;
            ArrPlaceY2[counter] = placeY2;
            ArrPlaceX[counter] = placeX;
            ArrPlaceY[counter] = placeY;
           //}  
        
           counter++;
        }
    
    
     platformsDrawn = true;
    
    } 
    
    // draw the floor and the ceiling
  if(!floorDone)
    {
     holeC = 700;
    
     holeG = 600;
     floorDone = true;
    }
    rectMode(0);
    fill(102);
    //ceiling
    rect(0,0,holeC,depth);
    rect(holeC+holeLenght,0,boardL,depth);
    
    // floor
    rect(0, boardH,holeG, -depth);
    rect(holeG+holeLenght,boardH,boardL, -depth);
   
   //draw the platforms
    for ( int i = 0; i < AMOUNT; ++i)
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
  time = nf(t , 2);

if(t < 5)
{
 textSize(50);
 text( "HURRY UP!! ", width/4, height/4); 
 
 text( "Time is runnig out!", width/4, height/3);
}
if(t == 0)
{
  
  gameEnded= true;
  
}
// text(time, width/2, height/2);
}


//checks that the ball does not go on top of a platform. Changes the ball's direction, when it hits a platform
boolean collisionPlatform()
{
  boolean collision = false;
  for ( int i = 0; i < AMOUNT; ++i )
  {
    // test if the ball is about to go inside a platform
    if ( xpos >= ArrPlaceX[i] - rad && xpos <= ArrPlaceX2[i] + rad &&  ypos <= ArrPlaceY2[i] && ypos >= ArrPlaceY[i] - rad )
    {
      collision = true;
      // test if the ball arrives top of the platfrom
      if ( ypos < ArrPlaceY[i] && ( abs(ArrPlaceY[i] - ypos) > abs(xpos - ArrPlaceX2[i]) || abs(ArrPlaceY[i] - ypos) > abs(ArrPlaceX[i] -xpos)) && ydirection == 1 )
      {
        ydirection *= -1;
        continue;
      }

      if ( xpos < ArrPlaceX[i] || xpos > ArrPlaceX2[i])//if it arrives from the sides
      {
        xdirection *= -1;
      }
    }
  }
  return collision;
}


void powerup()
{  
  
  if((abs(xpos-xpower1)<=30) &&(abs(ypos-ypower1)<=30))
  {
      
      println("collision detected");
      print(xpos); print("--"); print(xpower1);
      xpower1=2000;      
      c1=c2;
      //rad=35;
      powermode=1;
      //the ball hit the powerup, more points
      points += 5;      
      totalpoints += 5; 
      
      
      
  }
  if((abs(xpos-xpower2) <=30)&&(abs(ypos-ypower2)<=30))
  {
        
      fill(255,0,0);
      xpower2=2000;      
      c1=c2;
      //rad=35;          
      powermode=1;
      //the ball hit the powerup, more points
      points += 5;      
      totalpoints += 5;
          
    
  }
}
  
  void powermove()
{    
  xpower1 = xpower1;
  ypower2 = ypower2;
    
    
  }
  
  // Function : reset()
  // Reset the game parameters after the game is finished
  void reset() {
    userName = "";
    xpos = 50;
    ypos = 50;
    ydirection = 1;
    xmov = 0;
    time = "";
    interval = 20;
    t = interval;
    prestartTime = 0;
    gameEnded = false;
    gameStarted= true;
    userNameInput =false;
    game++;
    totalpoints=0;
    points=0;
     
  }
  
  // Function: shoot()
  // Shoot the laser and stuff...
  void shoot()
  {
    
      rectMode(0);
      fill(245);
      
      rect(xpos -20,ypos+40,bar,5);
      if( bar < 50)
      {
        bar  = bar + 1;
      }
      else
      {
        charged =true;
      }
  
      
      
      if(!shot)
      {
        xbeam = xpos;
        ybeam = ypos;
   
      }
      else if(shot)
      {
   
        xbeam = xbeam + 50;
      
        rectMode(0);
        //fill(c2);
        rect(xbeam,ybeam,90,3); 
   
      
      
      if(xbeam > width)
      {
        shot =false;
        xbeam = xpos;
      }
   
    }
  }
  
