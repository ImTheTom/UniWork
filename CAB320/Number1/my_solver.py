# -*- coding: utf-8 -*-
"""
Created on  Feb 27 2018

@author: frederic

Scaffholding code for CAB320 Assignment One

This is the only file that you have to modify and submit for the assignment.

"""

import numpy as np

import itertools as it

import generic_search as gs

from assignment_one import (TetrisPart, AssemblyProblem, offset_range, 
#                            display_state, 
                            make_state_canonical, play_solution, 
#                            load_state, make_random_state
                            )



# ---------------------------------------------------------------------------

def print_the_team():
    '''
    Print details of the members of your team 
    (full name + student number)
    '''
    print("Tom Bowyer - n9702351")
    
# ---------------------------------------------------------------------------
        
def appear_as_subpart(some_part, goal_part):
    '''    
    Determine whether the part 'some_part' appears in another part 'goal_part'.
    
    Formally, we say that 'some_part' appears in another part 'goal_part',
    when the matrix representation 'S' of 'some_part' is a a submatrix 'M' of
    the matrix representation 'G' of 'goal_part' and the following constraints
    are satisfied:
        for all indices i,j
            S[i,j] == 0 or S[i,j] == M[i,j]
            
    During an assembly sequence that does not use rotations, any part present 
    on the workbench has to appear somewhere in a goal part!
    
    @param
        some_part: a tuple representation of a tetris part
        goal_part: a tuple representation of another tetris part
        
    @return
        True if 'some_part' appears in 'goal_part'
        False otherwise    
    '''
    sub = np.array(some_part)
    goal = np.array(goal_part)
    lengthSub = len(sub)
    lengthGoal = len(goal)
    widthGoal = len(goal[0])
    widthSub = len(sub[0])
    
    #Loop through all the rows and all the columns with the sub part possible in 
    for rowIndex in range(lengthGoal-(lengthSub-1)):
        for columnIndex in range(widthGoal-(widthSub-1)):
            #Check if the sub part is at the current iteration
            if(goal[rowIndex][columnIndex]==sub[0][0] or sub[0][0] == 0): 
                number = 0
                for subRowIndex in range(lengthSub):
                    for subColumnIndex in range(widthSub):
                        if(goal[rowIndex+subRowIndex][columnIndex+subColumnIndex] == sub[subRowIndex][subColumnIndex] or sub[subRowIndex][subColumnIndex] == 0):
                            number+=1
                if(number == widthSub*lengthSub):
                    return True
    return False


# ---------------------------------------------------------------------------
        
def cost_rotated_subpart(some_part, goal_part):
    '''    
    Determine whether the part 'some_part' appears in another part 'goal_part'
    as a rotated subpart. If yes, return the number of 'rotate90' needed, if 
    no return 'np.inf'
    
    The definition of appearance is the same as in the function 
    'appear_as_subpart'.
                   
    @param
        some_part: a tuple representation of a tetris part
        goal_part: a tuple representation of another tetris part
    
    @return
        the number of rotation needed to see 'some_part' appear in 'goal_part'
        np.inf  if no rotated version of 'some_part' appear in 'goal_part'
    
    '''
    piece = TetrisPart(some_part)
    for rotation in range(0,4):
        if(appear_as_subpart(piece.get_frozen(),goal_part)): 
            return rotation # return the first number of rotation needed to appear in a goal part
        piece.rotate90() 
    return np.inf # return np.inf if part can't be found in a goal piece
    
    
# ---------------------------------------------------------------------------

