import os
from csv import reader
import numpy as np

from sklearn.naive_bayes import MultinomialNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn import svm
from sklearn.model_selection import cross_val_score
'''

Scaffolding code for the Machine Learning assignment. 

You should complete the provided functions and add more functions and classes as necessary.
 
Write a main function that calls the different functions to perform the required tasks 
and repeat your experiments.


'''

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


def my_team():
    '''
    Return the list of the team members of this assignment submission as a list
    of triplet of the form (student_number, first_name, last_name)
    
    '''
    return [ (9702351, 'Tom', 'Bowyer')]

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


def prepare_dataset(dataset_path):
    '''  
    Read a comma separated text file where 
	- the first field is a ID number 
	- the second field is a class label 'B' or 'M'
	- the remaining fields are real-valued

    Return two numpy arrays X and y where 
	- X is two dimensional. X[i,:] is the ith example
	- y is one dimensional. y[i] is the class label of X[i,:]
          y[i] should be set to 1 for 'M', and 0 for 'B'

    @param dataset_path: full path of the dataset text file

    @return
	X,y
    '''
    file = open(dataset_path, "r")
    lines = reader(file)
    dataset = list(lines)

    diagnosis = {'M':1, 'B':0}
    for row in dataset:
        row[1] = diagnosis[row[1]]

    for i in range(0,32):
        if(i!=1):
            for row in dataset:
                row[i] = float(row[i].strip())

    dataset = np.array(dataset)
    X=dataset[:,2:32]
    y=dataset[:,1]
    return X,y

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

def build_NB_classifier(X_training, y_training):
    '''  
    Build a Naive Bayes classifier based on the training set X_training, y_training.

    @param 
	X_training: X_training[i,:] is the ith example
	y_training: y_training[i] is the class label of X_training[i,:]

    @return
	clf : the classifier built in this function
    '''

    clf = None
    best = 0
    alpha_values = np.arange(0.5, 300.5, 0.5)

    for x in alpha_values:
        clf_temp = MultinomialNB(alpha=x)
        score = sum(cross_val_score(clf_temp, X_training, y_training, cv=4))/4
        clf_temp.fit(X_training, y_training)
        
        if(score > best):
            best = score
            clf = clf_temp


    print_out_result(clf, X_training, y_training, "training", "Naive Bayes")
    print("The score for the Naive Bayes classifier on validation data is {0:.2f}".format(best))
    return clf

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

def build_DT_classifier(X_training, y_training):
    '''  
    Build a Decision Tree classifier based on the training set X_training, y_training.

    @param 
	X_training: X_training[i,:] is the ith example
	y_training: y_training[i] is the class label of X_training[i,:]

    @return
	clf : the classifier built in this function
    '''
    clf = None
    best = 0
    max_depth = np.arange(1, 9, 1)

    for x in max_depth:
        clf_temp = DecisionTreeClassifier(random_state=0, max_depth=x)
        score = sum(cross_val_score(clf_temp, X_training, y_training, cv=4))/4
        clf_temp.fit(X_training, y_training)
        
        if(score > best):
            best = score
            clf = clf_temp


    print_out_result(clf, X_training, y_training, "training", "Decision Tree")
    print("The score for the Decision Tree classifier on validation data is {0:.2f}".format(best))
    return clf


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

def build_NN_classifier(X_training, y_training):
    '''  
    Build a Nearrest Neighbours classifier based on the training set X_training, y_training.

    @param 
	X_training: X_training[i,:] is the ith example
	y_training: y_training[i] is the class label of X_training[i,:]

    @return
	clf : the classifier built in this function
    '''
    clf = None
    best = 0
    k_value = np.arange(1, 300, 1)

    for k in k_value:
        clf_temp = KNeighborsClassifier(n_neighbors = k)
        score = sum(cross_val_score(clf_temp, X_training, y_training, cv=4))/4
        clf_temp.fit(X_training, y_training)

        if(score > best):
            best = score
            clf = clf_temp


    print_out_result(clf, X_training, y_training, "training", "Nearest neighbours")
    print("The score for the Nearest Neighbour classifier on validation data is {0:.2f}".format(best))
    return clf

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

def build_SVM_classifier(X_training, y_training):
    '''  
    Build a Support Vector Machine classifier based on the training set X_training, y_training.

    @param 
	X_training: X_training[i,:] is the ith example
	y_training: y_training[i] is the class label of X_training[i,:]

    @return
	clf : the classifier built in this function
    '''
    clf = None
    best = 0
    kernels = ['rbf', 'linear', 'sigmoid']

    for Svm_kernel in kernels:
        clf_temp = svm.SVC(C = 10, kernel =Svm_kernel)
        score = sum(cross_val_score(clf_temp, X_training, y_training, cv=4))/4
        clf_temp.fit(X_training, y_training)

        if(score > best):
            best = score
            clf = clf_temp


    print_out_result(clf, X_training, y_training, "training", "SVM")
    print("The score for the SVM classifier on validation data is {0:.2f}".format(best))
    return clf

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

def print_out_result(classifier, x_data, y_data, training_type, classifier_name):
    score = classifier.score(x_data, y_data)
    print("The score for the {0} classifier on {1} data is {2:.2f}.".format(classifier_name, training_type, score))


if __name__ == "__main__":
    path  = os.path.join(os.path.dirname(__file__),'medical_records.data')
    [X,y] = prepare_dataset(path)

    X_training = X[:400,:]
    y_training = y[:400]
    X_testing = X[400:569,:]
    y_testing = y[400:569]

    Naive_bayes_classifier = build_NB_classifier(X_training,y_training)
    print_out_result(Naive_bayes_classifier, X_testing, y_testing, "testing", "Naive bayes")

    Decision_tree_classifier = build_DT_classifier(X_training,y_training)
    print_out_result(Decision_tree_classifier, X_testing, y_testing, "testing", "Decision tree")

    Nearest_neighbours_classifier = build_NN_classifier(X_training,y_training)
    print_out_result(Nearest_neighbours_classifier, X_testing, y_testing, "testing", "Nearest neighbours")

    Support_vector_machines_classifier = build_SVM_classifier(X_training,y_training)
    print_out_result(Support_vector_machines_classifier, X_testing, y_testing, "testing", "SVM")
