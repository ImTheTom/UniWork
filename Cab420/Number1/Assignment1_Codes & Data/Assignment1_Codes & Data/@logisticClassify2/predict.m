function Yte = predict(obj,Xte)
% Yhat = predict(obj, X)  : make predictions on test data X

% (1) make predictions based on the sign of wts(1) + wts(2)*x(:,1) + ...
% (2) convert predictions to saved classes: Yte = obj.classes( [1 or 2] );.
    weight = [obj.wts];
    guess = weight(1)+weight(2)*Xte(:,1)+weight(3)*Xte(:,2); % calculate guess
    classes = [obj.classes];
    for i=1:length(Xte)
        if(guess(i)>=0)
            guess(i)=obj.classes(2); % index set to positive class
        else
            guess(i)=obj.classes(1); % set index to negative class
        end
    end
    Yte = guess;
end
