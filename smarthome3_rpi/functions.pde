void color_spin_1()
{
  //pwm_red1.write(angle1);
  //pwm_green1.write(angle2);
  //pwm_blue1.write(angle3);
  
  led_write(int_rpi_channal_pwm_red1, round(angle1) );
  led_write(int_rpi_channal_pwm_green1, round(angle2) );
  led_write(int_rpi_channal_pwm_blue1, round(angle3) );
}

void angle_calculate()
{
  angle1 = 90 + sin(frameCount / 50.0)*85;
  angle2 = 90 + sin(frameCount / 50.0 + PI/3)*85;
  angle3 = 90 + sin(frameCount / 50.0 + 2*PI/3)*85;
}

void draw_frameRate()
{
  fill(150);
  textSize(0.02*height);
  textAlign(RIGHT, TOP);
  text(round(frameRate), width, 0);
}

void led_write(int int_rpi_channal, int int_value)
{
  if (int_value > 90)
  {
    GPIO.digitalWrite(int_rpi_channal, GPIO.HIGH);
  }
  else
  {
    GPIO.digitalWrite(int_rpi_channal, GPIO.LOW);
  }
}
