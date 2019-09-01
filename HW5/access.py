"""
authors: Alec Bird
course: CSE 465/565
Homework 4
program: access
Date: 4/7/19
"""

import sys

# Modify these functions. Add helper functions if you wish.
# These functions must be O(1).
def numNonZeros2DTriangular(N):
    """
    Computes the number of non-zero elements in the matrix
    """
    nums = ((N*N)+N) / 2
    return nums

def compute_spot(N, nonZeroNums, row, col):
    """
    Helper method that computes the index for the element using a matrix flipped over the diagonal 
    """
    size = N
    permaNonZeroNums = nonZeroNums
    #checks for correct row
    while N-1 != row:
        nonZeroNums = nonZeroNums - N
        N -= 1
    
    result = nonZeroNums - (row - col)
   
    return permaNonZeroNums - result

def access2DTriangular(N, row, col):
    """
    Grants access to a triangular matrix 
    """
    # return -1 if any parameters are nonsensical
    nums = numNonZeros2DTriangular(N) - 1
    row = (N-1) - row
    col = (N-1) - col
    if row < col or col < 0:
        return -1
    else:
        return compute_spot(N, nums, row, col)


def main():
    """
    Computes triangular matrices
    """
    
    #numNonZeros2DTriangular(4) → 10
    print(numNonZeros2DTriangular(4))
    #numNonZeros2DTriangular(1) → 1
    print(numNonZeros2DTriangular(1))
    #numNonZeros2DTriangular(5) → 15
    print(numNonZeros2DTriangular(5))
    #access2DTriangular(4, 0, 0) → 0
    print("Triangular Access")
    #access2DTriangular(4, 0, 0) → 0
    print(access2DTriangular(4, 0, 0))
    #access2DTriangular(4, 3, 3) → 9
    print(access2DTriangular(4, 3, 3))
    #access2DTriangular(4, 3, 0) → -1
    print(access2DTriangular(4, 3, 0))
    #access2DTriangular(3, 1, 1) → 3
    print(access2DTriangular(3, 1, 1))


    
    
if __name__ == "__main__":
    main()
    