    % Test function: predict on Xtest
    function Yte = predict(obj,Xte)
      [Ntr,Mtr] = size(obj.Xtrain);          % get size of training, test data
      [Nte,Mte] = size(Xte);
      classes = unique(obj.Ytrain);          % figure out how many classes & their labels
      Yte = repmat(obj.Ytrain(1), [Nte,1]);  % make Ytest the same data type as Ytrain
      K = min(obj.K, Ntr);                  % can't have more than Ntrain neighbors
      for i=1:Nte,                          % For each test example:
        dist = sum( bsxfun( @minus, obj.Xtrain, Xte(i,:) ).^2 , 2);  % compute sum of squared differences
        %dist = sum( (obj.Xtrain - repmat(Xte(i,:),[Ntr,1]) ).^2 , 2);  % compute sum of squared differences
        [tmp,idx] = sort(dist);              % find nearest neighbors over Xtrain (dimension 2)
         idx = idx(1:K);                     % idx(1) is the index of the nearest point, etc.; see help sort
         values = [];                          % empty vector
        for c=1:length(classes)
          Nc = sum(obj.Ytrain(idx(1:K))==classes(c));  % count up how many instances of that class we have 
          if(Nc ~= 0) % if not equal to 0
            values = [values; classes(c)*Nc]; %append the class multiplied by the number of occurrences to the end of the vector
          end
        end
        total = sum(values)/K; %get the average
        Yte(i)=total;       % return the average for that x value

      end
    end