class AssemblyProblem_1(AssemblyProblem):
    '''
    
    Subclass of 'assignment_one.AssemblyProblem'
    
    * The part rotation action is not available for AssemblyProblem_1 *

    The 'actions' method of this class simply generates
    the list of all legal actions. The 'actions' method of this class does 
    *NOT* filtered out actions that are doomed to fail. In other words, 
    no pruning is done in the 'actions' method of this class.
        
    '''

    def __init__(self, initial, goal=None):
        """The constructor specifies the initial state, and possibly a goal
        state, if there is a unique goal.  Your subclass's constructor can add
        other arguments."""
        # Call the parent class constructor.
        # Here the parent class is 'AssemblyProblem' 
        # which itself is derived from 'generic_search.Problem'
        super(AssemblyProblem_1, self).__init__(initial, goal, use_rotation=False)
    
    def actions(self, state):
        """
        Return the actions that can be executed in the given
        state. The result would typically be a list, but if there are
        many actions, consider yielding them one at a time in an
        iterator, rather than building them all at once.
        
        @param
          state : a state of an assembly problem.
        
        @return 
           the list of all legal drop actions available in the 
            state passed as argument.
        
        """
        actionList = []
        partList = list(state)
        
        possibleCombinations = it.permutations(partList,2) #Get all possible combinations 
        for combination in possibleCombinations:
            start,end = offset_range(combination[0],combination[1]) #Get all possible offsets
            for offset in range(start,end):
                actionList.append((combination[0],combination[1],offset)) #Add the part above, part below and offset to the action list

        return actionList
        


    def result(self, state, action):
        """
        Return the state (as a tuple of parts in canonical order)
        that results from executing the given
        action in the given state. The action must be one of
        self.actions(state).
        
        @return
          a state in canonical order
        
        """
        currentState = list(state)

        newPiece = TetrisPart(action[0],action[1],action[2])
        currentState.append(newPiece.get_frozen()) #Add the new piece to the state
        currentState.remove(action[0])
        currentState.remove(action[1]) #Remove the old pieces

        currentState = make_state_canonical(currentState)
        return currentState


# ---------------------------------------------------------------------------

class AssemblyProblem_2(AssemblyProblem_1):
    '''
    
    Subclass of 'assignment_one.AssemblyProblem'
        
    * Like for AssemblyProblem_1,  the part rotation action is not available 
       for AssemblyProblem_2 *

    The 'actions' method of this class  generates a list of legal actions. 
    But pruning is performed by detecting some doomed actions and 
    filtering them out.  That is, some actions that are doomed to 
    fail are not returned. In this class, pruning is performed while 
    generating the legal actions.
    However, if an action 'a' is not doomed to fail, it has to be returned. 
    In other words, if there exists a sequence of actions solution starting 
    with 'a', then 'a' has to be returned.
        
    '''

    def __init__(self, initial, goal=None):
        """The constructor specifies the initial state, and possibly a goal
        state, if there is a unique goal.  Your subclass's constructor can add
        other arguments."""
        # Call the parent class constructor.
        # Here the parent class is 'AssemblyProblem' 
        # which itself is derived from 'generic_search.Problem'
        super(AssemblyProblem_2, self).__init__(initial, goal)
    
    def actions(self, state):
        """
        Return the actions that can be executed in the given
        state. The result would typically be a list, but if there are
        many actions, consider yielding them one at a time in an
        iterator, rather than building them all at once.
        
        A candidate action is eliminated if and only if the new part 
        it creates does not appear in the goal state.
        """
        actionList = []
        partList = list(state)
        goals = np.array(self.goal)
        
        possibleCombinations = it.permutations(partList,2) #Get all possible combinations 
        for combination in possibleCombinations:
            start,end = offset_range(combination[0],combination[1])#Get all possible offsets
            for offset in range(start,end):
                resultPiece = TetrisPart(combination[0], combination[1],offset)
                for goal in goals: #Loop through each goal piece
                    if(appear_as_subpart(resultPiece.get_frozen(),goal)): #Check if the combination is in the current goal piece
                        actionList.append((combination[0],combination[1],offset))#Add part above, part below and offset to action list
                        
        return actionList


# ---------------------------------------------------------------------------

