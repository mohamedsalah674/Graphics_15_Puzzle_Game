/*********************************************************************************************************************************
*****************************       Global Variables          ********************************************************************
*********************************************************************************************************************************/
int[][] puzzle;             //puzzel order at the game
int[][] solution;           //solution of puzzel
boolean[][] correct;        //correct array to check if solution spot = puzzel spot 
color[][] borderColor;      //color of squares border
int X_Start_Pos;                  //to edit the place of the game grid if 3x3(60) or 4x4(0)
int rows;                   //number of rows in 3x3 or 4x4 puzzel
int loop;                   //number of squares in a row or a column in 3x3 or 4x4 puzzel
int emptyRow;               //row of empty spot (o place in puzzel)
int emptyColumn;            //column of empty spot (o place in puzzel)
int sqsize    = 100;        //game square size
     
int strokew   = 2;          //border size
PFont font;                 //variable in which we load the font we use in game
int fontsize  = sqsize*3/5; //size of font
int timefont  = 40;         //font size of time
int movesFont = timefont/2; //font size of Moves

int gamestate = 0;          // 0 for start game when everything is orderd   ---  1 when you press the (S) button ---- 2 when you start playing the game
int timer     = 0;          // time before moving any square
int starttime = 0;          // time before moving any square
int moves     = 0;          // Moves before moving any square
int play      = 0;          //0 if you didn't choose type of the game in main menue ---1 >>>3*3  ---  2>>>>4*4
int reset     = 0;          // flag reset the game

// buttons in main menue which are classess
Button btn1;                // 3*3 game      
Button1 btn2;               // 4*4 game
int buttonClicked = 0;          // check if you press button to inialise 3*3 game or 4*4 game     
int win           = 0;          // flag for win page becomes 1 when you win


//***************** 3x3 Puzzle *****************************\\

int[][] puzzle_3x3 = {                    //3x3 puzzel order at first of game 
    {1,2,3}, 
    {4,5,6},
    {7,8,0}};

int[][] solution_3x3 = {                  //3x3 solution order 
    {1,2,3},
    {4,5,6},
    {7,8,0}};

boolean[][] correct_3x3 = {{true,true,true},{true,true,true},{true,true,true}};   //3x3 correct value at first of game (if puzzel spot = solution spot)

