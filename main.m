clc
clear all
close all

%% Parameter Setting

tic

it=2000;                %Anzahl an Iterationen
nplot=it/25;              %plottet alle nplot Generationen
n=300;                  %Anzahl an Lösungen pro Generation
m=4;                    %Anzahl der beibehaltenen besten Lösungen
notation ='path';       %Art der Speicherung('cycle' oder 'path')
crossovertype='PMX';    %Art des crossover('PMX','CX',OX',MOX)
mutationtype=0;         %Art der Mutation
rate=30;                %Mutationsrate in %
aussortierrate=0.2;    %Anteil der schlechtesten Lösungen, gelöscht werden
matrix=5;               %Nummer der implementierten Matrix

% Einlesen der Datenmatrix
A=readin(matrix);

%% Initialisierung

% Population erstellen
data=genOne(A,notation,n);
% Fitness bestimmen
fitness=evalfitnessNormal( data, A );
% beste Chromosome finden
%best=
% Gencounter setzen
counter=0;
%Fitnessvektor initialisiern
fit=zeros(it,1);
%% Schleife
while counter<it
    % Gencounter erhöhen
    counter=counter+1;
    % Fitness bestimmen
    fitness=evalfitnessNormal( data, A );
    % gute Chromosome aus alter Generation auswählen und kopieren
    [data]=keepbest(data,m,fitness,n,aussortierrate);
    % Kinder erstellen
    datatemp=crossover(crossovertype,data);
    % Vereinung
    datages=[datatemp;data];
    % Mutation
    data=mutation(mutationtype,datages,rate);
    % Selektion

    % bestes Chromosom finden und behalten
    % data=keepbest(data,m,fitness);
    % gesamt Fitness in hist plotten
    if mod(counter,nplot)==0
        subplot(5,5,(counter/nplot))
        histogram(fitness)
    end
end
%% Auswertung
sort(fitness);
fitness(1)
toc