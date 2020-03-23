clc
clear all
close all

%% Initialisierung

%Anzahl an Lösungen pro Generation
n=10;

%Anzahl der Chromosome
nchr=4;

%Die Entfernungsmatrix
A=[0 4.5 3.25 2.75 4 3.25 1.25 2 3.75 5 2.75 3.5 2.25 3.5 3;...
    2.75 0 4 1.5 3.25 2.5 4.25 3.5 2.25 3.5 4.75 4.75 1.25 1.25 4.75;...
    1.25 2 0  5 3.75 2.5 2.25 1.5 3.5 2.25 1.5 2.5 3 5 2.5;...
    2.75 4.25 4.25 0  1.25 1.5 4.75 4 5 1.25 3.5 3.25 4 5 3;...
    2 2 3.5 4.5 0  2 1.5 2 2.75 1.25 1.25 2.5 2 4.75 1.5;...
    3.5 3.75 3.75 3 1.25 0  4.75 1.75 3.5 2.75 2.25 1.75 2.25 3.75 2.75;...
    1.25 5 2 4.5 2.75 5 0 2.5 4 3.25 3.25 3.25 2.25 4 1.25;...
    2.25 4 2.5 3 4.5 5 4.5 0  3.25 3.5 2.75 1.25 3.5 4 3.75;...
    3.75 3.5 4.25 4.75 4.5 1.75 1.75 1.5 0 2.5 4 3.75 1.5 1.25 1.25;...
    3.25 2.25 2.5 3.75 3.25 1.75 2.5 4.5 2.5 0  2 2.5 1.75 1.25 4.75;...
    1.75 3 4.75 4.25 4.75 5 4.25 4.25 2.25 3 0  4.5 4.25 5 2.75;...
    1.5 3.25 3.25 4.5 2.75 2 3.75 1.5 1.5 1.75 3.75 0  2.75 4.75 2;...
    3 3.75 1.75 4.75 2.75 2.25 4.25 3.75 1.5 1.5 3 3.5 0  2.5 4.75;...
    4 2 3.5 3.5 2.5 4 4.5 3.75 5 3.75 4. 2.5 5 0  1.75;...
    3.5 1.25 5 1.75 3.5 3.25 2.5 1.25 5 2 4.75 1.75 4.5 4.5 0 ];

[m,~]=size(A);

%Kantenvektor
tupel=1:m;

%Generationszähler
gencounter=1;

%Initialisierung des Lösungsspeicher
data=zeros(n,m);
fitness=zeros(n,1);

%Initialisierung der Chromosome
chr=zeros(nchr+1,1);
chr(1)=0;
for k=1:nchr
    chr(k+1)=tupel(ceil(m/nchr*k));
end

%Initialisierung Hilfsparameter
length=0;
switch1=zeros(ceil(m/nchr),1);
switch2=zeros(ceil(m/nchr),1);
datatemp=zeros(n,m);

%% Bestimmg des ersten Datensatzes

%Random Initialisierung der Lösungen der ersten Generation
for k=1:n
    tupeltemp=tupel;
    for o=1:m
        r=randi(m-o+1);
        data(k,o)=tupeltemp(r);
        tupeltemp(r)=[];
    end
end

%Evaluation der Fitness der ersten Generation
% for k=1:n
%     for o=1:m-1
%         length=length+A(data(k,o),data(k,o+1));
%     end
%     length=length+A(data(k,m),data(k,1));
%     fitness(k)=length;
%     length=0;
% end
fitness=evalfitnessNormal( data, A );

%%  partially matched crossover

for k=1:1500
    
    %Temporären Datensatz schaffen
    
    datatemp(1:n-2,:)=data(1:n-2,:);
    
    %Gencounter inkrementieren
    gencounter=gencounter+1;
    
    
    %Beste Lösung übernehmen
    sortiert=sort(fitness);
    ind1=find(fitness==(sortiert(1)));
    ind2=find(fitness==(sortiert(2)));
    if ind1==ind2
        datatemp(n-1,:)=data(ind1(1),:);
        datatemp(n,:)=data(ind1(2),:);
    else
        datatemp(n-1,:)=data(ind1(1),:);
        datatemp(n,:)=data(ind2(1),:);
    end
    
    %Schlechteste Lösung löschen
    sortiert=sort(fitness);
    ind1=find(fitness==(sortiert(n-1)));
    ind2=find(fitness==(sortiert(n)));
    if ind1==ind2
        data(ind1(1),:)=[];
        if ind1(1)<ind1(2)
            data(ind1(2)-1,:)=[];
        else
            data(ind1(2),:)=[];
        end
    else
        data(ind1(1),:)=[];
        if ind1(1)<ind2(1)
            data(ind2(1)-1,:)=[];
        else
            data(ind2(1),:)=[];
        end
    end
    
    %Chromosom wählen und tauschen
    for o=1:n/2-1
        wahl=randi(nchr);
        switch1(1:end)=[data(2*o-1 , chr(wahl)+1:chr(wahl+1) )...
            , zeros(ceil(m/nchr)-max(size(data(2*o-1 , chr(wahl)+1:chr(wahl+1)))))];
        switch1=nonzeros( switch1);
        switch2(1:end)=[data(2*o   , chr(wahl)+1:chr(wahl+1) )...
            , zeros(ceil(m/nchr)-max(size(data(2*o   , chr(wahl)+1:chr(wahl+1)))))];
        switch2=nonzeros( switch2);
        %Matching der Gene des anderen Partners
        for p=1:max(size(switch1))
            tausch=find(data(2*o-1 ,:) == switch2(p));
            datatemp(2*o-1,tausch)=switch1(p);
        end
        for p=1:max(size(switch2))
            tausch=find(data(2*o ,:) == switch1(p));
            datatemp(2*o,tausch)=switch2(p);
        end
        
        %Übertragen des Chromosoms
      
        datatemp(2*o-1,chr(wahl)+1:chr(wahl+1))=switch2;
        datatemp(2*o,chr(wahl)+1:chr(wahl+1))=switch1;

        
        switch1=zeros(ceil(m/nchr),1);
        switch2=zeros(ceil(m/nchr),1);
    end
    
    %Mutation mit 2-opt operator
    
    %     for o=1:n
    %        rand1=randi(m);
    %        rand2=randi(m);
    %        if A(datatemp(rand1,o),datatemp(rand1+1,o))+ A(datatemp(rand2,o),datatemp(rand2+1,o))...
    %              >  A(datatemp(rand1,o),datatemp(rand2+1,o))+ A(datatemp(rand2,o),datatemp(rand1+1,o))
    %
    %          temp=
    %
    %        else
    %
    %
    %        end
    %
    %     end
    
    
    data=datatemp;
    fitness=evalfitnessNormal( data, A );
end


hist(fitness)