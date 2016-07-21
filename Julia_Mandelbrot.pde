float w=6;
float h=6;
float xmin=-3;
float ymin=-3;
float x0, y0, x0m, y0m, xcm, ycm, nx, ny, x, y, sm, f;
float xc=0;
float yc=0;
float zoom=1.6;
final int it_max=64;
int sizew=640;
int sizeh=640;
int it, itm;
int a=int(random(150,400));
int b=int(random(150,400));
int c=int(random(150,400));
int r=int(random(0,255));
Maxim maxim;
AudioPlayer player;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;
AudioPlayer player4;
AudioPlayer player5;
AudioPlayer player6;
int i=0;

void setup()
{
size(sizew,sizeh);//sizew:sizeh=s:h
maxim=new Maxim(this);
player=maxim.loadFile("fractal.wav");
player.setLooping(false);
player.volume(0.95);
player1=maxim.loadFile("sleep.wav");
player1.setLooping(false);
player1.volume(0.75);
player2=maxim.loadFile("mandelbrot.wav");
player2.setLooping(false);
player2.volume(0.75);
player3=maxim.loadFile("beeps.wav");
player3.setLooping(false);
player3.volume(0.75);
player4=maxim.loadFile("sleep1.wav");
player4.setLooping(false);
player4.volume(0.75);
player5=maxim.loadFile("sleep2.wav");
player5.setLooping(false);
player5.volume(0.75);
player6=maxim.loadFile("sleep3.wav");
player6.setLooping(false);
player6.volume(0.75);
colorMode(RGB);
rectMode(CENTER);
}

void draw()
{
 if (i==0)
 {
  player.play();  
  i++;
 }
int pix_max=sizew*sizeh;
loadPixels();
for (float n=1;n<=pix_max;n++)
{
  x0m=0;
  y0m=0;
  it=0;
  sm=0;
  itm=0;
  nx=n-floor(n/width)*width;
  ny=ceil(n/width);
  x0=(w*nx)/width+xmin;
  y0=ymin+h-(h*ny)/height;
  xcm=x0;
  ycm=y0;
  while(it<=it_max)
  {
    x=x0*x0-y0*y0+xc;
    y=2*x0*y0+yc;
    x0=x;
    y0=y;
    if (x*x+y*y>4)
    {      
      break;
    }   
    it++;
  }
  if ((it==it_max+1)||(it==0))
    {
       while(itm<=it_max)
         {
            x=x0m*x0m-y0m*y0m+xcm;
            y=2*x0m*y0m+ycm;
            sm=sm+sqrt(sq(x-x0m)+sq(y-y0m));
            x0m=x;
            y0m=y;
            if (x*x+y*y>4)
            {      
              break;
            }   
            itm++;
        }
        if ((itm==it_max+1)||(itm==0))
          {
            //pixels[int(n)-1]=color((int((sm*255*1.0)/(2089.0))+hc)%255,(int((sm*255*1.0)/(2089.0))+sc)%255,(int((sm*255*1.0)/(2089.0))+bc)%255);
            pixels[int(n)-1]=color((int(abs(sin(sm*a*b+c))*255)+r)%255,(int(abs(sin(sm*b*c+a))*255)+85+r)%255,(int(abs(sin(sm*c*a+b))*255)+170+r)%255);
          }
            else
            {      
              //pixels[int(n)-1]=color(((int((itm*255*1.0)/(it_max*1.0))+85)%255+hc)%255,(int((itm*255*1.0)/(it_max*1.0))+sc)%255,(int((itm*255*1.0)/(it_max*1.0))+bc)%255);
              pixels[int(n)-1]=color((int(abs(sin(itm*a*b+c))*255)+85+r)%255,(int(abs(sin(itm*b*c+a))*255)+170+r)%255,(int(abs(sin(itm*c*a+b))*255)+r)%255);
            }  
    }
    else
    {      
      //pixels[int(n)-1]=color(((int((it*255*1.0)/(it_max*1.0))+170)%255+hc)%255,(int((it*255*1.0)/(it_max*1.0))+sc)%255,(int((it*255*1.0)/(it_max*1.0))+bc)%255);
      pixels[int(n)-1]=color((int(abs(sin(it*a*b+c))*255)+170+r)%255,(int(abs(sin(it*b*c+a))*255)+r)%255,(int(abs(sin(it*c*a+b))*255)+85+r)%255);
    }  
}
updatePixels();
}

void mouseDragged()
{    
  player.stop();
  //f = dist(pmouseX, pmouseY, mouseX, mouseY);
  //f=map(f,0,height,0,1);
  if (i==1)
  {
  player1.play();
  //player1.volume(1-f);
  }
  if (i==2)
  {
  player4.play();
  //player4.volume(1-f);
  }
  if (i==3)
  {
  player5.play();  
  //player5.volume(1-f);
  }
  if (i==4)
  {
  player6.play();
  //player6.volume(1-f);
  }
  xc=(w*mouseX)/width+xmin;
  yc=ymin+h-(h*mouseY)/height;
  f=xc*xc+yc*yc;
  if ((int(f)==4)&&(abs(int(f)-f))<0.5)
  {
    player3.play();
  }
  a=int(random(150,400));
  b=int(random(150,400));
  c=int(random(150,400));
  r=int(random(0,255));
}

void mousePressed()
{
  i=floor(random(1,5));  
}

void mouseReleased()
{
 player1.stop();
 player4.stop();
 player5.stop();
 player6.stop();
}

void mouseClicked()
{  
  player2.play();
  xmin=xmin+((w*mouseX)/width-w/2);//translacija u ishodiste koordinatnog sistema
  ymin=ymin-(h*mouseY)/height+h/2;
  if (mouseButton == LEFT)
  {
  xmin=xmin+w/2-w/(2*zoom);
  ymin=ymin-h/(2*zoom)+h/2;
  w=w/zoom;
  h=h/zoom;
  }
  if (mouseButton == RIGHT)
  {
  xmin=xmin+w/2-(w*zoom)/2;
  ymin=ymin-(w*zoom)/2+h/2;
  w=w*zoom;
  h=h*zoom;
  }
}
