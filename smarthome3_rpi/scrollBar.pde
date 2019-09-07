public class scrollBar
{
  private int int_max_value = 180;
  
  public int  int_position = 0,
              int_value = 0,
              int_max_position = 100,
              int_X_coordinate,
              int_Y_coordinate,
              int_width,
              int_height;
              
  public String str_name = "no name";    
  
  public boolean b_spin = false;
              
  public scrollBar(float float_X_coordinate, float float_Y_coordinate, float float_width, float float_height)
  {
    this.int_X_coordinate = round( float_X_coordinate );
    this.int_Y_coordinate = round( float_Y_coordinate );
    this.int_width = round( float_width );
    this.int_height = round( float_height );
  }
  
  public void draw_scrollBar()
  {
    fill(200);
    textSize(int_height);
    textAlign(CENTER, BOTTOM);
    text(str_name, int_X_coordinate + int_width/2, int_Y_coordinate);
    
    strokeWeight(1);
    rect(int_X_coordinate, int_Y_coordinate, int_width, int_height);
    
    fill(0);
    textSize(int_height*2/3);
    textAlign(CENTER, CENTER);
    text(int_position, int_X_coordinate + int_width/2, int_Y_coordinate + int_height/2);
    
    noFill();
    strokeWeight(3);
    rect(int_X_coordinate + (int_width-int_height)*int_position/int_max_position, int_Y_coordinate, int_height, int_height);
  }
  
  public void hook_the_mose()
  {
    if ( (mouseX>int_X_coordinate) & (mouseX<(int_X_coordinate+int_width)) & (mouseY>int_Y_coordinate) & (mouseY<int_Y_coordinate+int_height) )
    {
      int_position = round( int_max_position*(mouseX - int_X_coordinate - int_height/2)/(int_width-int_height) );
      if (int_position<0) {int_position = 0;}
      if (int_position>int_max_position) {int_position = int_max_position;}
      
      int_value = round( int_max_value*int_position/int_max_position );
    }
  }
  
}
