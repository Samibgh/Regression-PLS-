
#' Cross-validation of PLSDA model
#'
#' A “leave-one-out” cross-validation function used in fit.
#'
#' @param X the numeric data frame or matrix of observations. Missing values are not allowed.
#' @param Y a vector or matrix of responses. Missing values are not allowed.
#' @param threshold the threshold used in NIPALS algorithm. Default to 0.001.
#' @param nfold the number of folds used in cross validation. Default to NULL. If nfold is missing, the number of folds is the minimum of rows’ or columns’ number of data.
#' @details
#'This function performs a “leave-one-out” cross-validation based on NIPALS algorithm on a model fit. When ncomp = NULL, the number of components is obtained by cross-validation. When a number of components is specified, cross-validation results are calculated for each component.
#'
#'Leave-one-out cross-validation uses the following approach to evaluate a model:
#'
#'- Split a dataset into a training set and a test set, using all but one observation as part of the training set (we only leave one observation out from the training set).
#'
#'- Build the model using only data from the training set.
#'
#'- Use the model to predict the response value of the one observation left out of the model and calculate Q2 coefficient.
#'
#'- Repeat the process nfold times.

#'
#' @return
#'Q2 :	the coefficient of “leave-one-out” cross-validation. If Q2 >= 0.05, we take the component.
#'
#'ncomp	: the number of components obtained by “leave-one-out” cross-validation.
#' @export
#' @examples
#' data(iris)
#' PlsDA.cv(iris[,1:4], iris[,5])
#'
PlsDA.cv <- function(X,Y, threshold = 0.001, nfold=NULL){
  # verify data: dataframe or matrix
  ok <- (is.data.frame(X) | is.matrix(X)) & (is.data.frame(Y) | is.matrix(Y))
  if (!ok){
    stop("X and Y should be a dataframe or a matrix")
  }

  # verify data: numeric
  nb_ok <- sum(sapply(X,function(x){is.numeric(x)})) + sum(sapply(Y,function(x){is.numeric(x)}))
  if (nb_ok < (ncol(X) + ncol(Y))){
    stop("Some of the elements inside X or Y are not numeric")
  }

  # check the number of nfold
  if (is.null(nfold) || nfold <2){
    nfold <- nrow(X)
  }

  # check the number of threshold
  if (is.null(threshold)){
    threshold <- 0.001
  }

  n <- nrow(X) # row's number of X
  q <- ncol(Y)  # columns' number of Y
  p <- ncol(X)   # columns' number of X
  nc <- min(n, p) # number of components by defaut

  RSS <- rbind(rep(n-1,q), matrix(NA, nc, q))
  PRESS <- matrix(NA, nc, q)
  Q2 <- matrix(NA, nc, q)

  #scaling X and Y
  Xscale <- as.matrix(scale(X))
  Yscale <- as.matrix(scale(Y))

  #Loop to define RSS:
  for (h in 1:nc){
    b <- TRUE
    iter<-1
    uh <- Yscale[,1] #initialization on the first column of Y
    wh_old = rep(1, p)
    while (b){
      wh <- (t(uh) %*% Xscale)/as.numeric(t(uh) %*% uh) # x-weights
      wh <- t(wh/sqrt(as.numeric(wh %*% t(wh))))        # normalisation
      th <- Xscale %*% wh                             # X_scores
      ch <- t((t(th) %*% Yscale)/as.numeric(t(th) %*% th)) # loadings of Y
      uh <- Yscale %*% ch/as.numeric(t(ch) %*% ch)   # Y_scores

      # verify if wh changes or not:
      w_dif <- wh - wh_old
      wh_old <- wh

      # condition to stop the loop: if wh doesn't change, we stop
      ifelse(sum(w_dif^2)<threshold || iter==100, b <- FALSE, b <- TRUE)
      iter <- iter + 1
    } # end of loop while RSS

    ph <- t(t(th) %*% Xscale/(as.numeric(t(th) %*% th)))  # X_loadings  &

    #calculate RSS:
    RSS[h+1,] <-  colSums((Yscale - (th %*% t(ch)))^2)

    #Loop to define PRESS:
    press = matrix(0, nfold, q)
    for (i in 1:nfold){
      uhbis <- Yscale[-i,1]
      whbis_old = rep(1, p)
      iterh <-1
      a <- TRUE
      while (a){
        whbis <- (t(uhbis) %*% Xscale[-i,])/as.numeric(t(uhbis) %*% uhbis)
        whbis <- t(whbis/sqrt(as.numeric(whbis %*% t(whbis))))
        thbis <- Xscale[-i,] %*% whbis
        chbis <- t((t(thbis) %*% Yscale[-i,])/as.numeric(t(thbis) %*% thbis))
        uhbis <- Yscale[-i,] %*% chbis/as.numeric(t(chbis) %*% chbis)
        phbis <- t(t(thbis) %*% Xscale[-i,]/(as.numeric(t(thbis) %*% thbis)))
        wbis_dif <- whbis - whbis_old
        whbis_old <- whbis

        ifelse(sum(wbis_dif^2)<threshold || iter==100, a <- FALSE, a <- TRUE)
        iterh <- iterh + 1
      } # end of loop while PRESS

      Yhat <- (Xscale[i,] %*% whbis) %*% t(chbis)
      press[i,] <- (Yscale[i,] - Yhat)^2
    }

    # deflate
    Xscale <- Xscale - (th %*% t(ph))
    Yscale <- Yscale - (th %*% t(ch))

    # calculate PRESS and Q2
    PRESS[h,] <- colSums(press)
    Q2[h,] = 1 - (PRESS[h,] / RSS[h,])
  } # end of loop for

  # calculate Q2 total if ncol(Y)>1
  if (q==1){
    Q2T = Q2G = Q2
    colnames(Q2T) <- "Q2"
    rownames(Q2T) <- paste(rep("Comp.",h), 1:h, sep="")
  } else{
    Q2G <- 1 - (rowSums(PRESS) / rowSums(RSS[-nc,]))
    Q2T <- cbind(Q2, Q2G)
    # add names
    q2 <- c(paste(rep("Q2",q),colnames(Y),sep="."),"Q2")
    dimnames(Q2T) = list(paste(rep("Comp.",h), 1:h, sep=""), q2)
  }

  # select the number of components
  selcom <- which(Q2G >= 0.05)
  ncomp <- length(selcom)

  return(list(Q2=Q2T,ncomp=ncomp))
} #end function



