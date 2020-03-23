function [ datatemp ]=mutation(mutationtype,data,rate)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[m,~]=size(data);

for k=1:ceil(m*rate/100)
    switch mutationtype
        case 0
            datatemp = Mutation_Punkt(data,1);
        case 1
            datatemp = Mutation_Punkt_Klonen(data);
        otherwise
            error('Error : keine gültige Mutationsart gewählt')
    end
end

end