color[][] borderColor_3x3= {              // border color
    {#554628,#554628,#554628},
    {#554628,#554628,#554628},
    {#554628,#554628,#554628}};

int loop_3x3  =3;
int X_Start_Pos_3x3 =60;
int rows_3x3  =3;

//***************** 4x4 Puzzle *****************************\\

int[][] puzzle_4x4 = {                       //4x4 puzzel order at first of game 
    {1,2,3,4},
    {5,6,7,8},
    {9,10,11,12},
    {13,14,15,0}};

int[][] solution_4x4 = {                     //4x4 solution order 
    {1,2,3,4},
    {5,6,7,8},
    {9,10,11,12},
    {13,14,15,0}};

boolean[][] correct_4x4 = {{true,true,true,true},{true,true,true,true},{true,true,true,true},{true,true,true,true}};   //4x4 correct value at first of game (if puzzel spot = solution spot)

color[][] borderColor_4x4= {                 // border color
    {#554628,#554628,#554628,#554628},
    {#554628,#554628,#554628,#554628},
    {#554628,#554628,#554628,#554628},
    {#554628,#554628,#554628,#554628}};

int loop_4x4  =4;
int X_Start_Pos_4x4 =0;
int rows_4x4  =4;


/*******************   Image    ***********************/

PImage img; // load image in start page

/******************************************************/

/*******************   Sound    ***********************/

import processing.sound.*; // for the sound 

SoundFile press;  // variable of press sound 
SoundFile winner; //variable of winning sound

String press_sound = "Mouse_Click.mp3";
String press_path;

String winner_sound = "win.mp3";
String winner_path;
/*******************************************************/


/*********************************************************************************************************************************
*****************************            setup                ********************************************************************
*********************************************************************************************************************************/
void setup(){
  size(500,500);

  img = loadImage("bg1.png");

  press_path = sketchPath(press_sound);     // for adding the sound path
  press = new SoundFile(this, press_path); // for adding the sound file

  winner_path = sketchPath(winner_sound);
  winner = new SoundFile(this, winner_path);


  font = loadFont("Bahnschrift.vlw");
  surface.setTitle("Puzzel Game");

  btn1 = new Button( 100, 300, 300, 50, "Level 1" );
  btn2 = new Button1(100, 370, 300, 50, "Level 2" );
}

/*********************************************************************************************************************************
*****************************            draw                 ********************************************************************
*********************************************************************************************************************************/
void draw(){
  
  if(win==1){                        //if winning 
    win=0;                           //reset win flag
    play=0;                          //reset play flag
    winner.play();                   //play winning sound
    delay(2500);                     //delay for 2.5sec
  }

  if (play==0){                      //display start page if no button was selected
    selected  = true;
    selected1 = true;
    background(#86705B);
    image(img, 120, 20);             //show image at start page

    textSize(30);                    //text size written on each button at start page
    btn1.display_3x3();              //have the 3x3_button instance to call it's display( ) method
    btn2.display_4x4();              //have the 4x4_button instance to call it's display( ) method  
        
    textFont(font,25);    //instructions' font and font size
    fill(#E8DDCE);
    text("Press (s) to start and shuffle the puzzel ",250,440);
    text("Press (r) to reset and reorder the puzzel ",250,470);

  }

  else{

    switch(buttonClicked){           //buttonClicked changes when pressing any button in Clicked function in class button -- 1. 3x3 -- 2. 4x4
    case 1:    
      puzzle = puzzle_3x3; 
      solution = solution_3x3;
      correct=correct_3x3;
      borderColor= borderColor_3x3;
      X_Start_Pos=X_Start_Pos_3x3;
      rows=rows_3x3;
      loop=loop_3x3;
      break;

    case 2:    
      puzzle = puzzle_4x4; 
      solution = solution_4x4;
      correct=correct_4x4;
      borderColor= borderColor_4x4;
      X_Start_Pos=X_Start_Pos_4x4;
      rows=rows_4x4;
      loop=loop_4x4;
      break;
    }



    if (play==1 || play ==2){   //game mode

      startGame();
    }
  }}



/*********************************************************************************************************************************
*****************************            Functions            ********************************************************************
*********************************************************************************************************************************/


/*******************************************************************************
 * [Function Name] : startGame
 *
 * [Description]   : A function to draw the puzzel (3x3 or 4x4)
 *
 * [Args in]       : NONE
 * [Args out]      : NONE
 *******************************************************************************/
void startGame(){
    selected  = false;
    selected1 = false;
  translate(width/2,height/2);            //move the orgin of the game in the middle of secreen

  background(#E3B65C);                    //yellow backdround when game starts
  strokeWeight(strokew);                  //applying border weights
  textAlign(CENTER,CENTER);               // horizontal and vertical center of numbers in squares
  textFont(font,fontsize);                //number's font and font size  
  for (int row = 0; row < loop; row++){   // draw the shape of the game
    for (int column = 0; column < loop; column++){
      if (puzzle[row][column] == 0){ }    // not to draw this square(empty place  (0 spot))

      else {
        // used to draw colors of squares and borders on screen           
        stroke(borderColor[row][column]); //to draw borders.

        int currx = column*sqsize+(-2*sqsize);    // x position of each square
        int curry = row*sqsize+(-2*sqsize);       // y position of each square
        fill(#9E97A7);                  // square color
        rect(currx+(strokew) + X_Start_Pos,curry+(strokew),sqsize-2*strokew,sqsize-2*strokew);  // drawing squares
        fill(255);                                                                   //X_Start_Pos to edit the place of the game grid if 3x3(60) or 4x4(0)
        textAlign(CENTER,CENTER);               // horizontal and vertical center of numbers in squares

        text(str(puzzle[row][column]),currx+sqsize/2+X_Start_Pos,curry+sqsize/2);   // drawing  numbers as a string  inside squares
      }
    }
  }
  if (gamestate == 2){                  // start timer when starting to play (game state changes to 2 when pressing any arrow to move any square)
    timer = millis()-starttime;
  }


//*************   drawing the strings shown in the game -->> time,moves    ******************/

  fill(255);                  //Time & Moves color
  textAlign(LEFT,BOTTOM);     //align of time
  textFont(font,timefont);    //time's font and font size
  
  if(play==1){       // position of time in 3x3 mode
    text(str(timer/1000)+"."+nf(timer%1000,3),-140,-sqsize*2);          // nf() is used for formatting numbers into strings --- nf() is used to add zeros to the left and/or right of a number like 0.000
  }// time is in milli seconds so we must divide by 1000                //text(str,position)
  
  else if(play==2){  // position of time in 4x4 mode
    text(str(timer/1000)+"."+nf(timer%1000,3),-sqsize*2,-sqsize*2);   // nf() is used for formatting numbers into strings --- nf() is used to add zeros to the left and/or right of a number like 0.000
  }// time is in milli seconds so we must divide by 1000                //text(str,position)

  textAlign(RIGHT,BOTTOM);    //align of Moves    
  textFont(font,movesFont);   //Moves' font and font size

  if(play==1){       // position of move in 3x3 mode
    text("MOVES: " + str(moves),160,-207);
  }
  else if(play==2){  // position of move in 4x4 mode
    text("MOVES: " + str(moves) ,sqsize*2,-sqsize*2);
  }
  
  if(play==1){       // position of move in 3x3 mode
    text("Use arrows to play",-20,230);
  }
  else if(play==2){       // position of move in 3x3 mode
    text("Use arrows to play",-20,230);
  }
/**********************************************************************************************/

  if(reset==0){       //reset game at first or after a win       
    resetFunc();
  }
}


/*******************************************************************************
 * [Function Name] : keyPressed
 *
 * [Description]   : A function to move squares in the empty spot when pressing any arrow
 *
 * [Args in]       : NONE
 * [Args out]      : NONE
 *******************************************************************************/
void keyPressed(){
  reset++;
  if (keyCode == RIGHT && emptyColumn != 0){                 //in each case of these we put a constraints of case that no squares will move
    press.play();

    puzzle[emptyRow][emptyColumn] = puzzle[emptyRow][emptyColumn-1];          //move the number to the empty place
    puzzle[emptyRow][emptyColumn-1] = 0;                                      //move the empty place to the place of the number
    correct[emptyRow][emptyColumn] = (puzzle[emptyRow][emptyColumn]==solution[emptyRow][emptyColumn]);   // check if the number is in the correct place or not
    emptyColumn--;             //the new empty place
    if (gamestate == 1){      // the game state is inotialised to 0 but when you press (S) it becomes 1
      gamestate = 2;
      starttime = millis();
      moves++;
    } else if (gamestate == 2){
      moves++;
    }
  }
  else if (keyCode == LEFT && emptyColumn != rows -1){                 // this code is same as above
    press.play();

    puzzle[emptyRow][emptyColumn] = puzzle[emptyRow][emptyColumn+1];   //emptyRow: empty row
    puzzle[emptyRow][emptyColumn+1] = 0;
    correct[emptyRow][emptyColumn] = (puzzle[emptyRow][emptyColumn]==solution[emptyRow][emptyColumn]);
    emptyColumn++;
    if (gamestate == 1){           //at the first move of the game
      gamestate = 2;
      starttime = millis();
      moves++;
    } else if (gamestate == 2){   //any other move would only increase number of moves
      moves++;
    }
  }
  else if (keyCode == DOWN && emptyRow != 0){                         // this code is same as above
    press.play();

    puzzle[emptyRow][emptyColumn] = puzzle[emptyRow-1][emptyColumn];
    puzzle[emptyRow-1][emptyColumn] = 0;
    correct[emptyRow][emptyColumn] = (puzzle[emptyRow][emptyColumn]==solution[emptyRow][emptyColumn]);
    emptyRow--;
    if (gamestate == 1){
      gamestate = 2;
      starttime = millis();
      moves++;
    } else if (gamestate == 2){
      moves++;
    }
  }
  else if (keyCode == UP && emptyRow != rows -1 ){                    // this code is same as above
    press.play();

    puzzle[emptyRow][emptyColumn] = puzzle[emptyRow+1][emptyColumn];
    puzzle[emptyRow+1][emptyColumn] = 0;
    correct[emptyRow][emptyColumn] = (puzzle[emptyRow][emptyColumn]==solution[emptyRow][emptyColumn]);
    emptyRow++;
    if (gamestate == 1){
      gamestate = 2;
      starttime = millis();
      moves++;
    } else if (gamestate == 2){
      moves++;
    }
  }
  else if (key == 'r') {                     // reset the game by setting the default number of ever variable
    press.play();

    moves = 0;
    gamestate = 0;
    emptyRow = rows-1;
    emptyColumn = rows-1;
    for (int i = 0; i<loop; i++){
      for (int j = 0; j<loop; j++){
        correct[i][j] = true;
        puzzle[i][j] = solution[i][j];
      }
    }
    timer = 0;
  }
  else if (key == 's'){                     // used to start playing the game and set numbers randomly
    press.play();

    shufflePuzzel(puzzle);                   // switching numbers in squares randomly
    moves = 0;
    gamestate = 1;
    timer = 0;
  }
  boolean complete = true;   // check if you completed the game or not
  
  for (int i = 0; i<loop; i++){
    for (int j = 0; j<loop; j++){
      if (!(i==loop-1 && j == loop-1)){
        if (!correct[i][j]){
          complete = false;
          break;
        }
      }
    }
  }
  
  if (complete && gamestate == 2){       // check the game if it is completed or not when you are playing
    gamestate = 0;
    timer = millis()-starttime;          // set time for the current time and stop it 
    win=1;

    //reset everything
    reset=0;
    winning_page();

  }
}


/*******************************************************************************
 * [Function Name] : calculateSolved
 *
 * [Description]   : A function to check if puzzel is solved or not and each spot at puzzel array 
 *                   is the same as each spot at the solution array
 *
 * [Args in]       : NONE
 * [Args out]      : NONE
 *******************************************************************************/
void calculateSolved(){                                     // check  all the array to see if the order is correct or not 
  for (int i = 0; i < loop; i++){
    for (int j = 0; j < loop; j++){
      correct[i][j] = (puzzle[i][j] == solution[i][j]);     // checks the array and returns true or false
      if (puzzle[i][j] == 0){                               //to know the place of the empty square
        emptyColumn = j;
        emptyRow = i;
      }
    }
  }
}


/*******************************************************************************
 * [Function Name] : shufflePuzzel
 *
 * [Description]   : A function to shuffle puzzel array randomly when pressing (s)
 *
 * [Args in]       : int[][] a
 * [Args out]      : NONE
 *******************************************************************************/
void shufflePuzzel(int[][] a) {                  
  int nbrCols = a.length;
  int nbrRows = a[0].length;
  for (int c = 0; c < nbrCols; c++) {             //  fill the array with new random values
    for (int r = 0; r < nbrRows; r++) {
      int nc = (int)random(nbrCols);              // returns value between 0 and nbrCols  (less then nbrCols)
      int nr = (int)random(nbrRows);              // returns value between 0 and nbrRows     (less then nbRows)


      // we choose the index randomly beteen 0 and 3 as in our example as the array size is 4*4
      // then we get the value of that random index from the inialised array (puzzle )  and  exchange between the current index and the random index

      //swap every spot randomly
      int temp  = a[c][r];
      a[c][r]   = a[nc][nr];
      a[nc][nr] = temp;
    }
  }
  calculateSolved();
}


String finish="Brilliant!! ; )";

/*******************************************************************************
 * [Function Name] : winning_page
 *
 * [Description]   : A function to draw the winning page
 *
 * [Args in]       : NONE
 * [Args out]      : NONE
 *******************************************************************************/
void winning_page()
{
  background(0);
  fill(255);
  textFont(font,80);
  text(finish,230,70);
}

/*******************************************************************************
 * [Function Name] : mouseClicked
 *
 * [Description]   : A function to wait for the mouse click on any button
 *
 * [Args in]       : NONE
 * [Args out]      : NONE
 *******************************************************************************/
void mouseClicked( ){
  btn1.clicked_3x3( mouseX, mouseY);
  btn2.clicked_4x4( mouseX, mouseY);
}

/*******************************************************************************
 * [Function Name] : resetFunc
 *
 * [Description]   : A function to reset the game
 *
 * [Args in]       : NONE
 * [Args out]      : NONE
 *******************************************************************************/
void resetFunc(){
  moves = 0;
  gamestate = 0;
  emptyRow = rows-1;
  emptyColumn = rows-1;
  for (int i = 0; i<loop; i++){
    for (int j = 0; j<loop; j++){
      correct[i][j] = true;
      puzzle[i][j] = solution[i][j];
    }
  }
  timer = 0;
}
