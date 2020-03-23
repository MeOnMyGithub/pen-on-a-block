function [Indi] = Mutation_Punkt(Indi)
% Mutationsfunktion 2:
% - einfache Punktmutation Punktmutation (Vertauschung einzelner Städte)
% - Klonen des Mutanten vor jeder Mutation
% - AnzahlPunkte: Anzahl an Vertauschungen pro Individuum

[k,m]=size(Indi);
global nStaedte;

% Auswahl des Mutanten
MutIndi = Indi(ceil(rand*size(Indi,1)),:);
% Auswahl der zu vertauschenden Städte bzw. deren Positionen im Individuum
Pos1 = ceil(rand * m);
Pos2 = ceil(rand * m);
% Prüfen der Positionen auf Gleichheit
while(Pos1==Pos2)
    Pos2 = ceil(rand * m);
end
% Ermittlung der Städte an den betreffenden Positionen
Stadt1 = MutIndi(Pos1);
Stadt2 = MutIndi(Pos2);
% Vertauschen der Städte
MutIndi(Pos1) = Stadt2;
MutIndi(Pos2) = Stadt1;
% Hinzufügen des mutierten Individuums zur restlichen Population
Indi = [Indi; MutIndi];

end

