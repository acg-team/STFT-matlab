function [mapObj,inv_mapObj]=loadAAmap()

myKeys = {'A','R','N','D','C','Q','E','G','H','I','L','K','M','F','P','S','T','W','Y','V','-'};
myValues = 1:21;
mapObj = containers.Map(myKeys,myValues);

myKeys = 1:21;
myValues = {'A','R','N','D','C','Q','E','G','H','I','L','K','M','F','P','S','T','W','Y','V','-'};
inv_mapObj = containers.Map(myKeys,myValues);