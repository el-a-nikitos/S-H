public class rectButton
{
  public int  int_X_coordinate,
              int_Y_coordinate,
              int_width,
              int_height;
              
  public String str_name = "no name",
                str_thread;
  
  public boolean b_click = false;
  
  public rectButton(String str_thread, float float_X_coordinate, float float_Y_coordinate, float float_width, float float_height)
  {
    this.int_X_coordinate = round( float_X_coordinate );
    this.int_Y_coordinate = round( float_Y_coordinate );
    this.int_width = round( float_width );
    this.int_height = round( float_height );
    this.str_thread = str_thread;
  }
  
  public void draw_rectButton()
  {
    strokeWeight(3);
    if (b_click == false)
    {
      fill(100);
    }
    else
    {
      fill(100,150,100); 
    }
    rect(int_X_coordinate, int_Y_coordinate, int_width, int_height);
    
    //if (b_click == true)
    //{
    //  b_click = false;
    //  delay(500);
    //}
    
    fill(200);
    textSize(int_height*2/3);
    textAlign(CENTER, CENTER);
    text(str_name, int_X_coordinate + int_width/2, int_Y_coordinate + int_height/2);
    
    if (b_click == true)
    {
      b_click = false;
      //delay(500);
    }
  }
  
  public void click()
  {
    if ( (mouseX>int_X_coordinate) & (mouseX<(int_X_coordinate+int_width)) & (mouseY>int_Y_coordinate) & (mouseY<int_Y_coordinate+int_height) )
    {
      b_click = true;
      
     thread(str_thread);
    }
  }
}
