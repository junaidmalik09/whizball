void setup()   
{
  img1 = loadImage("1.jpg");
  ball = loadImage("ball_normal.png");
  ball_dead = loadImage("ball_dead.png");
  ball_happy = loadImage("ball_powerup.png");
  enemy = loadImage("enemy.png");
  keyImage = loadImage("key.png");
  size(800, 600);
  
  size(boardL, boardH);
  bg1 = loadImage("back1.jpg");
  bg2 = loadImage("back2.jpg");
  
  //frameRate(30);
  noStroke();
  ellipseMode(RADIUS);
  
  xpos = 50; // Set the starting position of the shape
  ypos = 50;
  xmov = 0;
  font = createFont("zorque.ttf",30);
  textFont(font, 32);
  img2 = loadImage("shield1.png");
  
  weaponImage = loadImage("weapon.png");
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
        killed = false;
        fill(255,33,15);
        textSize(70);
        text("THE GUARDS WON",200,70);
        textSize(20);
        image(ball_dead,200,100,rad*4,rad*4);
      }
      
      else {
        fill(255,33,15);
        textSize(70);
        text("GAME OVER!",200,70);
        textSize(20);
        image(ball_dead,200,100,rad*4,rad*4);
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
      text(totalpoints,640,120);
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
  
  // Game started but no username input
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
  
  else if (keyCollected && levelUp) {
    background(0);
    fill(255,33,15);
    textSize(70);
    text("LEVEL UP!",220,70);
    textSize(20);
    image(ball_happy,300,100,rad*4,rad*4);
    text("[ PRESS ENTER TO PROCEED ]", 300, 370);
  }
  
  else if (ballsFree) {
    background(0);
    fill(255,33,15);
    textSize(70);
    text("HE'S OUT!",220,70);
    textSize(20);
    image(ball_happy,300,100,rad*4,rad*4);
    text("[ PRESS ESC TO EXIT ]", 300, 370);
  }
  
  // Play started
  else if (gameStarted && userNameInput ) {
    
          image(bg1, xpos-(xpos*1.5), 0); // Show background image
          
          /* Display score and level */
          textSize(35);
          text("LEVEL "+levelCount,width/2-50,height/8);
          text(time, width/2-20, height/8+40);
          textSize(20);  
          text(userName + " points: " + totalpoints, 40, 50);
          text("lives " + lives, 40, 70 );
          if (weaponCollected) {
            text("WEAPON COLLECTED",40,90);
          }
          /* END - Display Score */
          
          
          
          
          /* TODO: yacceleration 
          if (yacceleration < 0) {
            if (yspeed > 0.1) {
              yspeed += yacceleration*0.1;    
            }
          }
          
          else if (yacceleration > 0) {
            if (yspeed < 100) {
              yspeed += yacceleration*0.1;    
            }
          }*/
         
          
      
        /* check if the ball collides with floor/ceiling */ 
        if (ypos > boardH-rad-depth || ypos < 15) {
           ydirection *= -1;
           checkHolesCollision();
        }
        
            
        ypos = ypos + ( (yspeed) * (ydirection) )+dY; // Update ypos
        checkBounds(); // Checks x bounds and update xpos
        checkPowerMode(); // Changes the image of the ball according to the power mode in effect 
        image(ball,xpos, ypos, rad, rad); // Draw ball at updated coordinates
        

        timer(); // Display timer
        platforms(); // Display platforms
        collisionPlatform(); // Check collision with platforms
        powerup(); // Display powerup collectibles
        nasties(); // Display nasties
        shoot(); // Shoot the suckers
        checkPointsAndLives(); // Update points and lives
        levelUpKey();
        if (levelCount==3 ) {
          showWeapons();
        } 
  }
  
  
}
