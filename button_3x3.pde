boolean selected; //is the button selected / on? true/false

class Button{
  ///INSTANCE VARIABLES
  float x,y; //position
  float w,h; //size
  color defaultColor, currentColor;
  String label; 
  
 
 
  ///CONSTRUCTORS - no return type declared - match Class-name
  Button(float x, float y, float w, float h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    selected = false;
    defaultColor = color( #D19A63); //slightly darker?
    currentColor = defaultColor; 
  }
  

  ///METHODS
  void display_3x3(){            //RENDER
  noStroke();
    fill( currentColor);
    rect( x, y, w, h);
    fill( 255);//black for text
    textAlign(CENTER,CENTER);
    text( label, x + w/2, y + (h/2));
     }
     
     

  void clicked_3x3( int mx, int my){         //UPDATRE
    if( mx > x && mx < x + w  && my > y && my < y+h){
      //mouse has been clicked
      if( selected){
        buttonClicked=1;
        play=1;
      }
    }
  
 
}







}
