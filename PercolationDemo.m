%% GENERATE INITIAL CONDITIONS
% Set Global Variables (that will be updated via slide bars)
global threshold
global corrmat

% Generate matrix of random values between 0 and 1
randmat = rand(1000,1000,'single');
threshold = 0.58; % SET INITIAL THRESHOLD VALUE HERE
correldist = 0; % Set initial correlation distance
corrmat = randmat; % Start matrix with no correlation
biggestblob = 0; % No value for largest connected region (yet)


%% SET UP STEP-BY-STEP WINDOWS
step_one = figure('Name','Step One'); %Random Matrix
imagesc(randmat)
colormap('jet')
colorbar
step_two = figure('Name','Step Two'); %Binary Matrix
imagesc(randmat<threshold)
colormap('gray')
colorbar
[ blobsize,nsize,biggestblob,labeled ] = CountBlobs( corrmat < threshold);
step_three = figure('Name','Step Three'); % Labeled Binary Matrix
imagesc(labeled)
colorbar
colormap('jet')
step_four = figure('Name','Step Four'); % Pick Out Largest Region
plotim = (corrmat<threshold)+ 2*biggestblob+2;
stepfourplot = image(plotim);
colormap('flag')
hh = colorbar();
set(hh,'YLim',[0.5,3.5])
set(hh,'YTick',[1,2,3])
set(hh,'YTickLabel',{'Largest','Empty','Occupied'})

%% Set Up Interactive Window

scrsz = get(groot,'ScreenSize');
interactivewindow = figure('Position',[100 100 scrsz(3)/1.25 scrsz(4)/1.5],'Name','Interactive Window');

subplot(2,3,[1,2,4,5]) % Display the matrix
plotim = (corrmat<threshold)+ 2*biggestblob+2;
hplot = image(plotim);
colormap('flag')

subplot(2,3,3) % Display the size distribution
hplot2 = plot(blobsize,(nsize/sum(nsize)),'ro');
hold on
tau = 187/91;
limiting_size_dist = blobsize.^(-tau); %Add a line to the distribution showing the expected scaling around p_c
hplot3 = plot(blobsize,limiting_size_dist/sum(limiting_size_dist));
ylim([1e-5,1])
xlim([1,150])
xlabel('Blob Size')
ylabel('Fraction of Blobs')
set(gca,'YScale','log')
set(gca,'XScale','log')

%% ADD INTERACTIVE STUFF AND PERCOLATE!

ThresholdSlider = uicontrol('style','slider','units','pixel','position',[70+scrsz(3)/2 150 scrsz(3)/6 20],'Min',0.4,'Max',0.9,'Value',threshold);
CorrelationSlider = uicontrol('style','slider','units','pixel','position',[70+scrsz(3)/2 100 scrsz(3)/6 20],'Min',0.0,'Max',2.5,'Value',0.0);
BiggestBlobText = uicontrol('Style','text',...
        'Position',[70+scrsz(3)/2 180 scrsz(3)/6 20],...
        'String',strcat(['Biggest blob is ',num2str(nnz(biggestblob)),' pixels']));
ThresholdText = uicontrol('Style','text',...
        'Position',[70+scrsz(3)/2 130 scrsz(3)/6 20],...
        'String',strcat(['Threshold set at ',num2str(threshold)]));
CorrelationText = uicontrol('Style','text',...
        'Position',[70+scrsz(3)/2 80 scrsz(3)/6 20],...
        'String',strcat(['Correlation Distance: ',num2str(correldist,3),'pixels']));
    %%
addlistener(ThresholdSlider,'ContinuousValueChange',@(hObject, event) makeplot(hObject,hplot,hplot2,BiggestBlobText,ThresholdText));
addlistener(CorrelationSlider,'ContinuousValueChange',@(hObject, event) UpdateRandSeed(hObject,randmat,hplot,hplot2,BiggestBlobText,CorrelationText));




