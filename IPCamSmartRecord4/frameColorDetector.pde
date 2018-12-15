void frameColorDetector()  {
  frameR = 0; frameG = 0; frameB = 0;
  
  for (int i=0;i<30;i++)  {
   for (int j=0;j<width;j++)  {
     frameR = frameR + int(red(cam.get(j,i)));
     frameG = frameG + int(green(cam.get(j,i)));
     frameB = frameB + int(blue(cam.get(j,i)));
   }
  }
  frameR = frameR/30/width;
  frameG = frameG/30/width;
  frameB = frameB/30/width;
}