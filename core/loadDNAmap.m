function [mapObj,inv_mapObj]=loadDNAmap()

myKeys = {'A','C','G','T','-'};
myValues = 1:5;
mapObj = containers.Map(myKeys,myValues);

myKeys = 1:5;
myValues = {'A','C','G','T','-'};
inv_mapObj = containers.Map(myKeys,myValues);