import processing.io.*;
SoftwareServo pwm_red1 = new SoftwareServo(this, 13), 
              pwm_green1 = new SoftwareServo(this, 12), 
              pwm_blue1 = new SoftwareServo(this, 6);

scrollBar scrollBar_red1,
          scrollBar_green1,
          scrollBar_blue1;
          
rectButton  rectButton_stop1,
            rectButton_spin1;

//byte  byte_rpi_channal_red1 = 13,
//      byte_rpi_channal_green1 = 12,
//      byte_rpi_channal_blue1 = 6;
      
//int int_test_counter = 0;
//byte pwm_duty = 50;

float angle1, angle2, angle3;

void setup()
{
  //pwm_red1.attach(byte_rpi_channal_red1);
  //pwm_green1.attach(byte_rpi_channal_green1);
  //pwm_blue1.attach(byte_rpi_channal_blue1);
  scrollBar_red1 = new scrollBar(0.1*width, 0.05*height, 0.8*width, 0.04*height);
  scrollBar_red1.str_name = "спальня, красный";
  
  scrollBar_green1 = new scrollBar(0.1*width, 0.15*height, 0.8*width, 0.04*height);
  scrollBar_green1.str_name = "спальня, зеленый";
  
  scrollBar_blue1 = new scrollBar(0.1*width, 0.25*height, 0.8*width, 0.04*height);
  scrollBar_blue1.str_name = "спальня, синий";
  
  rectButton_stop1 = new rectButton("stop_led1", 0.1*width, 0.32*height, 0.35*width, 0.04*height, false);
  rectButton_stop1.str_name = "ВЫКЛ. спальню";
  
  rectButton_spin1 = new rectButton("spin_led1", 0.55*width, 0.32*height, 0.35*width, 0.04*height, true);
  rectButton_spin1.str_name = "ПЕРЕЛИВАТЬСЯ";
  
  //size(480, 720);
  fullScreen();
 
  frameRate(20);
  
  background(0);

  pwm_red1.write(0);
  pwm_green1.write(0);
  pwm_blue1.write(0);
  
  delay(3000);
}

void draw()
{  
  background(100);
  angle_calculate();
  draw_frameRate();
  
  scrollBar_red1.draw_scrollBar();
  scrollBar_green1.draw_scrollBar();
  scrollBar_blue1.draw_scrollBar();
  
  rectButton_stop1.draw_rectButton();
  rectButton_spin1.draw_rectButton();
  
  //scrollBar_red1.hook_the_mouse();
  //scrollBar_green1.hook_the_mouse();
  //scrollBar_blue1.hook_the_mouse();
  if ( rectButton_spin1.b_click == false )
  {
    pwm_red1.write( scrollBar_red1.int_value );
    pwm_green1.write( scrollBar_green1.int_value );
    pwm_blue1.write( scrollBar_blue1.int_value );
  }
  else
  {
    color_spin_1();
  }
  
  //text(int_test_counter, 100, 500);
  //color_spin_1(); 
}

void mouseDragged()
{
  scrollBar_red1.hook_the_mouse();
  scrollBar_green1.hook_the_mouse();
  scrollBar_blue1.hook_the_mouse();
}

void mousePressed()
{
  rectButton_stop1.click();
  rectButton_spin1.click();
}
