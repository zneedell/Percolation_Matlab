function makeplot(hObject,hplot,hplot2,textlabel,threshtext)

global threshold
global corrmat
n = get(hObject,'Value');
threshold = n;
[ ~,nsize,biggestblob ] = CountBlobs( corrmat < threshold);
set(hplot,'Cdata',(corrmat<threshold)+ 2*biggestblob+2);
set(hplot2,'YData',(nsize/sum(nsize)));
S = strcat(['Biggest blob is ',num2str(nnz(biggestblob)),' pixels']);
set(textlabel, 'String', S);
SS = strcat(['Threshold set at ',num2str(n)]);
set(threshtext, 'String', SS);
drawnow;
end

