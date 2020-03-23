function [ data ] = keepbest( data,m,fitness,n,a)
% speichert die besten n Lösungen der Lösungsmenge an den ersten n Stellen

A=[data,fitness];

[~,k]=size(data);

datatemp=sortrows(A,k+1);

databest=datatemp(1:m,1:k);
data=zeros(n-m,k);

for t=1:(n-m)
    [b,~]=size(datatemp);
    ran=randi([m+1,b-floor(a*b)]);
    data(t,:)=datatemp(ran,1:k);
    datatemp(ran,:)=[];
end

data=[databest;data];

end

