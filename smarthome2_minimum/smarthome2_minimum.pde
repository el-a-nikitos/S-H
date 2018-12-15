import processing.serial.*;
import ipcapture.*;

Serial COMport;
IPCapture cam;

range red1 = new range(),
      green1 = new range(),
      blue1 = new range(),
      blue2 = new range(),
      blue3 = new range();
      
button  gradient1 = new button(),
        gradient2 = new button(),
        gradient3 = new button(),
        bedLED = new button(),
        stopLight1 = new button(),
        stopLight2 = new button(),
        stopLight3 = new button(),
        stopAll = new button(),
        floor = new button(),
        autoFloor = new button();

void setup()  {
  cam = new IPCapture(this, "http://192.168.0.200:8080/stream/getvideo", "smarthome", "c21hcnQxNjQ=");
  cam.start();
  
  //WINDOW
  size(800,600);
  background(100);
  frameRate(15);
  
  //RANGES
  red1.Settup(15,60,250,100,100);
  green1.Settup(15,60+50,100,250,100);
  blue1.Settup(15,60+100,100,100,250);
  
  blue2.Settup(15,60+220,100,100,250);
  blue3.Settup(15,60+350,100,100,250);
  
  //BUTTONS
  bedLED.Settup(45,5,200,200,200, " Подсветка кровати");
  
  gradient1.Settup(15,60+160,200,200,200, " Градиент1");
  stopLight1.Settup(165,60+160,200,200,200, " Выкл.ленту1");
  
  gradient2.Settup(15,60+280,200,200,200, " Градиент2");
  stopLight2.Settup(165,60+280,200,200,200, " Выкл.ленту2");
  
  gradient3.Settup(15,60+350+60,200,200,200, " Градиент3");
  stopLight3.Settup(165,60+350+60,200,200,200, " Выкл.ленту3");
  stopAll.Settup(100,540,200,200,200, " Выкл.всё");
  
  floor.Settup(350,540,200,200,200, " Прогрев пола");
  autoFloor.Settup(545,540,200,200,200, " Утренний прогрев");
}

void draw()  {

    if  (gradient1.logic)  {  // вкл/выкл градиент RGB комнаты 1
      red1.Lock();
      green1.Lock();
      blue1.Lock();
    }  else  {
      red1.Unlock();
      green1.Unlock();
      blue1.Unlock();
    }
    
    if  (gradient2.logic)  {  // вкл/выкл градиент Blue комнаты 1
      blue2.Lock();
    }  else  {
      blue2.Unlock();
    }
    
    if  (gradient3.logic)  {  // вкл/выкл градиент Blue комнаты 2
      blue3.Lock();
    }  else  {
      blue3.Unlock();
    }
    
    if (stopLight1.logic)  {
      stopLight1.logic = false;  // алгоритм выключения ленты 1
      stopLight1.Draw();
      
      gradient1.logic = false;
      gradient1.Draw();
      
      red1.Value = 0;
      green1.Value = 0;
      blue1.Value = 0;
    }
    
    if (stopLight2.logic)  {
      stopLight2.logic = false;  // алгоритм выключения ленты 2
      stopLight2.Draw();
      
      gradient2.logic = false;
      gradient2.Draw();
      
      blue2.Value = 0;
    }
    
    if (stopLight3.logic)  {
      stopLight3.logic = false;  // алгоритм выключения ленты 3
      stopLight3.Draw();
      
      gradient3.logic = false;
      gradient3.Draw();
      
      blue3.Value = 0;
    }
    
    if (stopAll.logic)  {
      stopAll.logic = false;  // алгоритм выключения всего
      stopAll.Draw();
      gradient1.logic = false;
      gradient1.Draw();
      gradient2.logic = false;  // выключение градиентов
      gradient2.Draw();
      gradient3.logic = false;
      gradient3.Draw();
      
      bedLED.logic = false;  //выключение подсветки над кроватью
      bedLED.Draw();
      
      red1.Value = 0;
      green1.Value = 0;
      blue1.Value = 0;
      blue2.Value = 0;  // сброс цветов в 0
      blue3.Value = 0;
      
      floor.logic = false;
      floor.Draw();
      autoFloor.logic = false;  // выключение подогрева теплого пола
      autoFloor.Draw();
    }
    
    if ( cam.isAvailable() ) {
      cam.read();
      image(cam,width*0.45,height*0.1,width*0.5,height*0.5);    // показ с камеры
    }
    
    noStroke();
    fill(100);
    rect(width*0.7,0,200,50);    // показать частоту кадров
    fill(0);
    text(round(frameRate)+" кадров/с",width*0.7,height*0.05);
}

void mousePressed()  {
  //RANGES
  red1.Change();
  green1.Change();
  blue1.Change();
  blue2.Change();
  blue3.Change();
  
  gradient1.Change();
  gradient2.Change();
  gradient3.Change();
  
  bedLED.Change();
  
  stopLight1.Change();
  stopLight2.Change();
  stopLight3.Change();
  stopAll.Change();
  
  floor.Change();
  autoFloor.Change();
}