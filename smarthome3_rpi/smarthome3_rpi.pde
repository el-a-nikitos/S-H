import processing.io.*;
nikitos_PWM pwm_red1, pwm_green1, pwm_blue1;

byte  byte_rpi_channal_red1 = 13,
      byte_rpi_channal_green1 = 12,
      byte_rpi_channal_blue1 = 6;
      
int int_counter = 0;

byte pwm_duty = 50;

//PWM pri_pwm_red1 = new PWM("pwmchip0/pwm13");

void setup()
{
  pwm_red1 = new nikitos_PWM(this, byte_rpi_channal_red1);
  pwm_green1 = new nikitos_PWM(this, byte_rpi_channal_green1);
  pwm_blue1 = new nikitos_PWM(this, byte_rpi_channal_blue1);
  
  //pwm_red1.attach(byte_rpi_channal_red1);
  //pwm_green1.attach(byte_rpi_channal_green1);
  //pwm_blue1.attach(byte_rpi_channal_blue1);
  
  size(240, 360);
  //fullScreen();
 
  frameRate(20);
  
  //println("start");
  //thread("counter");
  //thread("pwm1");
}

void draw()
{  
  background(50);
  
  float angle1 = 90 + sin(frameCount / 50.0)*85;
  float angle2 = 90 + sin(frameCount / 50.0 + PI/3)*85;
  float angle3 = 90 + sin(frameCount / 50.0 + 2*PI/3)*85;
  
  pwm_red1.write(angle1);
  pwm_green1.write(angle2);
  pwm_blue1.write(angle3);
  
  fill(200);
  textSize(0.03*height);
  textAlign(RIGHT, TOP);
  text(round(frameRate), width, 0);

}
