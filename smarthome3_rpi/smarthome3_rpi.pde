import processing.io.*;
nikitos_PWM pwm_red1  = new nikitos_PWM(this, 13), 
            pwm_green1  = new nikitos_PWM(this, 12), 
            pwm_blue1 = new nikitos_PWM(this, 6);

scrollBar scrollBar_red1,
          scrollBar_green1,
          scrollBar_blue1;

//byte  byte_rpi_channal_red1 = 13,
//      byte_rpi_channal_green1 = 12,
//      byte_rpi_channal_blue1 = 6;
      
int int_counter = 0;

byte pwm_duty = 50;

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
  
  size(480, 720);
  //size(240, 360);
  //fullScreen();
 
  frameRate(20);
  
  background(0);

  //pwm_red1.write(0);
  //pwm_green1.write(0);
  //pwm_blue1.write(0);
  
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
  
  scrollBar_red1.hook_the_mose();
  
  pwm_red1.write( scrollBar_red1.int_value );
  
  
  //color_spin_1(); 
}
