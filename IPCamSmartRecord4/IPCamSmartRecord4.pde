// детектор движения работает по контрольной сумме в горизонтаьных и вертикальных полосках
// каждый ролик длится по 15 (maxSecond) секунд
// каждые 10 (maxMinute) минут переподключение к камере

import ipcapture.*;
import com.hamoid.*;
VideoExport videoExport;

IPCapture cam;
PGraphics frame;
PrintWriter output;

int FPS = 20;  // базовая частота записи
int frameR = 0, frameG = 0, frameB = 0;
int[] bridghH = new int[13];  //массив средней яркости: 6 линий по горизонтале
int[] bridghW = new int[17];  //массив средней яркости: 8 линий по вертикале
int[] bridghH0 = new int[13];
int[] bridghW0 = new int[17];
int[] DbridghH = new int[13];
int[] DbridghW = new int[17];

int N = 10;  // каждые N кадров идетанализ движения
int deathLine = 5000;  // порог срабатывания датчика движения

int time = 0, lastSecond, maxSecond = 15, maxMinute = 10;
boolean nextSecond = false;

boolean record = false, lastRecord = false, reconnect = false;

void setup() {
  fill(255);  //цвет текста для технологического отображения
  
  output = createWriter("video/logs.txt");
  
  frameRate(FPS);
  //size(640,480);
  frame = createGraphics(640,480);  // разрешение кадра записи
  
  cam = new IPCapture(this, "http://192.168.0.200:8080/stream/getvideo", "smarthome", "c21hcnQxNjQ=");
  cam.start();
  
  
  while ((frameR==0)&(frameG==0)&(frameB==0))  {
    cam.read();
    frameColorDetector();     // ожидание подключения камеры и определение среднего цвета верхней полоски
  }
  
  frame.beginDraw();
  frame.strokeWeight(3);
  frame.endDraw();
  
}


void draw()  {
  background(0);
  
  frameColorDetector();  // определение среднего цвета верхней полоски
  
  cam.read();
  frame.beginDraw();
  frame.image(cam,0,0);  // кадр камеры записывается в кадр видео-потока
  
  frame.fill(byte(-frameR+128),byte(-frameG+128),byte(-frameB+128));
  frame.text(int(frameRate)+" Кадр/сек", 150,15);
  frame.text("Время "+hour()+":"+minute()+":"+second(), 240,15);    // дата, время и частота кадров
  frame.text("Дата "+day()+"/"+month()+"/"+year(), 350,15);
  
  if (record)  {
   frame.text(time,500,15); 
  }
  
  frame.endDraw();
  
  if ((frameCount%N)==0)  {
    gridFrame();  // проверка движения каждые N кадров
  }
  
  moveDetecter();  // визуалиазация движения
  
  recordToFile(); // начало и остановка записи ролика
  
  secondCounter();  // счет секунд
  
  if ( ( ( (minute())%maxMinute )==0 )&&(!reconnect) )  {
    cam.stop();
    cam.start();
    reconnect = true;    // каждые 10 (maxMinute) минут перезапускать камеру
  }
  if ( ((minute())%maxMinute)!=0 )  {
    reconnect = false; 
  }
  
  //image(frame,0,0);  //визуализация записываемого кадра
  
  if (record)  {
   text("ЗАПИСЬ",28,50); 
  } else  {
   text("ОЖИДАНИЕ",15,50); 
  }
  
  
}