function [ Kinder ] = Crossover_2( Eltern )
% Crossoverfunktion 2 (vgl. Skript_Gutenbrunner S.13):
% - kein Schnitt
% - Position einer Stadt im Kind entspricht deren Position in Elternteil 1 oder in Elternteil 2

    global nStaedte;
   
  %% Ermittlung der Startstelle per Zufallsgenerator
    Start = ceil(rand * nStaedte);
  
  %% Erzeugung von Kind 1
    % Erstellen eines Nullvektors (Kind1)
    Kind1 = zeros(1,nStaedte);
    % Ermittlung der Stadt an ausgewählter Startposition im Elternteil 1
    Stadt = Eltern(1,Start);
    while (ismember(Stadt,Kind1) == 0)
        % Ermittlung der Position der jeweiligen Stadt im Elternteil 1 
        Position = find(Eltern(1,:) == Stadt);
        % Einfügen der Stadt an ermittelter Position in Kind 1 
        Kind1(Position) = Stadt;
        % Ermittlung der neuen "aktiven" Stadt (= Stadt, die sich an derselben Position in Elternteil 2 befindet)
        Stadt = Eltern(2,Position);
    end
    % Auffüllen der "leeren" (= noch mit 0 besetzten) Stellen des Kindes
    % Ermittlung der Position der "leeren" Stellen 
    Rest = find(Kind1 == 0);
    for (i = 1 : size(Rest,2))
        % Position der "aktiven" leeren Stelle
        Position = Rest(i);
        % Einfügen der Stadt aus der entsprechenden Position aus Elternteil 2 in Position von Kind 1
        Kind1(Position) = Eltern(2,Position);
    end
    
  %% Erzeugung von Kind 2
    % Erstellen eines Nullvektors (Kind1)
    Kind2 = zeros(1,nStaedte);
    % Ersetzen der Nullen durch Städte: Hat Kind 1 an der Position i die Stadt von Elternteil 1 übernommen, 
    % so bekommt Kind 2 an der Position i die Stadt von Elternteil 2 und umgekehrt.
    for (i = 1 : nStaedte)
        if (Kind1(i) == Eltern(1,i))
            Kind2(i) = Eltern(2,i);
        else
            Kind2(i) = Eltern(1,i);
        end
    end
    
  %% Speichern beider Kinder in einer gemeinsamen Matrix
    Kinder = [Kind1; Kind2];
end