class AssemblyProblem_3(AssemblyProblem_1):
    '''
    
    Subclass 'assignment_one.AssemblyProblem'
    
    * The part rotation action is available for AssemblyProblem_3 *

    The 'actions' method of this class simply generates
    the list of all legal actions including rotation. 
    The 'actions' method of this class does 
    *NOT* filter out actions that are doomed to fail. In other words, 
    no pruning is done in this method.
        
    '''

    def __init__(self, initial, goal=None):
        """The constructor specifies the initial state, and possibly a goal
        state, if there is a unique goal.  Your subclass's constructor can add
        other arguments."""
        # Call the parent class constructor.
        # Here the parent class is 'AssemblyProblem' 
        # which itself is derived from 'generic_search.Problem'
        super(AssemblyProblem_3, self).__init__(initial, goal)
        self.use_rotation = True

    
    def actions(self, state):
        """Return the actions that can be executed in the given
        state. The result would typically be a list, but if there are
        many actions, consider yielding them one at a time in an
        iterator, rather than building them all at once.
        
        Rotations are allowed, but no filtering out the actions that 
        lead to doomed states.
        
        """
        actionList = []
        partList = list(state)
        
        possibleCombinations = it.permutations(partList,2)#Get all possible combinations 
        for combination in possibleCombinations:
            start,end = offset_range(combination[0],combination[1])#Get all possible offset 
            for offset in range(start,end):
                actionList.append((combination[0],combination[1],offset))#Add the part above, part below and offset to the action list
                
        for part in partList:#loop though each part
            actionList.append(("rotate",part))#add rotation action for each piece to action list
            
        return actionList

        
    def result(self, state, action):
        """
        Return the state that results from executing the given
        action in the given state. The action must be one of
        self.actions(state).

        The action can be a drop or rotation.        
        """
        currentState = list(state)
        
        if(action[0]=="rotate"):#Check if the action is a rotation action
            piece  = TetrisPart(action[1])
            piece.rotate90()
            currentState.append(piece.get_frozen())#Add new rotated piece to the state
            currentState.remove(action[1])#remove old piece
        else:
            newPiece = TetrisPart(action[0],action[1],action[2])
            currentState.append(newPiece.get_frozen())#Add the new piece to the state
            currentState.remove(action[0])
            currentState.remove(action[1])#Remove old pieces

        currentState = make_state_canonical(currentState)

        return currentState


# ---------------------------------------------------------------------------

class AssemblyProblem_4(AssemblyProblem_3):
    '''
    
    Subclass 'assignment_one.AssemblyProblem3'
    
    * Like for its parent class AssemblyProblem_3, 
      the part rotation action is available for AssemblyProblem_4  *

    AssemblyProblem_4 introduces a simple heuristic function and uses
    action filtering.
    See the details in the methods 'self.actions()' and 'self.h()'.
    
    '''

    def __init__(self, initial, goal=None):
        """The constructor specifies the initial state, and possibly a goal
        state, if there is a unique goal.  Your subclass's constructor can add
        other arguments."""
        # Call the parent class constructor.
        # Here the parent class is 'AssemblyProblem' 
        # which itself is derived from 'generic_search.Problem'
        super(AssemblyProblem_4, self).__init__(initial, goal)

    def actions(self, state):
        """Return the actions that can be executed in the given
        state. The result would typically be a list, but if there are
        many actions, consider yielding them one at a time in an
        iterator, rather than building them all at once.
        
        Filter out actions (drops and rotations) that are doomed to fail 
        using the function 'cost_rotated_subpart'.
        A candidate action is eliminated if and only if the new part 
        it creates does not appear in the goal state.
        This should  be checked with the function "cost_rotated_subpart()'.
                
        """
        actionList = []
        partList = list(state)
        goals = np.array(self.goal)
        
        possibleCombinations = it.permutations(partList,2)#Get all possible combinations 
        for combination in possibleCombinations:
            start,end = offset_range(combination[0],combination[1])#Get all possible offset 
            for offset in range(start,end):
                resultPiece = TetrisPart(combination[0], combination[1],offset)
                for goal in goals:#Loop through each goal piece
                    cost = cost_rotated_subpart(resultPiece.get_frozen(),goal)#Check if the cost of rotations of any goal for the piece is not np.inf
                    if(cost != np.inf):
                        actionList.append((combination[0],combination[1],offset))#Add part above, part below and offset to action list
        
        for part in partList:#Loop through each part
            for goal in goals:#Loop through each goal piece
                numberOfRotations = cost_rotated_subpart(part, goal)
                if(numberOfRotations!=np.inf): #Check if the piece needs to be rotated to be part of a goal piece
                    actionList.append(("rotate",part))#add rotation action for the part to the action list

        return actionList
        
        
        
    def h(self, n):
        '''
        This heuristic computes the following cost; 
        
           Let 'k_n' be the number of parts of the state associated to node 'n'
           and 'k_g' be the number of parts of the goal state.
          
        The cost function h(n) must return 
            k_n - k_g + max ("cost of the rotations")  
        where the list of cost of the rotations is computed over the parts in 
        the state 'n.state' according to 'cost_rotated_subpart'.
        
        
        @param
          n : node of a search tree
          
        '''
        if(self.goal is None):
            return 0 #Defensive programming
        
        currentState = list(n.state)
        goalState = list(self.goal)
        k_n = len(currentState)
        k_g = len(self.goal)

        costOfRotationsOfParts = [] #Number of rotations required for each piece to be part of the goal

        for piece in currentState: #Loop through each piece
            costOfRotationsOfThisPart = [] #Cost of rotations for a piece
            for goal in goalState: #Loop through each goal piece
                cost = cost_rotated_subpart(piece,goal)#get the cost of rotations for the peice to appear as goal piece
                if(cost != np.inf):
                    costOfRotationsOfThisPart.append(cost)#Add it to the list if not np.inf
                    
            if(len(costOfRotationsOfThisPart) == 0):
                return k_n - k_g + np.inf #If the length of the current piece is empty then the max of rotations will be np.inf so can return here
            
            costOfRotationsOfParts.append(max(costOfRotationsOfThisPart)) #Append the max rotations for the current piece
            
        return  k_n - k_g +max(costOfRotationsOfParts) #Return the f value with the max of all pieces

