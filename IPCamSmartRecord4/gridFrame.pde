void gridFrame()  {
  
  bridghH = new int[13];  //обнулить массив горизонтальных линий
  for (int i=1;i<=12;i++)  {
    for (int j=1;j<640;j++)  {
      bridghH[i] = bridghH[i] + int(red(cam.get(j,i*40))) + int(green(cam.get(j,i*40))) + int(blue(cam.get(j,i*40)));  // средний цвет на линии
    }
    DbridghH[i] = abs(bridghH[i]-bridghH0[i]);
  }
  
  bridghW = new int[17];  //обнулить массив вертикальных линий
  for (int i=1;i<=16;i++)  {
    for (int j=1;j<480;j++)  {
      bridghW[i] = bridghW[i] + int(red(cam.get(i*40,j))) + int(green(cam.get(i*40,j))) + int(blue(cam.get(i*40,j)));  // средний цвет на линии
    }
    DbridghW[i] = abs(bridghW[i]-bridghW0[i]);
  }
  
  /*
  frame.beginDraw();
  frame.stroke(255);
  for (int i=1; i<16; i++)  {
    frame.line(i*40,0,i*40,height);
    frame.text(DbridghW[i],i*40+5,460);
  }                                    // визуализация сетки
  for (int i=1; i<12; i++)  {
    frame.line(0,i*40,width,i*40);
    frame.text(DbridghH[i],5,i*40-15);
  }
  frame.endDraw();
  */
  
  bridghW0 = bridghW;    // сохранить старое значение массива
  bridghH0 = bridghH;
}