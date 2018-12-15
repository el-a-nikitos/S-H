void recordToFile()  {
  
  if ( (record)&&(!lastRecord) )  {
    videoExport = new VideoExport(this, "video/"+day()+"/Дата_"+day()+"-"+month()+"-"+year()+"_Время_"+hour()+"_час_"+minute()+"_мин"+second()+"_сек"+".mp4", frame);
    videoExport.setFrameRate(frameRate);    // создание файла
    videoExport.startMovie();
  }
  
  if (record)  {
    videoExport.saveFrame();  // запись кадра
  } 
  
  if ( (!record)&&(lastRecord) )  {
    videoExport.endMovie(); 
  }

  lastRecord = record;
}