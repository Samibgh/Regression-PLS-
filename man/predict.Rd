% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.R
\name{predict}
\alias{predict}
\title{Prediction features}
\usage{
predict(object, newdata, type = c("posterior", "class"))
}
\arguments{
\item{object}{An object of class Pls-DA}

\item{newdata}{New dataframe for predict class}

\item{type}{choose if you want probabilites or class}
}
\value{
Class : clusters of individu
Probability : The Probability to for the individu to go in the different class
}
\description{
Function who atribute  class for individu with softmax method on the new new dataframe.
}
\examples{
fit_launch : an object of class Pls-DA
predict(fit_launch, iris[,1:4], type = "class")

}
