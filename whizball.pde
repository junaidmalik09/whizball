int rad = 30;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 0;  // Speed of the shape
float yspeed = 3;  // Speed of the shape

float yacceleration = 0; // Y Acceleration
float xacceleration = 0; // X Acceleration

float xdirection = 1;  // Left or Right
float ydirection = 1;  // Top to Bottom
PImage img1;
String userName = "";

/*** Game State Boolean Variables ****/
boolean gameStarted = false;
boolean userNameInput = false;

PFont font;
String time = "";     // time as a string
int t = 0;            //time as a numer
int interval = 20;    //the time for one level
int prestartTime = 0; // counts the time until the user name is given

float placeX2 = 0; //Ending X coordinate for a platform
float placeY2 = 0; //Ending Y coordinate for a platform
float placeX = 0;  //Starting X coordinate for a platform
float placeY = 0;  //Starting Y coordinate for a platform

float [] ArrPlaceX2 = new float[7]; // Array to store ending X coordinates 
float [] ArrPlaceY2 = new float[7]; // Array to store ending Y coordinates 
float [] ArrPlaceX = new float[7];  // Array to store starting X coordinates 
float [] ArrPlaceY = new float[7];  // Array to store starting Y coordinates 

boolean platformsDrawn; // True if platform arrays are full

void setup()   
{
  img1 = loadImage("1.jpg");
  size(800, 600);
  noStroke();
  frameRate(25);
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
  font = createFont("Arial", 30);
}

void draw() 
{
  
  if (!gameStarted) {
    // Show start up image
    image(img1, 0, 0);
  }
  
  else if (gameStarted && !userNameInput) {
    background(0);
    // Get user input 
    textSize(36);
    text("WHIZZBALL",300,40);
    
    
    textSize(28);
    text("Please write your name and hit enter to start playing. ", 30, 100);
    
    
    text(userName,300,150);
    fill(0,255,0);
    
  }
  
  else if (gameStarted && userNameInput) {
    
          background(255, 0, 0);
          timer();
          textSize(35);
          text(time, width/2, height/8);
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
          xpos = xpos + ( (xspeed) * (xdirection) );
          ypos = ypos + ( (yspeed) * (ydirection) );
      
        // Test to see if the shape exceeds the boundaries of the screen
        // If it does, reverse its direction by multiplying by -1
        if (xpos > width-rad || xpos < rad) {
          xdirection *= -1;
        } else {
          fill(255);
        }
        
        if (ypos > height-rad || ypos < rad) {
          ydirection *= -1;
        }
        
         //Test to see if the shape collides with a plaform
        collisionPlatform();
        
      
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
        text(userName,40,40);
        text("Acceleration: ",40,55);
        text(yacceleration,150,55);
        text("YSpeed: ",40,70);
        text(yspeed,150,70);
        text("XSpeed: ",40,85);
        text(xspeed,150,85);
  }
     
   

  
}

void keyPressed() {
  if (!gameStarted ) {
      gameStarted = true;
       
  } 
  
  else if (!userNameInput) {
     // Keep on taking user input until enter is pressed
     if (key != '\n') {
       userName = userName + key;
       prestartTime = millis();
     }
     
     else {
       userNameInput = true;
     }
  }
  
  else if (gameStarted && userNameInput) {
    if (key == CODED) {
      if (keyCode == UP) {
        yacceleration += 1;
      } else if (keyCode == DOWN) {
        yacceleration -= 1;
      } else if (keyCode == LEFT) {
        xspeed -= 1;
      } else if (keyCode == RIGHT) {
        xspeed += 1;
      }
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
}

//Name: collisionPlatform
//use: tests if the ball-shape collides with any of the platforms and if it does, it changes the balls direction
void collisionPlatform()
{
  for ( int i = 0; i < 7; ++i )
  {
    if ( xpos > ArrPlaceX[i] - rad && xpos < ArrPlaceX2[i] + rad &&  ypos - rad < ArrPlaceY2[i] && ypos + rad > ArrPlaceY[i] )
    {
      if( ypos < ArrPlaceY[i] || ypos > ArrPlaceY2[i] )// iff the ball arrives under or top of the platfrom
      {
        ydirection *= -1;
        continue;
      }
      
       else//if it arrives from the sides
      {
        xdirection *= -1;
      }
      
    }
    
  }  
  
}

//Name: timer
//use: counts dowm the time
void timer()
{
  t = interval-int((millis()-prestartTime)/1000);
  time = nf(t , 2);
  if(t == 0)
  {
    interval+=20;
  }
  // text(time, width/2, height/2);
}
