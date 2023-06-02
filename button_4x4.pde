boolean selected1; //is the button selected / on? true/false

class Button1{
  ///INSTANCE VARIABLES
  float x1,y1; //position
  float w1,h1; //size
  color defaultColor1, currentColor1;
  String label1; 
  
  Button1(float x1, float y1, float w1, float h1, String label1){
    this.x1 = x1;
    this.y1 = y1;
    this.w1 = w1;
    this.h1 = h1;
    this.label1 = label1;
    selected1 = false;
    defaultColor1 = color(#ED851D); //slightly darker?
    currentColor1 = defaultColor1; 
  }
  
  void display_4x4(){            //RENDER
    noStroke();
    fill( currentColor1);
    rect( x1, y1, w1, h1);
    fill( 255);//black for text
    textAlign(CENTER,CENTER);
    text( label1, x1 + w1/2, y1 + (h1/2));
     }
     
     

  void clicked_4x4( int mx1, int my1){         //UPDATRE
    if( mx1 > x1 && mx1 < x1 + w1  && my1 > y1 && my1 < y1+h1){
      //mouse has been clicked
      if( selected1){
        buttonClicked=2;
        play=2;
      }
    }
  
 
}







}
