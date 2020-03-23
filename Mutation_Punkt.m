function [ Indi ] = Mutation_Punkt( Indi, AnzahlPunkte )
% Mutationsfunktion 1: 
% - einfache Punktmutation Punktmutation (Vertauschung einzelner St�dte)
% - AnzahlPunkte: Anzahl an Vertauschungen pro Individuum
    
    [k,m]=size(Indi);
    global nStaedte;
    
    % Auswahl des Mutanten
    MutIndi = ceil(rand * size(Indi,1));
    for (i = 1 : AnzahlPunkte)
        % Auswahl der zu vertauschenden St�dte bzw. deren Positionen im Individuum
        Pos1 = ceil(rand * m);
        Pos2 = ceil(rand * m);
        % Pr�fen der Positionen auf Gleichheit
        while(Pos1 == Pos2)
            Pos2 = ceil(rand * m);
        end
        % Ermittlung der St�dte an den betreffenden Positionen
        Stadt1 = Indi(MutIndi,Pos1);
        Stadt2 = Indi(MutIndi,Pos2);
        % Vertauschen der St�dte
        Indi(MutIndi,Pos1) = Stadt2;
        Indi(MutIndi,Pos2) = Stadt1;
    end
     
end

