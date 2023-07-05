function output=matrixappend(a,b)
    if size(a,2)<size(b,2)
        if(size(a,1))
            n=size(b,2);
            aa=a(:,length(a(1,:)))*ones(1,size(b,2));
            aa(:,1:size(a,2))=a(:,1:size(a,2));
            output=[aa;b];
        else
            output = [b];
        end
    elseif size(a,2)>size(b,2)
        if(size(b,1))
            n=size(a,2);
            bb=b(:,length(b(1,:)))*ones(1,size(a,2));
            bb(:,1:size(b,2))=b(:,1:size(b,2));
            output=[a;bb];
        else
            output = [a];
        end
    else
        output = [a;b];
    end
end