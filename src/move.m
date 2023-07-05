function [ballpxf, ballpyf, ballvxf, ballvyf, ballwxf, ballwyf, ballwzf, timef] = move(x, y, vx, vy, wx, wy, wz)
   [ballpx, ballpy, ballvx, ballvy, ballwx, ballwy, ballwz, time] = move2d(x, y, vx, vy, wx, wy, wz);
   i = 1;
   bc = 0;
   while 1 
      iac=wallcollision(ballpx(i,:),ballpy(i,:),time(i,:),bc);
      ite(i) = iac(1); 
      colliside = iac(2);
      if(colliside == -1)
          break;
      elseif(colliside==0)
          break;
      end
      [v1x,v1y,w1x,w1y,w1z] = vafwallcolli(ballvx(i,ite(i)),ballvy(i,ite(i)),ballwx(i,ite(i)),ballwy(i,ite(i)),ballwz(i,ite(i)),colliside);
      [ballpx1, ballpy1, ballvx1, ballvy1, ballwx1, ballwy1, ballwz1, time1] = move2d(ballpx(i,ite(i)), ballpy(i,ite(i)), v1x, v1y, w1x, w1y, w1z);
      ballpx = matrixappend(ballpx, ballpx1);
      ballpy = matrixappend(ballpy, ballpy1);
      ballvx = matrixappend(ballvx, ballvx1);
      ballvy = matrixappend(ballvy, ballvy1);
      ballwx = matrixappend(ballwx, ballwx1);
      ballwy = matrixappend(ballwy, ballwy1);
      ballwz = matrixappend(ballwz, ballwz1);
      time = matrixappend(time, time1);
      i = i + 1;
      bc = colliside;
   end
   if(ite(1))
       ballpxf = [ballpx(1,1:ite(1))];
       ballpyf = [ballpy(1,1:ite(1))];
       ballvxf = [ballvx(1,1:ite(1))];
       ballvyf = [ballvy(1,1:ite(1))];
       ballwxf = [ballwx(1,1:ite(1))];
       ballwyf = [ballwy(1,1:ite(1))];
       ballwzf = [ballwz(1,1:ite(1))];
       timef = [time(1,1:ite(1))];
       for j = 2:length(time(:,1))
          if(ite(j) == 0)
              ite(j) = length(time(j,:));
          end
          ballpxf = [ballpxf ballpx(j,1:ite(j))];
          ballpyf = [ballpyf ballpy(j,1:ite(j))];
          ballvxf = [ballvxf ballvx(j,1:ite(j))];
          ballvyf = [ballvyf ballvy(j,1:ite(j))];
          ballwxf = [ballwxf ballwx(j,1:ite(j))];
          ballwyf = [ballwyf ballwy(j,1:ite(j))];
          ballwzf = [ballwzf ballwz(j,1:ite(j))];
          timef = [timef timef(length(timef))+time(j,1:ite(j))];
       end
   else
       ballpxf = ballpx;
       ballpyf = ballpy;
       ballvxf = ballvx;
       ballvyf = ballvy;
       ballwxf = ballwx;
       ballwyf = ballwy;
       ballwzf = ballwz;
       timef = time;
   end
end