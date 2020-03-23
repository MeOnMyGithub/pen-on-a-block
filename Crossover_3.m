function [ Kinder ] = Crossover_3( Eltern )
% Crossoverfunktion 3 (vgl. Skript_Gutenbrunner S.14):
% - Schnitt an zwei Stellen
% - Übernahme des Mittelteils des jeweiligen anderen Elternteils
% - Umordnung der restlichen Städte nach einem bestimmten Schema (Kind entspricht umsortiertem Elternteil)

    global nStaedte;

    %% Ermittlung zweier Schnittstellen per Zufallsgenerator
        Schnitt1 = ceil(rand * (nStaedte-1));
        Schnitt2 = ceil(rand * (nStaedte-1));
        % erneute Ermittlung der zweiten Schnittstelle, falls beide Schnittstellen übereinstimmen
        while (Schnitt1 == Schnitt2)
            Schnitt2 = ceil(rand * (nStaedte-1));
        end
        % Sortieren der Schnittstellen nach "Größe", sodass stets gilt Schnitt1 < Schnitt2
        if (Schnitt1 > Schnitt2)
            save = Schnitt1;
            Schnitt1 = Schnitt2;
            Schnitt2 = save;
        end
        % Ermittlung des Mittelbereichs zwischen beiden Schnittstellen
        Mitte(1,:) = Eltern(2,Schnitt1+1:Schnitt2);
        Mitte(2,:) = Eltern(1,Schnitt1+1:Schnitt2);
        
    %% Erzeugung der Kinder 
        % Umsortieren der Elternindividuen
        Eltern(1,:) = [Eltern(1,Schnitt2+1:end), Eltern(1,1:Schnitt2)];
        Eltern(2,:) = [Eltern(2,Schnitt2+1:end), Eltern(2,1:Schnitt2)];
        Kind1 = Eltern(1,:);
        Kind2 = Eltern(2,:);
        % Streichen der Mittelteile des anderen Elternteils aus Kindern
        for (i = 1 : 2)
            % Erzeugung eines Vektors mit den Positionen der aus dem Kind zu löschenden Städte
            loeschen = zeros(1,size(Mitte,2)); 
            % Schreiben aller Städte des Mittelteils in den Vektor loeschen
            for(k = 1 : size(Mitte,2))
                Position = find(Eltern(i,:) == Mitte(i,k));
                loeschen(k) = Position;
            end
            % Sortieren der Positionen im Vektor loeschen in absteigender Reihenfolge
            loeschen = sort(loeschen,'descend');
            % Streichen aller Städte, die sich an den Positionen aus loeschen befinden, aus Kindern
            for (l = 1 : size(loeschen,2))
                if(i == 1)
                    Kind1(loeschen(l)) = [];
                else
                    Kind2(loeschen(l)) = [];
                end
            end
        end
        % Umsortierung beider Kinder, Einfügen des Mittelteils
        Kind1 = [Kind1(size(Kind1,2)-Schnitt1:end), Mitte(1,:), Kind1(1:size(Kind1,2)-Schnitt1-1)];
        Kind2 = [Kind2(size(Kind2,2)-Schnitt1:end), Mitte(2,:), Kind2(1:size(Kind2,2)-Schnitt1-1)];
        
    %% Speichern beider Kinder in einer gemeinsamen Matrix
        Kinder = [Kind1;Kind2];
end

