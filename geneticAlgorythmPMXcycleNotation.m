clc
clear all
close all

%% Initialisierung

%Anzahl an Lösungen pro Generation
n=40;

%Anzahl der Chromosome
nchr=4;

%Die Entfernungsmatrix
A=[999 4.5 3.25 2.75 4 3.25 1.25 2 3.75 5 2.75 3.5 2.25 3.5 3;...
    2.75 999 4 1.5 3.25 2.5 4.25 3.5 2.25 3.5 4.75 4.75 1.25 1.25 4.75;...
    1.25 2 999  5 3.75 2.5 2.25 1.5 3.5 2.25 1.5 2.5 3 5 2.5;...
    2.75 4.25 4.25 999  1.25 1.5 4.75 4 5 1.25 3.5 3.25 4 5 3;...
    2 2 3.5 4.5 999  2 1.5 2 2.75 1.25 1.25 2.5 2 4.75 1.5;...
    3.5 3.75 3.75 3 1.25 999  4.75 1.75 3.5 2.75 2.25 1.75 2.25 3.75 2.75;...
    1.25 5 2 4.5 2.75 5 999 2.5 4 3.25 3.25 3.25 2.25 4 1.25;...
    2.25 4 2.5 3 4.5 5 4.5 999  3.25 3.5 2.75 1.25 3.5 4 3.75;...
    3.75 3.5 4.25 4.75 4.5 1.75 1.75 1.5 999 2.5 4 3.75 1.5 1.25 1.25;...
    3.25 2.25 2.5 3.75 3.25 1.75 2.5 4.5 2.5 999  2 2.5 1.75 1.25 4.75;...
    1.75 3 4.75 4.25 4.75 5 4.25 4.25 2.25 3 999  4.5 4.25 5 2.75;...
    1.5 3.25 3.25 4.5 2.75 2 3.75 1.5 1.5 1.75 3.75 999  2.75 4.75 2;...
    3 3.75 1.75 4.75 2.75 2.25 4.25 3.75 1.5 1.5 3 3.5 999  2.5 4.75;...
    4 2 3.5 3.5 2.5 4 4.5 3.75 5 3.75 4. 2.5 5 999  1.75;...
    3.5 1.25 5 1.75 3.5 3.25 2.5 1.25 5 2 4.75 1.75 4.5 4.5 999 ];

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
for k=1:n
    for o=1:m
        length=length+A(o,data(k,o));
    end
    fitness(k)=length;
    length=0;
end

%%  partially matched crossover

for k=1:1500
    
    %Temporären Datensatz schaffen
%   datatemp(1:n-2,:)=data(1:n-2,:);
    datatemp=[zeros(n-2,m);datatemp(n-1:n,:)];
    
    %Evaluation der Fitness
    for f=1:n
        for o=1:m
            length=length+A(o,data(f,o));
        end
        fitness(f)=length;
        length=0;
    end
    
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
    o=1;
    while o<=n/2-1
        wahl=randi(nchr);
        
        %Bestimmung der Eltern
        father=randi(n-2);
        mother=randi(n-2);
        
        %Bestimmung der Chromosome
        switch1(1:end)=[data(father , chr(wahl)+1:chr(wahl+1) )...
            , zeros(ceil(m/nchr)-max(size(data(father , chr(wahl)+1:chr(wahl+1)))))];
        switch1=nonzeros( switch1);
        switch2(1:end)=[data(mother   , chr(wahl)+1:chr(wahl+1) )...
            , zeros(ceil(m/nchr)-max(size(data(mother   , chr(wahl)+1:chr(wahl+1)))))];
        switch2=nonzeros( switch2);
        
        %Abfrage auf gleiche Gene im Chromosom
        testcase=[unique([switch1,switch2]);...
            zeros(max(size([switch1;switch2]))-max(size(unique([switch1,switch2]))),1)];
        if testcase==sort([switch1;switch2])
            %Initialisierung der Kinder
            datatemp(2*o-1,:)=data(father,:);
            datatemp(2*o,:)=data(mother,:);
            %Matching der Gene des anderen Partners
            for p=1:max(size(switch1))
                tausch=find(data(father ,:) == switch2(p));
                datatemp(2*o-1,tausch)=switch1(p);
            end
            for p=1:max(size(switch2))
                tausch=find(data(mother ,:) == switch1(p));
                datatemp(2*o,tausch)=switch2(p);
            end
            
            %Übertragen des Chromosoms
            
            datatemp(2*o-1,chr(wahl)+1:chr(wahl+1))=switch2;
            datatemp(2*o,chr(wahl)+1:chr(wahl+1))=switch1;
            o=o+1;
        end
        
        switch1=zeros(ceil(m/nchr),1);
        switch2=zeros(ceil(m/nchr),1);
        
    end
    
    %Mutation mit 2-opt operator 
    for o=1:n-2
        rand1=randi(m);
        rand2=randi(m);
        
        %Inkrementierungsschritt
        if rand1==15
            rand1ink=1;
        else
            rand1ink=rand1+1;
        end
        
        if rand2==15
            rand2ink=1;
        else
            rand2ink=rand2+1;
        end
        
        %Wechsel der Knotenpunkte
        if (A(datatemp(o,rand1),datatemp(o,rand1ink))+ A(datatemp(o,rand2),datatemp(o,rand2ink)))...
                >  (A(datatemp(o,rand1),datatemp(o,rand2ink))+ A(datatemp(o,rand2),datatemp(o,rand1ink)))
            
            if rand1ink<rand2
                datatemp(o,rand1ink:rand2)=fliplr(datatemp(o,rand1ink:rand2));
            elseif rand1ink>rand2
                datatemp(o,rand2:rand1ink)=fliplr(datatemp(o,rand2:rand1ink));
            end        
        end    
    end
    
    
    data=datatemp;

end

hist(fitness)
