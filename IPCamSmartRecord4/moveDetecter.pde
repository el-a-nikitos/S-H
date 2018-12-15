void moveDetecter()  {  // определяет факт движения и обрисовывает подвижный объект прямоугольником
int minX = 13, maxX = 1, minY = 17, maxY = 1;
boolean minXe = true, minYe = true;

  for (int i=1;i<=12;i++)  {
    if ( abs(DbridghH[i])>deathLine )  { // если производная на линие больше порога, то эта линия считается нижней
      maxY = i;
      minYe = false;
    }
    else  {
      if (minYe)  {
        minY = i;
      }
    }
  }
  
  for (int i=1;i<=16;i++)  {
    if ( abs(DbridghW[i])>deathLine )  { // если производная на линие больше порого, то эта линия считается правой
      maxX = i;
      minXe = false;
    }
    else  {
      if (minXe)  {
        minX = i;
      }
    }
  }
  
  if ( ((!minXe)||(!minYe))&&(!record) )  {
   record = true;
   time = 0;    // сброс счетчика с момента начала движения
   lastSecond = second();  // запомнили время (секунду) начала движения
   
  }
  
  if ( (record)&&(time==maxSecond) )  {
    record = false;
  }
  
  
  
/*
  frame.beginDraw();  // визуализаця детектора движения
    frame.stroke(200,200,50);
    frame.noFill();  
    
    if ((!minXe)||(!minYe))  {  // риусем прямоугольник, если было обнаружено движение
      frame.rect( (minX-1)*40, (minY-1)*40, (maxX-minX+2)*40, (maxY-minY+2)*40 );
    }
    
    frame.fill(255);
    frame.text(minX,10,460);
    frame.text(maxX,30,460);
    frame.text(minY,50,460);
    frame.text(maxY,70,460);
    if (minXe)  {
      frame.text("minX-нет", 90,460 );
    } else  {
      frame.text("minX-да", 90,460 );
    }
    if (minYe)  {
      frame.text("minY-нет", 170,460 );
    } else  {
      frame.text("minY-да", 170,460 );
    }
    
  frame.endDraw();
*/

}