public class range
{
  public int Width = 320,
  Height = 50,
  Value = 0,
  X = 50,
  Y = 50,
  colorR = 100,
  colorG = 100,
  colorB = 100;
  
  public boolean showText = true, lock = false;
  
  public void Settup(int x, int y, int r, int g, int b)  {  // X-position, Y-position, RGB-background
    X = x;
    Y = y;
    colorR = r;
    colorG = g;
    colorB = b;
    
    Draw();
  }
  
  public void Draw()  {
    int position = Value*(Width-Height)/255;
    stroke(colorR*0.7,colorG*0.7,colorB*0.7);
    fill(colorR,colorG,colorB);
    rect(X,Y,Width,Height);
    
    fill(200,200,200);
    rect(X+position,Y,Height,Height);
    
    if ( (showText)&&(!lock) )  {
      textSize(Height/2);
      fill(10,10,10);
      text(Value*100/255,X+position,Y+Height*2/3);
    }
    
    if (lock)  {
      stroke(0);
      fill(250,100,100);
      ellipse(X+position+Height*1/2,Y+Height*1/2,Height*5/11,Height*7/11);
      fill(200,200,200);
      ellipse(X+position+Height*1/2,Y+Height*1/2,Height*3/11,Height*5/11);
      fill(250,100,100);
      rect(X+position+Height*1/4,Y+Height*1/2,Height*1/2,Height*1/3);
    }
  }
  
  public void Change()  {
    if ( (mouseX>X)&&(mouseX<(X+Width))&&(mouseY>Y)&&mouseY<(Y+Height)&&(!lock) )  {
      Value = (mouseX-X-Height/2)*255/(Width-Height) ;
      if (Value<0) {Value = 0;}
      if (Value>255) {Value = 255;}
      
      Draw();
    }
  }
  
  public void Lock()  {
      lock = true;  // заблокировать ползунок
      Draw();
    }
    
    public void Unlock()  {
      lock = false;  // разблокировать ползунок
      Draw();
    }
  
}