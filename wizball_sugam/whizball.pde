
float ballX = 0;
float ballY = 0;

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

void setup() 
  {
  
    size(boardL, boardH);
    bg1 = loadImage("back1.jpg");
    bg2 = loadImage("back2.jpg");
    ball = loadImage("boy.png");
    frameRate(30);
  }
     
void draw() 
  {
    background(255, 255, 255);
    image(bg1, ballX-(ballX*1.5), 0);
    image(bg2, ballX-(ballX*1.1), 340);
    image(ball, ballX, ballY);
    rect(rect1, rect2, rposx, rposy);
    
    score = frameCount;
     
     if (ballX > boardL)
      {        
       background(0, 0, 0);
       noLoop();
       text(endText,boardL/2,boardH/2);
       text("You played: ", 50, 30);
       text(score, 50, 50);
       
     
      }
   
    ballY = ballY+dY;
     if (ballY > boardH-(120)) {
    dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
     }
  if (ballY < 0) 
    {
    dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
     }    
    
    if (key == CODED) {
    if (keyCode == LEFT) 
    {
      ballX= ballX-2;
      ballX= ballX;
    } 
    else if (keyCode == RIGHT) 
    {              
       ballX= ballX+2;
       ballX= ballX;
    } 
     else if (ballY < 0 && keyCode == UP) 
    {
      ballY= ballY+2;
      ballY= ballY;
      
    } 
    else if (ballY > 0 &&keyCode == DOWN) 
    {
       ballY= ballY-2;
       ballY= ballY;
       
    } 
       
  
  else 
  {
    
  }
  ballY = ballY+dY;
     if (ballY > boardH) {
    dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
     }
  if (ballY < 0) 
    {
    dY = -dY; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
     }
    
  }
  


  
  }

