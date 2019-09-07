void color_spin_1()
{
  pwm_red1.write(angle1);
  pwm_green1.write(angle2);
  pwm_blue1.write(angle3);
}

void angle_calculate()
{
  angle1 = 90 + sin(frameCount / 50.0)*85;
  angle2 = 90 + sin(frameCount / 50.0 + PI/3)*85;
  angle3 = 90 + sin(frameCount / 50.0 + 2*PI/3)*85;
}

void draw_frameRate()
{
  fill(200);
  textSize(0.03*height);
  textAlign(RIGHT, TOP);
  text(round(frameRate), width, 0);
}
