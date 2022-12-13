# softmax function
#' Softmax function
#'
#' Function to calcul the probabilities and after determine the class of individu with the Sofmax method
#'
#' @param newdata New dataframe
#' @param object An object of class Pls-DA
#'
#' @return
#' Clusters : class of inidividu
#' Probability : probabilities to belong at a class
#' @export
#'
#' @examples
#' fit_launch : an object of class Pls-DA
#' softmax(newdata = iris[,1:4], fit_launch )
#'
softmax <- function(newdata,object){
  n <- object$n_components
  # Yhat calculation
  nclass <- ncol(object$calc$Y)
  temp <- matrix(rep(object$calc$Intercept,each=nrow(newdata)),nrow(newdata),nclass)
  yhat <- as.matrix(scale(newdata))%*%object$calc$Coefficients + temp

  # softmax probability
  res <- t(apply(yhat,1,exp))
  somme <- rowSums(res)
  result <- res/somme

  # classification
  class <- max.col(result)
  noms <- colnames(object$calc$Y)
  for (i in 1:nclass) {
    class[class==i]<-noms[i]
  }
  return(list(Clusters=class,Probability=round(result,6)))
}
