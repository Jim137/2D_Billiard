function [ballpx ballpy time] = ballscolliboundary(ballpx, ballpy, ballvx, ballvy, ballwx, ballwy, ballwz, time)
    r = 0.05715/2;
    m = 2;
    t(1) = 0;
    while 1
        t(m) = 0;
        for i = t(m-1)+2:length(time(1,:))
            for j = 1:length(ballpx(:,1))
                for k = 1:length(ballpx(:,1))
                    if(k>j)
                        if((ballpx(j,i)-ballpx(k,i))^2 + (ballpy(j,i)-ballpy(k,i))^2 <=4*r^2)
                            [v1x,v1y,v2x,v2y]=vafcolli2(ballpx(j,i), ballpy(j,i), ballpx(k,i), ballpy(k,i), ballvx(j,i), ballvy(j,i), ballvx(k,i), ballvy(k,i));
                            [ballpx1, ballpy1, ballvx1, ballvy1, ballwx1, ballwy1, ballwz1, time1] = move(ballpx(j,i), ballpy(j,i), v1x, v1y, ballwx(j,i), ballwy(j,i), ballwz(j,i));
                            [ballpx2, ballpy2, ballvx2, ballvy2, ballwx2, ballwy2, ballwz2, time2] = move(ballpx(k,i), ballpy(k,i), v2x, v2y, ballwx(k,i), ballwy(k,i), ballwz(k,i));
                            ballpx = matrixappend(matrixappend(ballpx(1:j-1,:),[ballpx(j,1:i) ballpx1]),ballpx(j+1:length(ballpx(:,1)),:));
                            ballpx = matrixappend(matrixappend(ballpx(1:k-1,:),[ballpx(k,1:i) ballpx2]),ballpx(k+1:length(ballpx(:,1)),:));
                            ballpy = matrixappend(matrixappend(ballpy(1:j-1,:),[ballpy(j,1:i) ballpy1]),ballpy(j+1:length(ballpy(:,1)),:));
                            ballpy = matrixappend(matrixappend(ballpy(1:k-1,:),[ballpy(k,1:i) ballpy2]),ballpy(k+1:length(ballpy(:,1)),:));
                            ballvx = matrixappend(matrixappend(ballvx(1:j-1,:),[ballvx(j,1:i) ballvx1]),ballvx(j+1:length(ballvx(:,1)),:));
                            ballvx = matrixappend(matrixappend(ballvx(1:k-1,:),[ballvx(k,1:i) ballvx2]),ballvx(k+1:length(ballvx(:,1)),:));
                            ballvy = matrixappend(matrixappend(ballvy(1:j-1,:),[ballvy(j,1:i) ballvy1]),ballvy(j+1:length(ballvy(:,1)),:));
                            ballvy = matrixappend(matrixappend(ballvy(1:k-1,:),[ballvy(k,1:i) ballvy2]),ballvy(k+1:length(ballvy(:,1)),:));
                            ballwx = matrixappend(matrixappend(ballwx(1:j-1,:),[ballwx(j,1:i) ballwx1]),ballwx(j+1:length(ballwx(:,1)),:));
                            ballwx = matrixappend(matrixappend(ballwx(1:k-1,:),[ballwx(k,1:i) ballwx2]),ballwx(k+1:length(ballwx(:,1)),:));
                            ballwy = matrixappend(matrixappend(ballwy(1:j-1,:),[ballwy(j,1:i) ballwy1]),ballwy(j+1:length(ballwy(:,1)),:));
                            ballwy = matrixappend(matrixappend(ballwy(1:k-1,:),[ballwy(k,1:i) ballwy2]),ballwy(k+1:length(ballwy(:,1)),:));
                            ballwz = matrixappend(matrixappend(ballwz(1:j-1,:),[ballwz(j,1:i) ballwz1]),ballwz(j+1:length(ballwz(:,1)),:));
                            ballwz = matrixappend(matrixappend(ballwz(1:k-1,:),[ballwz(k,1:i) ballwz2]),ballwz(k+1:length(ballwz(:,1)),:));
                            time = matrixappend(matrixappend(time(1:j-1,:),[time(j,1:i) time(j,i)+time1]),time(j+1:length(time(:,1)),:));
                            time = matrixappend(matrixappend(time(1:k-1,:),[time(k,1:i) time(k,i)+time2]),time(k+1:length(time(:,1)),:));
                            t(m) = i;
                        end
                    end
                end
            end
            if(t(m))
                break
            else
                continue
            end
        end
        if(t(m))
            m = m + 1;
            continue
        end
        if(i==length(time(1,:)))
            break
        end
    end
end