void stop_led1()
{
  scrollBar_red1.int_position = 0;
  scrollBar_red1.int_value = 0;
  
  scrollBar_green1.int_position = 0;
  scrollBar_green1.int_value = 0;
  
  scrollBar_blue1.int_position = 0;
  scrollBar_blue1.int_value = 0;
  
  rectButton_spin1.b_click = false;
  rectButton_bedLED.b_click = false;
  spin_led1();
  bed_LED();
}

void stop_led3()
{ 
  scrollBar_blue3.int_position = 0;
  scrollBar_blue3.int_value = 0;
  
  //rectButton_spin1.b_click = false;
  //spin_led1();
}

void spin_led1()
{
  if (rectButton_spin1.b_click == true)
  {
    scrollBar_red1.b_lock = true;
    scrollBar_green1.b_lock = true;
    scrollBar_blue1.b_lock = true;
  }
  else
  {
    scrollBar_red1.b_lock = false;
    scrollBar_green1.b_lock = false;
    scrollBar_blue1.b_lock = false;
  }
}

void bed_LED()
{
  if (rectButton_bedLED.b_click == true)
  {
    //GPIO.digitalWrite(int_rpi_channal_bedLED, GPIO.HIGH);
  }
  else
  {
    //GPIO.digitalWrite(int_rpi_channal_bedLED, GPIO.LOW);
  }
}
