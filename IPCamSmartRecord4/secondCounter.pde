void secondCounter()  {
///////
  if (record)  {
    
    if ( (second())!=lastSecond )  {
      time++;
      lastSecond = second();
    }
    
  }
///////
}