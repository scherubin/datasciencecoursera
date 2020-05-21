#CREATE A LIST OF FUNCTIONS TO CACHE THE INVERSE OF A MATRIX
makeCacheMatrix <- function(mat=matrix()){
  
  inv <- NULL
  
  #save/set the matrix
  set_mat <- function(z){
    mat <<- z
    inv <<- NULL
  } 
  
  #get the matrix
  get_mat <- function() mat 
  
  #save/set inverse of matrix
  set_inv <- function(inverse) inv <<-inverse 
  
  #get inverse
  get_inv <- function() inv 
  
  #print the list of functions
  list(set_mat = set_mat, get_mat = get_mat, 
       set_inv = set_inv, get_inv=get_inv) 
}

#CREATE A FUNCTION TO RETREIVE/COMPUTE INVERSE OF A MATRIX
cachesolve <- function(mat,...){
  
  #check if inverse has been calculated
  inv <- mat$get_inv() 
  
  #if inverse exists, retrieve from cache
  if (!is.null(inv)){
    message ("getting cached inverse")
    return(inv)
  } 
  
  #if inverse doesn't exist, get matrix
  mat_data <- mat$get_mat() 
  
  #calculate inverse of the matrix
  inv <- solve(mat_data)
  
  #save/set inverse of the matrix
  mat$set_inv(inv) 
  
  #print inverse of the matrix
  inv 
}
