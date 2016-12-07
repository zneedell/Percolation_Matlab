function UpdateRandSeed( hObject,randmat,hplot,hplot2,blobtxt,corrtext )
global threshold
global corrmat
corrdist =  get(hObject,'Value');
if corrdist == 0
    corrmat = randmat;
else
    alpha = 1/corrdist;
    corrmat = AddCorrelations(randmat,alpha);
end
[ ~,nsize,biggestblob] = CountBlobs( corrmat < threshold);
set(hplot,'Cdata',(corrmat<threshold)+ 2*biggestblob+2);
set(hplot2,'YData',(nsize/sum(nsize)));
S = strcat(['Biggest blob is ',num2str(nnz(biggestblob)),' pixels']);
set(blobtxt, 'String', S);
SSS = strcat(['Correlation Distance: ',num2str(corrdist,3),'pixels']);
set(corrtext, 'String', SSS);
end

