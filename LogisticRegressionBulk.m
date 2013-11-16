fileNameTrain = 'citeseer.train.ltc.svm';
fileNameTest = 'citeseer.test.ltc.svm';
dir = 'Users/daniel/Documents/MATLAB/+SearchEnginesHW5/+Data/';
fileLocationTrain = strcat(dir,fileNameTrain);
fileLocationTest = strcat(dir,fileNameTest);



%Import database
fprintf('loading training data...\n');
[Xtrain,Ytrain] = SearchEnginesHW5.readLabeledSparseMatrix (fileLocationTrain);
fprintf('loading testing data...\n');
[Xtest,Ytest] = SearchEnginesHW5.readLabeledSparseMatrix (fileLocationTest);
fprintf('data loaded\n\n');

Xtrain = [ones(size(Xtrain,1),1) Xtrain];
Xtest = [ones(size(Xtest,1),1) Xtest];


Ytrain_temp = zeros(size(Ytrain));
Ytrain_temp(Ytrain==7) = 1;
Ytrain = Ytrain_temp;

Ytest_temp = zeros(size(Ytest));
Ytest_temp(Ytest==7) = 1;
Ytest = Ytest_temp;



%TRAINING
alpha = 20;
C = 0.001;
FV_dimension = size(Xtrain,2);
w = zeros(1, FV_dimension);
step = zeros(1, FV_dimension);
lastValue = 0;
convPrecision = 0.01;
convValue = convPrecision + 1;


T = 1;
while T < 150 && convValue > convPrecision
    
    for i=1:size(Xtrain,1)
        
        currentX = Xtrain(i,:);
        currentY = Ytrain(i);
        
        p = 1 / (1 + exp(-dot(currentX,w)) );
        step = step + alpha*( (currentY - p)*currentX - C*w ); 
        
    end 
    
    %normalize step
    step = step / size(Xtrain,1);
    %update w
    w = w + step;
    
    P = 1 + exp(-Xtrain*w');
    P = bsxfun(@rdivide,1,P);

    LossFunction = bsxfun(@times,Ytrain,log(P)) + bsxfun(@times,(1-Ytrain),log(1-P));
    LossFunction = sum(LossFunction);

    currentValue = LossFunction - 0.5*C*sum(dot(w,w));
    
    convValue = abs(lastValue - currentValue);
    lastValue = currentValue;
    fprintf('%i %f %f\n', T, convValue, currentValue);

    T = T + 1;
    
end

%TESTING
Pred_lr = sign(Xtest*w');
Pred_lr(Pred_lr==-1)=0;

a = sum((Pred_lr==0).*(Ytest==0));
b = sum((Pred_lr==1).*(Ytest==0));
c = sum((Pred_lr==0).*(Ytest==1));
d = sum((Pred_lr==1).*(Ytest==1));

precision = d / (d + b);
recall = d / (c + d);
accuracy = (a + d) / (a + b + c + d);

fprintf('%i \n', T);
fprintf('P:%.3f, R:%.3f, A:%.3f \n', precision, recall, accuracy);



