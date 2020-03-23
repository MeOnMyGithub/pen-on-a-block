function [ Kinder ] = Crossover_1( Eltern )
% Crossoverfunktion 1 (vgl. Skript_Gutenbrunner S. 16):
% - Schnitt an einer Stelle
% - Übernahme des ersten Schnittteils des einen Elternteils
% - Anordnung der restlichen Städte entsprechend deren Vorkommen im anderen Elternteil

    global nStaedte;
    
 %% Ermittlung der Schnittstelle per Zufallsgenerator (Schnitt vor letztem Element nicht sinnvoll (ansonsten Elternteil = Kind) --> nStaedte-2)
    Schnitt = ceil(rand * (nStaedte - 2));
    
 %% Erzeugung von Kind 1
    % erster Teil von Kind 1 entspricht dem Teil vor der Schnittstelle von Elternteil 1
    Kind1(1:Schnitt) = Eltern(1, 1:Schnitt);
    % Anordnung der restlichen (noch nicht im ersten Teil vorkommenden) Städte entsprechend deren Reihenfolge im Elternteil 2
    for (i = 1 : nStaedte)
        if (ismember(Eltern(2,i),Kind1) == false)
            Kind1(end+1) = Eltern(2,i);
        end
        % Abbruch des Vorgangs, sobald alle Städte im Kind enthalten sind
        if (size(Kind1,2) == nStaedte)
            break;
        end
    end
    
 %% Erzeugung von Kind 2
    % erster Teil von Kind 2 entspricht dem Teil vor der Schnittstelle von Elternteil 2
    Kind2(1:Schnitt) = Eltern(2, 1:Schnitt);
    % Anordnung der restlichen (noch nicht im ersten Teil vorkommenden) Städte entsprechend deren Reihenfolge im Elternteil 1
    for (i = 1 : nStaedte)
        if ( ismember(Eltern(1,i),Kind2) == false )
            Kind2(end+1) = Eltern(1,i);
        end
        % Abbruch des Vorgangs, sobald alle Städte im Kind enthalten sind
        if (size(Kind2,2) == nStaedte)
            break;
        end
    end
    
%% Speichern beider Kinder in einer gemeinsamen Matrix
    Kinder = [Kind1;Kind2];
end
    

