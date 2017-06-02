%{
Adam Liber
ITP 168 - Fall 2015
Homework 9
aliber@usc.edu

date                   change                 programmer
--------------------------------------------------------
11/13/2015             original               Adam Liber
%}

%part 1
mat  = importdata('HW9.mat');
X = mat.X;
Y = mat.Y;
Z = mat.ELEV;
%part 2
earthR = 6371000;
xMeters = zeros(1,335);
yMeters = zeros(230,1);


for i = 2:length(X)
xMeters(i) = xMeters(i - 1) - earthR*tand(X(i-1) - X(i));
end

for i = 2:length(Y)
yMeters(i) = yMeters(i - 1) - earthR*tand(Y(i-1) - Y(i));
end
%part 3
lowx= 1;
upx= 50;
lowy = 1;
upy = 50;
node = 10;

xtop = xMeters(lowx:upx);
ytop(1:length(xtop)) = yMeters(upy);

xbot = xMeters(lowx:upx);
ybot(1:length(xbot)) = yMeters(lowy);

yrit = yMeters(lowy:upy);
xrit(1:length(yrit)) = xMeters(upx);

yleft = yMeters(lowy:upy);
xleft(1:length(yleft)) = xMeters(lowx);


z = Z(lowx:upx,lowy:upy);
subplot(2,1,1)
surf(xMeters(lowx:upx),yMeters(lowy:upy),z);
xlim([xMeters(lowx) xMeters(upx)])
ylim([yMeters(lowy) yMeters(upy)])
zlim auto

subplot(2,1,2)
contour(xMeters,yMeters,Z);
hold on
plot(xtop,ytop,'B-');
plot(xbot,ybot,'B-');
plot(xrit,yrit,'B-');
plot(xleft,yleft,'B-');
hold off

%part 4 
choose = 1;
while choose
move = input('choose a direction to move: \n1.North\n2.South\n3.East\n4.West\n0.quit\n','s');
switch move
    case '1'
       if upy + node > length(yMeters)
         upy =  length(yMeters);
         lowy = length(yMeters) - 49;
       else 
          upy = upy +node;
          lowy = lowy + node;
       end
    case '2'
        if lowy - node < 1
           lowy = 1;
           upy =  50;     
       else 
           lowy = lowy - node;
           upy = upy - node;
       end
    case '3'
        if upx + node > length(xMeters)
           upx = length(xMeters);
           lowx = length(xMeters) - 49;
       else 
           upx  = upx + node;
           lowx = lowx +node;
        end      
    case '4'
        if lowx - node < 1
           lowx = 1;
           upx = 50;
       else 
           lowx = lowx - node;
           upx = upx - node;
        end     
    case '0'
        choose = 0;
end 
xtop = xMeters(lowx:upx);
ytop(1:length(xtop)) = yMeters(upy);

xbot = xMeters(lowx:upx);
ybot(1:length(xbot)) = yMeters(lowy);

yrit = yMeters(lowy:upy);
xrit(1:length(yrit)) = xMeters(upx);

yleft = yMeters(lowy:upy);
xleft(1:length(yleft)) = xMeters(lowx);

subplot(2,1,1)
z = Z(lowx:upx,lowy:upy);
surf(xMeters(lowx:upx),yMeters(lowy:upy),z);
xlim([xMeters(lowx) xMeters(upx)])
ylim([yMeters(lowy) yMeters(upy)])
zlim auto

subplot(2,1,2)
contour(xMeters,yMeters,Z);
hold on
plot(xtop,ytop,'B-');
plot(xbot,ybot,'B-');
plot(xrit,yrit,'B-');
plot(xleft,yleft,'B-');
hold off
end

