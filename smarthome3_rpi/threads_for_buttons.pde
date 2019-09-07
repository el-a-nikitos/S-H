void stop_led1()
{
  scrollBar_red1.int_position = 0;
  scrollBar_green1.int_position = 0;
  scrollBar_blue1.int_position = 0;
}

void spin_led1()
{
  int_test_counter--;
}
