function [data]=genOne(A,notation,n)
%erstellt die erste Generation an Lösungen

if strcmp(notation,'path')
    [m,~]=size(A);
    data=zeros(2*n,m);
    tupel=1:m;
    for k=1:2*n
        tupeltemp=tupel;
        for o=1:m
            r=randi(m-o+1);
            data(k,o)=tupeltemp(r);
            tupeltemp(r)=[];
        end
    end
    
elseif notation==strcmp(notation,'cycle')
    
    data=1;
    
    
else
    
    data=0;
end


end

