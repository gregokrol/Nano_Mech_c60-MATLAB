clc;
clear globle;
%%
Nc=2e6;
load DATA.mat;
r0sng=Mdist(1,5);
r0dbl=Mdist(1,6);
t0a=Mang(1,5);
t0b=Mang(1,6);
kr=1850.4;
kt=169.04;
Uo=TOTAL_ENRG(kr,kt,r0sng,r0dbl,t0a,t0b,Mdist,XYZ,Mang);

XYZnew=zeros(60,3);
Mdistnew=zeros(60,7);
Mangnew=zeros(60,7);
Mvectornew=zeros(60,13);
UV=zeros(1,Nc/100+1);
UV(1,1)=Uo;
rgV=zeros(1,Nc/100);
rgV(1,1)=GYRATION_RADIUS(XYZ);
count=1;

%% Graphics
XYZt=XYZ';
RV=[XYZt(:,1),XYZt(:,3),XYZt(:,11),XYZt(:,19),XYZt(:,27),XYZt(:,35),XYZt(:,33),...
    XYZt(:,34),XYZt(:,36),XYZt(:,37),XYZt(:,40),XYZt(:,43),XYZt(:,57),XYZt(:,60),...
    XYZt(:,56),XYZt(:,53),XYZt(:,59),XYZt(:,58),XYZt(:,57),XYZt(:,43),XYZt(:,42),...
    XYZt(:,41),XYZt(:,47),XYZt(:,46),XYZt(:,23),XYZt(:,24),XYZt(:,51),XYZt(:,50),...
    XYZt(:,49),XYZt(:,52),XYZt(:,56),XYZt(:,53),XYZt(:,54),XYZt(:,55),XYZt(:,49),...
    XYZt(:,50),XYZt(:,51),XYZt(:,45),XYZt(:,46),XYZt(:,47),...
    XYZt(:,41),XYZt(:,44),XYZt(:,60),XYZt(:,44),XYZt(:,48),XYZt(:,45),XYZt(:,51),...
    XYZt(:,50),XYZt(:,15),XYZt(:,16),XYZt(:,55),XYZt(:,16),XYZt(:,15),XYZt(:,14),XYZt(:,21),...
    XYZt(:,20),XYZt(:,18),XYZt(:,22),XYZt(:,23),XYZt(:,22),XYZt(:,29),XYZt(:,32),...
    XYZt(:,47),XYZt(:,32),XYZt(:,31),XYZt(:,42),XYZt(:,31),XYZt(:,30),XYZt(:,37),...
    XYZt(:,36),XYZt(:,34),XYZt(:,38),XYZt(:,39),XYZt(:,40),XYZt(:,39),XYZt(:,58),...
    XYZt(:,57),XYZt(:,60),XYZt(:,44),XYZt(:,48),XYZt(:,45),XYZt(:,46),XYZt(:,45),...
    XYZt(:,48),XYZt(:,52),XYZt(:,48),XYZt(:,45),XYZt(:,46),XYZt(:,47),XYZt(:,32),XYZt(:,29),...
    XYZt(:,28),XYZt(:,17),XYZt(:,19),XYZt(:,17),XYZt(:,18),XYZt(:,17),XYZt(:,28),...
    XYZt(:,26),XYZt(:,30),XYZt(:,26),XYZt(:,25),XYZt(:,36),XYZt(:,25),XYZt(:,27),...
    XYZt(:,25),XYZt(:,36),XYZt(:,37),XYZt(:,30),XYZt(:,31),XYZt(:,32),XYZt(:,47),...
    XYZt(:,46),XYZt(:,23),XYZt(:,24),XYZt(:,21),XYZt(:,20),XYZt(:,9),XYZt(:,10),...
    XYZt(:,12),XYZt(:,13),XYZt(:,16),XYZt(:,13),XYZt(:,6),XYZt(:,7),XYZt(:,8),...
    XYZt(:,59),XYZt(:,8),XYZt(:,7),XYZt(:,54),XYZt(:,7),XYZt(:,6),XYZt(:,2),...
    XYZt(:,4),XYZt(:,33),XYZt(:,4),XYZt(:,5),XYZt(:,8),XYZt(:,5),XYZt(:,38),...
    XYZt(:,5),XYZt(:,4),XYZt(:,2),XYZt(:,1),XYZt(:,12),XYZt(:,10),XYZt(:,14),...
    XYZt(:,10),XYZt(:,12),XYZt(:,1),XYZt(:,3),XYZt(:,11),XYZt(:,9),XYZt(:,10),XYZt(:,12),XYZt(:,1),XYZt(:,3),XYZt(:,35)];
