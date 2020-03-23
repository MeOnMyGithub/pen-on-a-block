k=10;    
for o=1:m-1
        length=length+A(data(k,o),data(k,o+1));
    end
    length=length+A(data(k,m),data(k,1));
    fitness(k)=length;
  %  length=0;