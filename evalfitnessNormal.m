function [ fitness ] = evalfitnessNormal( data, A )
%berechnet die Fitness der Lösungsvektoren in der normalen Notation

[n,m]=size(data);
fitness=zeros(n,1);
cost=0;

for k=1:n
    for o=1:m-1
        cost=cost+A(data(k,o),data(k,o+1));
    end
    cost=cost+A(data(k,m),data(k,1));
    fitness(k)=cost;
    cost=0;
end

end

