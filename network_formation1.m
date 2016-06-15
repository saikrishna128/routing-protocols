clc,clear all;
a = input('Enter the number of nodes= ');
xm=100;
ym=100;
for i=1:1:a
     Node.x(i)=rand(1)*xm;
     Node.y(i)=rand(1)*ym;
end
plot(Node.x,Node.y,'o');hold on;
sink.x=randi(125);
sink.y=randi(200);
plot(sink.x,sink.y,'r*');