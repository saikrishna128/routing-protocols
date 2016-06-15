clc();clear all;
a = input('Enter the number of nodes= ');
q= input('enter the no. of iterations:');
f=1;  xi=180;yi=100; 
colour_teal = [18 150 155] ./ 255;
colour_lightgreen = [94 250 81] ./ 255; 

        x = randi(200,a,1)
        y = randi(200,a,1)
        m = sort(x)
        n = sort(y)
        e = [m,n]
        c = round(a/5)
       %making of clusters
    for  i = 1:c
      ei = e(f:f+4,1:2)
      f = f+5;
    end 
    
   for j = 1:q
      f = j;   
      subplot (1,q,j)
      axis([0 200 0 200]);
      plot(m,n,'go')
      hold on
      plot(180,100,'b+')%sink co ordinates
      hold on
      axis([0 200 0 200]);
     for i = 1:c   
        CHxi = m(f,1)
        CHyi = n(f,1)
        plot(CHxi,CHyi,'r*')
        hold on
        d1=sqrt((xi-CHxi).^2+(yi-CHyi).^2)
        d2=sqrt((xi-180).^2+(yi-100).^2)
          if(d1 >= d2)
              { plot([xi 180],[yi 100],'b')}; hold on
          else
              { plot([xi CHxi],[yi CHyi],'b')};hold on
          end    
        f=f+5;
        xi=CHxi;
        yi=CHyi;
     end
       plot([xi 180],[yi 100],'b') 
       hold on
       xi=180;yi=100;
       hold off
    end
    
   
