clc();
clear all;
a = input('Enter the number of nodes= ');
q= input('enter the no. of iterations:');
f=1;
x=100;
y=100;
sinkx= 50;
sinky=50;
xd = x*rand(1,a)
yd = y*rand(1,a)
md=sort(yd)
     
c = round(a/5)
for k=1:c
    d=xd(f:f+4)
    e=md(f:f+4)
    f=f+5;
    scatter(d,e)
    hold on
end
    
for j=1:q
     f=1;
     NrGrid = 6;   
     p= linspace(0, 100, NrGrid+1);
    [X,Y] = meshgrid(p);
    subplot(1,q,j)
       
    plot(xd,md,'g+') 
    hold on
    plot(sinkx,sinky,'bo','MarkerSize',20)
    hold on
    plot(X,Y,'k');
    hold on
    plot(Y,X,'k')
   
    hold on
    for i = 1:c
        
    
    p=randi([f,f+4],1,1)
    CHxi = xd(1,p)
    CHyi = md(1,p)
    plot(CHxi,CHyi,'r*')
    hold on
    plot([CHxi 50],[CHyi 50],'r')
    f=f+5;
    
    
    hold on
    end
    hold off
    end
   
        
        