# ---------------------------------------------------------------------------
        
def solve_1(initial, goal):
    '''
    Solve a problem of type AssemblyProblem_1
    
    The implementation has to 
    - use an instance of the class AssemblyProblem_1
    - make a call to an appropriate functions of the 'generic_search" library
    
    @return
        - the string 'no solution' if the problem is not solvable
        - otherwise return the sequence of actions to go from state
        'initial' to state 'goal'
    
    '''
    print('\n++  busy searching in solve_1() ...  ++\n')
    assembly_problem = AssemblyProblem_1(initial, goal) #instantiate problem as an Assembly Problem
    sol_ts = gs.iterative_deepening_search(assembly_problem) #solve the Assembly Problem
    if(sol_ts == None):
        return "no solution" #Return no solution if none was found
    return sol_ts.solution() #Return the actions if a solution was found
    

# ---------------------------------------------------------------------------
        
def solve_2(initial, goal):
    '''
    Solve a problem of type AssemblyProblem_2
    
    The implementation has to 
    - use an instance of the class AssemblyProblem_2
    - make a call to an appropriate functions of the 'generic_search" library
    
    @return
        - the string 'no solution' if the problem is not solvable
        - otherwise return the sequence of actions to go from state
        'initial' to state 'goal'
    
    '''
    print('\n++  busy searching in solve_2() ...  ++\n')
    assembly_problem = AssemblyProblem_2(initial, goal)
    sol_ts = gs.depth_first_tree_search(assembly_problem)
    if(sol_ts == None):
        return "no solution"
    return sol_ts.solution()
    

# ---------------------------------------------------------------------------
        
def solve_3(initial, goal):
    '''
    Solve a problem of type AssemblyProblem_3
    
    The implementation has to 
    - use an instance of the class AssemblyProblem_3
    - make a call to an appropriate functions of the 'generic_search" library
    
    @return
        - the string 'no solution' if the problem is not solvable
        - otherwise return the sequence of actions to go from state
        'initial' to state 'goal'
    
    '''
    print('\n++  busy searching in solve_3() ...  ++\n')
    assembly_problem = AssemblyProblem_3(initial, goal)
    sol_ts = gs.iterative_deepening_search(assembly_problem)
    if(sol_ts == None):
        return "no solution"
    return sol_ts.solution()
    
# ---------------------------------------------------------------------------
        
def solve_4(initial, goal):
    '''
    Solve a problem of type AssemblyProblem_4
    
    The implementation has to 
    - use an instance of the class AssemblyProblem_4
    - make a call to an appropriate functions of the 'generic_search" library
    
    @return
        - the string 'no solution' if the problem is not solvable
        - otherwise return the sequence of actions to go from state
        'initial' to state 'goal'
    
    '''
    print('\n++  busy searching in solve_4() ...  ++\n')
    assembly_problem = AssemblyProblem_4(initial, goal)
    sol_ts = gs.astar_tree_search(assembly_problem)
    if(sol_ts == None):
        return "no solution"
    return sol_ts.solution()
        
# ---------------------------------------------------------------------------


    
if __name__ == '__main__':
    pass
    
