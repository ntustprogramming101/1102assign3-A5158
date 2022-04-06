final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
final int LIFE2=3,LIFE3=4,LIFE1=5,VEG1=6,VEG0=7,R=8,D=10,L=11,I=12;
int gameState=GAME_START;
int life=LIFE2;
int VEG=VEG1;
int move=I;

int soldierX,soldierY,robotX,robotY,vegX,vegY,b;
int goDown=0;

float groundhogX=320;
float groundhogY=80;
float t=0;

boolean right=false;
boolean down=false;
boolean left=false;
boolean up=false;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, over, startN, startH, restartN, restartH;
PImage bg, soil8x24,heart,sky,groundhog,groundhogR,groundhogL,groundhogD,veg,soldier;
PImage soil1,soil2,soil3,soil4,soil5,stone1,stone2;
// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
  frameRate(60);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	over = loadImage("img/gameover.jpg");
	startN = loadImage("img/startNormal.png");
	startH = loadImage("img/startHovered.png");
	restartN = loadImage("img/restartNormal.png");
	restartH = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil1=loadImage("img/soil1.png");
  soil2=loadImage("img/soil2.png");
  soil3=loadImage("img/soil3.png");
  soil4=loadImage("img/soil4.png");
  soil5=loadImage("img/soil5.png");
  stone1=loadImage("img/stone1.png");
  stone2=loadImage("img/stone2.png");
  groundhog=loadImage("img/groundhogIdle.png");
  groundhogR= loadImage("img/groundhogRight.png");
  groundhogL= loadImage("img/groundhogLeft.png");
  groundhogD= loadImage("img/groundhogDown.png");
  heart= loadImage("img/life.png");
  soldier=loadImage("img/soldier.png");
  veg= loadImage("img/cabbage.png");
  
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startH, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startN, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);
  
		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT-goDown, width, 160-goDown);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		image(soil8x24, 0, 160-goDown);
    for(int x=0;x<8;x++){
      for(int y=0;y<4;y++){
        image(soil1,x*80,480+y*80-goDown); 
        image(soil2,x*80,480+80*4+y*80-goDown);
        image(soil3,x*80,480+80*8+y*80-goDown);
        image(soil4,x*80,480+80*12+y*80-goDown);
        image(soil5,x*80,480+80*16+y*80-goDown);
      }
    }

    //stone
    for(int x=0;x<8*80;x+=80){
        image(stone1,x,160+x-goDown);      
    }
    for(int x=0;x<8;x++){
      for(int y=0;y<8;y++){
        if(y==0 || y==3 || y==4 ||y==7){
          if(x==0 || x==3 || x==4 || x==7){
          }else{image(stone1,x*80,160+80*8+y*80-goDown);}
        } 
        if(y==1 || y==2 || y==5 ||y==6){
          if(x==1 || x==2 || x==5 ||x==6){
          }else{image(stone1,x*80,160+80*8+y*80-goDown);}
        }
      }
    }
    for(int x=0;x<8;x++){
      for(int y=0;y<8;y++){
        if(x%3==0){if(y%3==1 || y%3==2)image(stone1,x*80,160+80*16+y*80-goDown);}
        if(x%3==1){if(y%3==0 || y%3==1)image(stone1,x*80,160+80*16+y*80-goDown);}
        if(x%3==2){if(y%3==0 || y%3==2)image(stone1,x*80,160+80*16+y*80-goDown);}    
        if(x%3==0){if(y%3==2)image(stone2,x*80,160+80*16+y*80-goDown);} 
        if(x%3==1){if(y%3==1)image(stone2,x*80,160+80*16+y*80-goDown);}
        if(x%3==2){if(y%3==0)image(stone2,x*80,160+80*16+y*80-goDown);}
      }
    }
    
		// Player
    if(t==0){
        if(right)move=R;
        else if(left)move=L;
        else if(down)move=D;
    }
    if(move==I){
      image(groundhog,groundhogX,groundhogY,80,80);
    }else{image(groundhog,1000,1000);}

    if(t==15){
      if(groundhogY%80<40){
        groundhogY=groundhogY-groundhogY%80;
      }else{
        groundhogY=groundhogY-(groundhogY%80)+80;
      }
      if(groundhogX%80<40){
        groundhogX=groundhogX-groundhogX%80;
      }else{
        groundhogX=groundhogX-(groundhogX%80)+80;
      }
      if(goDown%80<40){
        goDown=goDown-(goDown%80);
      }else{
        goDown=goDown-(goDown%80)+80;
      }
      if(goDown>=1521)goDown=1600;
      image(groundhog,groundhogX,groundhogY,80,80);
      move=I;
      t=0;
    }
    if(groundhogY+80>soldierY &&  groundhogY<soldierY+80){
      if(groundhogX-soldierX<80 && groundhogX-soldierX>0){
        t=0;
        move=I;               
      }
      if(groundhogX-soldierX>-80 && groundhogX-soldierX<0){   
        t=0;
        move=I;
      } 
    }
    switch (move){
      case R:
      if(groundhogX>=width-80){
        groundhogX+=0;
      }else{groundhogX +=80.0/15.0;}
      t++;
      image(groundhogR,groundhogX,groundhogY,80,80);
      break;
      
      case L:
      if(groundhogX<=0){groundhogX-=0;
      }else{groundhogX -=80.0/15.0;}
      t++;
      image(groundhogL,groundhogX,groundhogY,80,80);       
      break;
      
      case D:
      
      if(goDown>=1600){
        goDown+=0;
        groundhogY +=80/15.0;
      }else{
        goDown+=80.0/15.0;
      }
      t++;
      image(groundhogD,groundhogX,groundhogY,80,80); 
      
      break;
      
      case I:
      image(groundhog,groundhogX,groundhogY,80,80);
      break;
    }
    if(groundhogX>=width-80)groundhogX=width-80;
    if(groundhogX<=0)groundhogX=0;
    if(groundhogY>=height-80)groundhogY=height-80;
    
		// Health UI
    for(int i=0;i<=x+playerHealth;i++){
      image(heart,10+i*70,10,50,51);
      
    }
		break;

		case GAME_OVER: // Gameover Screen
		image(over, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartH, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartN, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > -2) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 3) playerHealth ++;
      break;
    }
      if(key==CODED){
      switch(keyCode){
      case RIGHT: right=true;break;
      case DOWN: down=true;break;
      case LEFT: left=true;break;
      case UP: up=true;break;
      }
  }
}

void keyReleased(){
  switch(keyCode){
      case RIGHT: right=false;break;
      case DOWN: down=false;break;
      case LEFT: left=false;break;
      case UP: up=false;break;
      }
}
