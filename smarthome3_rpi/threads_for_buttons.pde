void stop_led1()
{
  scrollBar_red1.int_position = 0;
  scrollBar_red1.int_value = 0;
  
  scrollBar_green1.int_position = 0;
  scrollBar_green1.int_value = 0;
  
  scrollBar_blue1.int_position = 0;
  scrollBar_blue1.int_value = 0;
  
  rectButton_spin1.b_click = false;
  spin_led1();
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
