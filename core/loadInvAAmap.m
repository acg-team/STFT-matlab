function mapObj=loadInvAAmap()

myKeys = 1:21;
myValues = {'A','R','N','D','C','Q','E','G','H','I','L','K','M','F','P','S','T','W','Y','V','-'}; 
mapObj = containers.Map(myKeys,myValues);