figure(1)
C60model=plot3(RV(1,:),RV(2,:),RV(3,:),'-o','color','r','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',8);
axis([-8 8 -8 8 -8 8]);
axis equal;
drawnow;

%%
for n= 1:Nc
    
   ic=ceil(rand*60);
   dx=0.01*(rand-0.5);
   dy=0.01*(rand-0.5);
   dz=0.01*(rand-0.5);
   
   XYZnew=XYZ;
   XYZnew(ic,1)= XYZ(ic,1)+dx;
   XYZnew(ic,2)= XYZ(ic,2)+dy;
   XYZnew(ic,3)= XYZ(ic,3)+dz;
   
   r=XYZnew(ic,:);
   r1=XYZnew(Mdist(ic,2),:);
   r2=XYZnew(Mdist(ic,3),:);
   r3=XYZnew(Mdist(ic,4),:);
   
   Mdistnew(:,1:4)=Mdist(:,1:4);
   Mangnew(:,1:4)=Mang(:,1:4);
   Mvectornew(:,1:4)=Mvector(:,1:4);
   for i=1:60
          switch i
              case ic
                  Mdistnew(i,5)=norm(r1-r);
                  Mdistnew(i,6)=norm(r2-r);
                  Mdistnew(i,7)=norm(r3-r);
                  Mvectornew(i,5:7)=(r1-r)/norm(r-r1);
                  Mvectornew(i,8:10)=(r2-r)/norm(r-r2);
                  Mvectornew(i,11:13)=(r3-r)/norm(r-r3);
                  Mangnew(i,5)=acos(((r1-r)*(r2-r)')/(norm(r1-r)*norm(r2-r)));
                  Mangnew(i,6)=acos(((r2-r)*(r3-r)')/(norm(r2-r)*norm(r3-r)));
                  Mangnew(i,7)=acos(((r3-r)*(r1-r)')/(norm(r1-r)*norm(r3-r)));
                 
              case Mdist(ic,2)
                  if Mdist(i,2)==ic
                      Mdistnew(i,5)=norm(r-r1);
                      Mdistnew(i,6)=Mdist(i,6);
                      Mdistnew(i,7)=Mdist(i,7);
                      r4=XYZnew(Mdist(i,3),:);
                      r5=XYZnew(Mdist(i,4),:);
                      Mvectornew(i,5:7)=(r-r1)/norm(r-r1);
                      Mvectornew(i,8:10)=Mvector(i,8:10);
                      Mvectornew(i,11:13)=Mvector(i,11:13);
                      Mangnew(i,5)=acos(((r-r1)*(r4-r1)')/(norm(r-r1)*norm(r4-r1)));
                      Mangnew(i,6)=Mang(i,6);
                      Mangnew(i,7)=acos(((r5-r1)*(r-r1)')/(norm(r-r1)*norm(r5-r1)));
                  else
                      if Mdist(i,3)==ic
                           Mdistnew(i,5)=Mdist(i,5);
                           Mdistnew(i,6)=norm(r-r1);
                           Mdistnew(i,7)=Mdist(i,7);
                           r4=XYZnew(Mdist(i,2),:);
                           r5=XYZnew(Mdist(i,4),:);
                           Mvectornew(i,5:7)=Mvector(i,5:7);
                           Mvectornew(i,8:10)=(r-r1)/norm(r-r1);
                           Mvectornew(i,11:13)=Mvector(i,11:13);
                           Mangnew(i,5)=acos(((r4-r1)*(r-r1)')/(norm(r-r1)*norm(r4-r1)));
                           Mangnew(i,6)=acos(((r-r1)*(r5-r1)')/(norm(r-r1)*norm(r5-r1)));
                           Mangnew(i,7)=Mang(i,7);
                      else
                           Mdistnew(i,5)=Mdist(i,5);
                           Mdistnew(i,6)=Mdist(i,6);
                           Mdistnew(i,7)=norm(r-r1);
                           r4=XYZnew(Mdist(i,2),:);
                           r5=XYZnew(Mdist(i,3),:);
                           Mvectornew(i,5:7)=Mvector(i,5:7);
                           Mvectornew(i,8:10)=Mvector(i,8:10);
                           Mvectornew(i,11:13)=(r-r1)/norm(r-r1);
                           Mangnew(i,5)=Mang(i,5);
                           Mangnew(i,6)=acos(((r5-r1)*(r-r1)')/(norm(r-r1)*norm(r5-r1)));
                           Mangnew(i,7)=acos(((r-r1)*(r4-r1)')/(norm(r-r1)*norm(r4-r1)));
                      end
                  end
                  
              case Mdist(ic,3)
                  if Mdist(i,2)==ic
                      Mdistnew(i,5)=norm(r-r2);
                      Mdistnew(i,6)=Mdist(i,6);
                      Mdistnew(i,7)=Mdist(i,7);
                      r4=XYZnew(Mdist(i,3),:);
                      r5=XYZnew(Mdist(i,4),:);
                      Mvectornew(i,5:7)=(r-r2)/norm(r-r2);
                      Mvectornew(i,8:10)=Mvector(i,8:10);
                      Mvectornew(i,11:13)=Mvector(i,11:13);
                      Mangnew(i,5)=acos(((r-r2)*(r4-r2)')/(norm(r-r2)*norm(r4-r2)));
                      Mangnew(i,6)=Mang(i,6);
                      Mangnew(i,7)=acos(((r5-r2)*(r-r2)')/(norm(r-r2)*norm(r5-r2)));
                  else
                      if Mdist(i,3)==ic
                           Mdistnew(i,5)=Mdist(i,5);
                           Mdistnew(i,6)=norm(r-r2);
                           Mdistnew(i,7)=Mdist(i,7);
                           r4=XYZnew(Mdist(i,2),:);
                           r5=XYZnew(Mdist(i,4),:);
                           Mvectornew(i,5:7)=Mvector(i,5:7);
                           Mvectornew(i,8:10)=(r-r2)/norm(r-r2);
                           Mvectornew(i,11:13)=Mvector(i,11:13);
                           Mangnew(i,5)=acos(((r4-r2)*(r-r2)')/(norm(r-r2)*norm(r4-r2)));
                           Mangnew(i,6)=acos(((r-r2)*(r5-r2)')/(norm(r-r2)*norm(r5-r2)));
                           Mangnew(i,7)=Mang(i,7);
                      else
                           Mdistnew(i,5)=Mdist(i,5);
                           Mdistnew(i,6)=Mdist(i,6);
                           Mdistnew(i,7)=norm(r-r2);
                           r4=XYZnew(Mdist(i,2),:);
                           r5=XYZnew(Mdist(i,3),:);
                           Mvectornew(i,5:7)=Mvector(i,5:7);
                           Mvectornew(i,8:10)=Mvector(i,8:10);
                           Mvectornew(i,11:13)=(r-r2)/norm(r-r2);
                           Mangnew(i,5)=Mang(i,5);
                           Mangnew(i,6)=acos(((r5-r2)*(r-r2)')/(norm(r-r2)*norm(r5-r2)));
                           Mangnew(i,7)=acos(((r-r2)*(r4-r2)')/(norm(r-r2)*norm(r4-r2)));
                           
                      end
                  end
                  
                     case Mdist(ic,4)
                  if Mdist(i,2)==ic
                      Mdistnew(i,5)=norm(r-r3);
                      Mdistnew(i,6)=Mdist(i,6);
                      Mdistnew(i,7)=Mdist(i,7);
                      r4=XYZnew(Mdist(i,3),:);
                      r5=XYZnew(Mdist(i,4),:);
                      Mvectornew(i,5:7)=(r-r3)/norm(r-r3);
                      Mvectornew(i,8:10)=Mvector(i,8:10);
                      Mvectornew(i,11:13)=Mvector(i,11:13);
                      Mangnew(i,5)=acos(((r-r3)*(r4-r3)')/(norm(r-r3)*norm(r4-r3)));
                      Mangnew(i,6)=Mang(i,6);
                      Mangnew(i,7)=acos(((r5-r3)*(r-r3)')/(norm(r-r3)*norm(r5-r3)));
                  else
                      if Mdist(i,3)==ic
                           Mdistnew(i,5)=Mdist(i,5);
                           Mdistnew(i,6)=norm(r-r3);
                           Mdistnew(i,7)=Mdist(i,7);
                           r4=XYZnew(Mdist(i,2),:);
                           r5=XYZnew(Mdist(i,4),:);
                           Mvectornew(i,5:7)=Mvector(i,5:7);
                           Mvectornew(i,8:10)=(r-r3)/norm(r-r3);
                           Mvectornew(i,11:13)=Mvector(i,11:13);
                           Mangnew(i,5)=acos(((r4-r3)*(r-r3)')/(norm(r-r3)*norm(r4-r3)));
                           Mangnew(i,6)=acos(((r-r3)*(r5-r3)')/(norm(r-r3)*norm(r5-r3)));
                           Mangnew(i,7)=Mang(i,7);
                      else
                           Mdistnew(i,5)=Mdist(i,5);
                           Mdistnew(i,6)=Mdist(i,6);
                           Mdistnew(i,7)=norm(r-r3);
                           r4=XYZnew(Mdist(i,2),:);
                           r5=XYZnew(Mdist(i,3),:);
                           Mvectornew(i,5:7)=Mvector(i,5:7);
                           Mvectornew(i,8:10)=Mvector(i,8:10);
                           Mvectornew(i,11:13)=(r-r3)/norm(r-r3);
                           Mangnew(i,5)=Mang(i,5);
                           Mangnew(i,6)=acos(((r5-r3)*(r-r3)')/(norm(r-r3)*norm(r5-r3)));
                           Mangnew(i,7)=acos(((r-r3)*(r4-r3)')/(norm(r-r3)*norm(r4-r3)));
                      end
                  end
                  
              otherwise
                           Mdistnew(i,5:7)=Mdist(i,5:7);
                           Mangnew(i,5:7)=Mang(i,5:7);
                           Mvectornew(i,5:13)=Mvector(i,5:13);
          end     
   end
   
   Unew=TOTAL_ENRG(kr,kt,r0sng,r0dbl,t0a,t0b,Mdistnew,XYZnew,Mangnew);
   dU=Unew-Uo;
   rn=rand(1);
   if dU>0
       if exp(-dU)>rn
           Uo=Unew;
           XYZ=XYZnew;
           Mdist=Mdistnew;
           Mang=Mangnew;
           Mvector=Mvectornew;
       else
           Unew=Uo;
           XYZnew=XYZ;
           Mdistnew=Mdist;
           Mangnew=Mang;
           Mvectornew=Mvector;
       end
   else
       Uo=Unew;
       XYZ=XYZnew;
       Mdist=Mdistnew;
       Mang=Mangnew;
       Mvector=Mvectornew;
   end

if count==100
    count=1;
    UV(1,n/100+1)=Unew;
    rgV(1,n/100+1)=GYRATION_RADIUS(XYZnew);
%% Graphics
XYZt=XYZnew';
RV=[XYZt(:,1),XYZt(:,3),XYZt(:,11),XYZt(:,19),XYZt(:,27),XYZt(:,35),XYZt(:,33),...
    XYZt(:,34),XYZt(:,36),XYZt(:,37),XYZt(:,40),XYZt(:,43),XYZt(:,57),XYZt(:,60),...
    XYZt(:,56),XYZt(:,53),XYZt(:,59),XYZt(:,58),XYZt(:,57),XYZt(:,43),XYZt(:,42),...
    XYZt(:,41),XYZt(:,47),XYZt(:,46),XYZt(:,23),XYZt(:,24),XYZt(:,51),XYZt(:,50),...
    XYZt(:,49),XYZt(:,52),XYZt(:,56),XYZt(:,53),XYZt(:,54),XYZt(:,55),XYZt(:,49),...
    XYZt(:,50),XYZt(:,51),XYZt(:,45),XYZt(:,46),XYZt(:,47),...
    XYZt(:,41),XYZt(:,44),XYZt(:,60),XYZt(:,44),XYZt(:,48),XYZt(:,45),XYZt(:,51),...
    XYZt(:,50),XYZt(:,15),XYZt(:,16),XYZt(:,55),XYZt(:,16),XYZt(:,15),XYZt(:,14),XYZt(:,21),...
    XYZt(:,20),XYZt(:,18),XYZt(:,22),XYZt(:,23),XYZt(:,22),XYZt(:,29),XYZt(:,32),...
    XYZt(:,47),XYZt(:,32),XYZt(:,31),XYZt(:,42),XYZt(:,31),XYZt(:,30),XYZt(:,37),...
    XYZt(:,36),XYZt(:,34),XYZt(:,38),XYZt(:,39),XYZt(:,40),XYZt(:,39),XYZt(:,58),...
    XYZt(:,57),XYZt(:,60),XYZt(:,44),XYZt(:,48),XYZt(:,45),XYZt(:,46),XYZt(:,45),...
    XYZt(:,48),XYZt(:,52),XYZt(:,48),XYZt(:,45),XYZt(:,46),XYZt(:,47),XYZt(:,32),XYZt(:,29),...
    XYZt(:,28),XYZt(:,17),XYZt(:,19),XYZt(:,17),XYZt(:,18),XYZt(:,17),XYZt(:,28),...
    XYZt(:,26),XYZt(:,30),XYZt(:,26),XYZt(:,25),XYZt(:,36),XYZt(:,25),XYZt(:,27),...
    XYZt(:,25),XYZt(:,36),XYZt(:,37),XYZt(:,30),XYZt(:,31),XYZt(:,32),XYZt(:,47),...
    XYZt(:,46),XYZt(:,23),XYZt(:,24),XYZt(:,21),XYZt(:,20),XYZt(:,9),XYZt(:,10),...
    XYZt(:,12),XYZt(:,13),XYZt(:,16),XYZt(:,13),XYZt(:,6),XYZt(:,7),XYZt(:,8),...
    XYZt(:,59),XYZt(:,8),XYZt(:,7),XYZt(:,54),XYZt(:,7),XYZt(:,6),XYZt(:,2),...
    XYZt(:,4),XYZt(:,33),XYZt(:,4),XYZt(:,5),XYZt(:,8),XYZt(:,5),XYZt(:,38),...
    XYZt(:,5),XYZt(:,4),XYZt(:,2),XYZt(:,1),XYZt(:,12),XYZt(:,10),XYZt(:,14),...
    XYZt(:,10),XYZt(:,12),XYZt(:,1),XYZt(:,3),XYZt(:,11),XYZt(:,9),XYZt(:,10),XYZt(:,12),XYZt(:,1),XYZt(:,3),XYZt(:,35)];
set(C60model,'xdata',RV(1,:),'ydata',RV(2,:),'zdata',RV(3,:));
drawnow;

else
    count=count+1;
end

end
%%
ii=(0:Nc/100)*100;
figure(2);
plot(ii(:),UV(1,:),'o','Color','b');
xlabel('N[-]') 
ylabel('U[Kt]')
title('àðøâéä ëôåð÷öéä ùì ëîåú äîçæåøéí')

figure(3);
plot(ii(:),rgV(1,:),'o','Color','k');
xlabel('N[-]') 
ylabel('Rg[nm]')
title('îøç÷ äàèåîéí ëôåð÷öéä ùì ëîåú äîçæåøéí')


function U=TOTAL_ENRG(kr,kt,r0sng,r0dbl,t0a,t0b,Mdist,XYZ,Mang)
%% 1

Ur=0;
for i=1:60
    for j=5:7
        if j==5
            Ur=Ur+kr*0.25*(Mdist(i,j)-r0dbl)^2;
        else 
            Ur=Ur+kr*0.25*(Mdist(i,j)-r0sng)^2;
        end
    end   
end

%% 2
Up=0;

ii=[1,2,6,13,12];
jj=[41,47,32,31,42];
for i=1:5
    Rij=norm(XYZ(ii(i),:)- XYZ(jj(i),:));
    Up=Up+10*kr*(Rij-4)^2;
end

%% bonus
Ut=0;

for i=1:60
    for j=5:7
        if j==6
            Ut=Ut+kt*0.25*(Mang(i,j)-t0b)^2;
        else 
            Ut=Ut+kt*0.25*(Mang(i,j)-t0a)^2;
        end
    end   
end


U=Ur+Up+Ut;
end

%%
function rg=GYRATION_RADIUS(XYZ)

rm=zeros(1,3);
rg=0;
for i=1:60
    rm=rm+(1/60)*XYZ(i,:);
end
for i=1:60
    rg=rg+norm(XYZ(i,:)-rm)^2;
end
rg=((1/60)*rg)^0.5;
end
