public class button
{
  public int Width = 60,
  Height = 50,
  X = 50,
  Y = 50,
  colorR = 100,
  colorG = 100,
  colorB = 100;
  public String Name = "button";
  
  //boolean pressDown = false;
  public boolean logic = false;
  
  public void Settup(int x, int y, int r, int g, int b, String s)  {
    X = x;
    Y = y;
    colorR = r;
    colorG = g;
    colorB = b;
    Name = s;
    
    Draw();
  }
  
  public void Draw()  {
    Width = (Name.length())*(Height/2)*4/7;  // определение ширины кнопки
    
    stroke(0);
    /**if (!pressDown)  {
      fill(colorR,colorG,colorB);  // прорисовка контура кнопки
      rect(X,Y,Width,Height);
    } else  {
      fill(colorR-50,colorG-50,colorB-50);
      pressDown = false;
      rect(X,Y,Width,Height);
    }**/
    fill(colorR,colorG,colorB);  // прорисовка контура кнопки
    rect(X,Y,Width,Height);
    //rect(X,Y,Width,Height);
    
    textSize(Height/2);  // прорисовка текста кнопки
    if (!logic)  {
      fill(200,100,100);
    }  else  {
      fill(60,200,60);
    }
    text(Name,X,Y+Height*2/3);
    
  }
  
  public void Change()  {
    if ( (mouseX>X)&&(mouseX<(X+Width))&&(mouseY>Y)&&mouseY<(Y+Height) )  {
      //pressDown = true;
      logic = logic^true;
    } 
    
    Draw();
  }
  
}