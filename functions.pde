// Name: nasties()
// Use: put random nasty images on screen
void nasties() {
  float prevX = 0;
  float prevY = 0;
  float curX = 0;
  float curY = 0;
  
  for (int i=0;i<levelCount;i++) {
    curX = 300 + i*100;
    curY = 100 + 1*100;
    if (nastiesX.size() < i+1) {
      while (abs(prevX-curX) < 100) {
        curX = random(50,900);
      }
     nastiesX.set(i,prevX); prevX = curX; 
    } 
    if (nastiesY.size() < i+1) {
      while (abs(prevY-curY) < 100) {
        curY = random(50,380);
      }
     nastiesY.set(i,prevY); prevY = curY;
     
    }
    fill(255,0,0);
    ellipse(nastiesX.get(i),nastiesY.get(i),25,25); // -(xpos*1.5) added to mimic parallax scrolling
    
    float dx = xpos - nastiesX.get(i); // -(xpos*1.5) added to mimic parallax scrolling
    float dy = ypos - nastiesY.get(i); 
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
        nastiesX.set(i,-100);
        nastiesY.set(i,100);
        powermode = 0;
        //defeated a guard, more points
        points += 5;    
        totalpoints += 5;   
      }
    }
    
    if(shot)
    {
       if(ybeam < nastiesY.get(i) +25 && ybeam > nastiesY.get(i) -25)
       {
         if(xbeam > nastiesX.get(i) +10)
         {
           
          nastiesX.set(i,-100);
          nastiesY.set(i,-100);
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
  
  else if (keyCollected && levelUp) {
    if (key == '\n') {
       if (levelCount<5) {
         levelUp = false;
         keyCollected = false;
         levelCount++;
         xpos = 0;
         ypos = 0;
         keyX = 900;
         keyY = 100;
         nastiesX = new FloatList();
         nastiesY = new FloatList();
         xpower1 = random(100,600);
         ypower1 = random(100,600);
         xpower2 = random(100,600);
         ypower2 = random(100,600);
         t += 5;
       }
       
    }
  }
    
    else if(gameStarted && userNameInput) {
    if (key == CODED) {
      if (keyCode == UP) {
        yspeed = 12;
        xspeed = 2;
      } else if (keyCode == DOWN) {
        yspeed =  7;
        xspeed = 0;
      } else if (keyCode == LEFT) {
        //xspeed -= 1;
        collision = collisionPlatform();
        if (!collision)
        {
          if (xmov > -100) { xmov = 0; xmov -= 10; }
          
        }
      } else if (keyCode == RIGHT) {
        collision = collisionPlatform();
        if (!collision)
        {
          if (xmov < 100) { xmov = 0; xmov += 10; }
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
     
     else if (key=='g' && weaponCollected) {
       destroyAllNasties();
       weaponCollected = false;
     }
    
  }
  
  
  
   if( gameEnded ) {
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
    while ( counter < AMOUNT )
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
     holeG = 200;
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
  if (!levelUp) { t = interval-int((millis()-prestartTime)/1000); }
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
 
  image(img2, xpower1, ypower1);
  image(img2, xpower2, ypower2);
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
    interval = 60;
    t = interval;
    prestartTime = 0;
    gameEnded = false;
    gameStarted= true;
    userNameInput =false;
    game++;
    totalpoints=0;
    points=0;
    lives=2;
    nastiesX = new FloatList();
    nastiesY = new FloatList();
    levelCount = 1;
    xspeed = 0;
    yspeed = 7;
    xpower1 = random(100,400);
    ypower1 = random(100,400);
    xpower2 = random(400,600);
    ypower2 = random(300,400);
    
     
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
  
  void checkPowerMode() {
    if (powermode == 1) {
      // Change ball image
      if (xmov < 0) {
        ball = loadImage("ball_powerup_flipped.png");
      }
            
      else if (xmov > 0) {
        ball = loadImage("ball_powerup.png");
      } 
    }
          
    else if (powermode == 0) {
      // Change ball image
      if (xmov < 0) {
        ball = loadImage("ball_normal_flipped.png");
      }
            
      else if (xmov > 0) {
        ball = loadImage("ball_normal.png");
      } 
    }
  }
  
  void checkBounds() {
    // If ball goes to extreme right
    // TODO: key thingy goes here
    if (xpos > boardL-50)
    {        
      if (keyCollected) {
        if (levelCount < 5) { levelUp = true; }
        else { ballsFree = true; }
      }
      
      if (xmov < 0) {
        xpos-= 5;
        xmov+= 2;
         
      }
      
      
    }
    
    // If ball goes to extreme left
    else if (xpos < 0) {
      if (xmov > 0) {
        xpos+= 5;
        println("xmov is "+xmov); 
        xmov-= 2;
      }
    }
    
    else {
      // Update x-position
      if (xmov > 0) {
        xpos+= 3+xspeed;
        xmov-= 2;
        
      } else if (xmov < 0) {
        xpos-= 3+xspeed;
        xmov+= 2;
      }
    }
    
  }
  
  
  void checkHolesCollision() {
    // if ball goes to the hole the game ends
    if((xpos > holeC && xpos <holeC+holeLenght && ypos < rad +depth )|| (xpos >holeG && xpos < holeG+holeLenght && ypos > height -rad -depth))
    {
              gameEnded = true;
              //ypos = ypos + ( (yspeed) * (ydirection) );
    }
    
    else
    {//if there is  collision, send the ball the other way
      ypos = ypos + ( (yspeed) * (ydirection) );
    }
  }
  
  void checkPointsAndLives() {
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
  
  void levelUpKey() {
    image(keyImage,keyX,keyY,rad/2,rad/2);
    
    float radius1 = rad/2;
    float x1 = xpos;
    float y1 = ypos;
    float radius2 = rad/4;
    float x2 = keyX;
    float y2 = keyY;
    float dx = x1 - x2;
    float dy = y1 - y2;
    double distance = Math.sqrt(dx * dx + dy * dy);
    
    if (distance < radius1 + radius2) {
        keyCollected = true;
        keyX = -1000;
    }
  }
  
  void showWeapons() {
    image(weaponImage,weaponX,weaponY,rad/2,rad/2);
    float radius1 = rad/2;
    float x1 = xpos;
    float y1 = ypos;
    float radius2 = rad/2;
    float x2 = boardL-keyX;
    float y2 = boardH-keyY;
    float dx = x1 - x2;
    float dy = y1 - y2;
    double distance = Math.sqrt(dx * dx + dy * dy);
    
    if (distance < radius1 + radius2) {
        weaponCollected = true;
        weaponX = -100;
        weaponY = -100;
    }
  }


  void destroyAllNasties() {
    int sizeNasty = nastiesX.size();
    for (int i=0;i<sizeNasty;i++) {
      nastiesX.set(i,-100);
    }
  }
