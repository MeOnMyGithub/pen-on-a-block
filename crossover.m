function [ datatemp ] = crossover( crossovertype,data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if strcmp(crossovertype,'PMX')
    
    [k,m]=size(data);
    datatemp=data;
    for o=1:(k/2)
        [a,~]=size(data);
        %Bestimmung der Eltern
        fat=1;
        mot=1;
        while fat == mot
            fat=randi(a);
            mot=randi(a);
        end
        
        %Bestimmung der Tauschgrenzen
        breite=floor(0.25*m);
        lower=randi(m-breite);
        upper=lower+breite;
        %randi([floor(lower+1),m]);
        
        %Bestimmung der Werte zwischen den Grenzen
        father=zeros(1,m);
        mother=zeros(1,m);
        father(lower:upper)=data(mot,lower:upper);
        mother(lower:upper)=data(fat,lower:upper);
        %% Werte für den Vater
        %untere Werte für Vater
        for i=1:lower-1
            %Überprüfung ob der jeweils nächste einzusetzende Wert bereits im Weg vorhanden ist
            if isempty(find(father==data(fat,i), 1))
                father(i)=data(fat,i);
            else
                %Fall, dass der einzusetzende Wert bereits im Weg vorhanden
                %ist. Jetzt werden die Tauschoperatoren der Mittelwerte
                %angewandt.
                wert=data(fat,i);
                while ~(isempty(find(father==wert, 1)))
                    wert=mother(father==wert);
                end
                father(i)=wert;
            end
        end
        %obere Werte für Vater
        for i=upper+1:m
            if isempty(find(father==data(fat,i), 1))
                father(i)=data(fat,i);
            else
                wert=data(fat,i);
                while ~(isempty(find(father==wert, 1)))
                    wert=mother(father==wert);
                end
                father(i)=wert;
            end
        end
        %% Werte für die Mutter
        %untere Werte für Mutter
        for i=1:lower-1
            %Überprüfung ob der jeweils nächste einzusetzende Wert bereits im Weg vorhanden ist
            if isempty(find(mother==data(mot,i), 1))
                mother(i)=data(mot,i);
            else
                %Fall, dass der einzusetzende Wert bereits im Weg vorhanden
                %ist. Jetzt werden die Tauschoperatoren der Mittelwerte
                %angewandt.
                wert=data(mot,i);
                while ~(isempty(find(mother==wert, 1)))
                    wert=father(mother==wert);
                end
                mother(i)=wert;
            end
        end
        %obere Werte für Mutter
        for i=upper+1:m
            if isempty(find(mother==data(mot,i), 1))
                mother(i)=data(mot,i);
            else
                wert=data(mot,i);
                while ~(isempty(find(mother==wert, 1)))
                    wert=father(mother==wert);
                end
                mother(i)=wert;
            end
        end
        datatemp(2*o-1,:)=father;
        datatemp(2*o,:)=mother;
        data([fat,mot],:)=[];
        
        
    end
    
elseif strcmp(crossovertype,'OX')
    
    [k,m]=size(data);
    datatemp=data;
    for o=1:(k/2)
        Eltern=data((2*o-1):(2*o),:);
        [Kinder] = Crossover_1( Eltern );
        datatemp((2*o-1):(2*o),:)=Kinder;
    end
    
elseif strcmp(crossovertype,'CX')
    
    [k,m]=size(data);
    datatemp=data;
    for o=1:(k/2)
        Eltern=data((2*o-1):(2*o),:);
        [Kinder] = Crossover_2( Eltern );
        datatemp((2*o-1):(2*o),:)=Kinder;
    end
    
else
    
    
    datatemp=data;
    
end

end

