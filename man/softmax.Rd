% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/softmax.R
\name{softmax}
\alias{softmax}
\title{Softmax function}
\usage{
softmax(newdata, object)
}
\arguments{
\item{newdata}{New dataframe}

\item{object}{An object of class Pls-DA}
}
\value{
Clusters : class of inidividu
Probability : probabilities to belong at a class
}
\description{
Function to calcul the probabilities and after determine the class of individu with the Sofmax method
}
\examples{
fit_launch : an object of class Pls-DA
softmax(newdata = iris[,1:4], fit_launch )

}
