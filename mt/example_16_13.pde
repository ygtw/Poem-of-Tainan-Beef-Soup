void moveToRandom(RiText rt)
{
  float newX = random(width - rt.textWidth()); 
  float newY = random(rt.textHeight(), height - 1);
  
//  newX=10; newY=10;
  float dst = rt.distanceTo(newX, newY);

  rt.moveTo(newX, newY, dst / width);
}


void onRiTaEvent(RiTaEvent re) {  
  if (re.type() == RiTa.MOVE_TO)
    moveToRandom((RiText) re.source());
}
