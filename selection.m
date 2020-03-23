function [ datatemp ] = selection( data,n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
            i = 1;
            while (i < size(data,1))
                length = size(data,1);
                for k = (i+1) : length
                    if (data(i,:) == data(length+i+1-k,:))
                        data(length+i+1-k,:) = [];
                    end
                end
                i = i + 1;
            end
    datatemp=data;
end

