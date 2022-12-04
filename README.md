# Regression-PLS-DA-

URL Rshiny app :
[RshinyApp](https://ha8g60-samibgh.shinyapps.io/App_PLS_Regression/)

URL upload file for shiny app : 
[Upload files](https://github.com/Samibgh/R-Shiny---PLS-DA-Deployment)

## Introduction

The goal of the project is to create a package reproducing different outputs using PLS Regression, and to display them using a Rshiny application. The PLS Regression is a prediction method in machine learning which was born in 1980 and which knows today many applications in extremely varied domains. She maximizes the variance of the predictors of Xi and maximizes the correlation between the variables that explain the variable Y. The algorithm borrows its approach from both principal component analysis (PCA) and linear regression. More precisely, it looks for the components called latent variables in order to express the regression of Y on the feature variables. 
We have create this package in order to practice our programming skills and also to disvover the PLS method. This package contain two principals functions for show the results of PLS regression and also functions to build graph for data visualization. The first function is the function FIT. It's to build a model from data. after the execution we have many results like coefficients, intercept, loadings, weight and scores. The second function is the Predict function to predict data from the created model. For the functions plot we have many types like correlation circle plot, individu graph, screeplot...

## Installation package

In order to use our package, you could install it from our Github.

```
library(devtools)
install_github("Samibgh/Regression-PLS-")
```
Once the package is downloaded and successfully installed, please load it for use.

```
library(PlsRegression)
```

Finally, in order to have a great experience with our package, make sure that you have already installed these packages :
```
requiredpackages <- c('plotly', 'heatmaply', 'dplyr',"base", 'PlsRegression')

install_load <- function(packages){
  for (p in packages) {
    if (p %in% rownames(installed.packages())) {
      library(p, character.only=TRUE)
    } else {
      install.packages(p)
      library(p,character.only = TRUE)
    }
  }
}
install_load(requiredpackages)
```
## Dataset Description

In order to test our package, we work with the dataset breast_train_test.xlsx. It consists of 400 observations and 10 variables.

The Breast Cancer (Diagnostic) DataSet, contains features computed from a digitized image of a fine needle aspirate (FNA) of a breast mass and describe characteristics of the cell nuclei present in the image.

Attribute information:
  - 9 features : clump, ucellsize, ucellshape, mgadhesion, sepics, bnuclei, bchromatin, nomnucl and mitoses.
  - Diagnosis (classe) : malignant or benign.
  
The dataset contains 2 sheets : apprentissage (for training model) and test (for prediction).

## View Data 

View of data : 

![image](https://user-images.githubusercontent.com/78345903/205445292-895ca089-8888-4e1b-8076-adedecd43a87.png)

## FIT function 

In the function, we have many parameters to choose for launch function. This is a picture of the different parameters. You can choose between the Nipals algorithm and the Simpls algorithm. Choose if you want a selection variable and you number of composant.

![image](https://user-images.githubusercontent.com/78345903/205444751-e0e59ab5-f25c-4306-a322-c0ab2c8865fa.png)

SO we can call our function like the this : 

![image](https://user-images.githubusercontent.com/78345903/205445418-c52fc3d0-0da7-4802-8140-462ca4a20e30.png)

After the execution of function we have a object pls_model and an instance of class PLSDA is created.She contain different result of pls regresion. For exemple we can show the result of classification report :

Like this : 

![image](https://user-images.githubusercontent.com/78345903/205445588-d4d5583f-fdda-46ff-9bf1-9de41b09b389.png)

The result : 

![image](https://user-images.githubusercontent.com/78345903/205445611-656922cd-87ff-4e10-b6c3-d0c87fd03d68.png)

From the class PLSDA, we can call the fuction summary and print. they were surcharged by the class PLSDA. 

![image](https://user-images.githubusercontent.com/78345903/205445789-1406b92c-79ba-4499-85bc-a2d0b83cae86.png)

We have also in the object pls_model, the variable selected by the VIP algorithm. it's select the important variable for the best model for predict Y variable. : 

![image](https://user-images.githubusercontent.com/78345903/205446795-b81659d1-fd9c-49cb-bbaf-1593011a060f.png)


## Predict function 

In the function, we have tree parameters to choose for launch function. This is a picture of the different parameters. You can choose between the type posterior or class, if you want the class of prediction or the probabilties.

![image](https://user-images.githubusercontent.com/78345903/205446134-2f32621d-e955-46f0-b51d-7d158b5461ad.png)

We can call our function like this : 

![image](https://user-images.githubusercontent.com/78345903/205446172-4f7023dc-cb67-4ba9-aa31-50dbb3b03fa1.png)

After the execution, we have the different class assigned to predict the Y variable. This is a part of prediction : 

![image](https://user-images.githubusercontent.com/78345903/205446321-126ea6d1-75eb-4dfc-8301-2316fea298d6.png)

## Graphics 

PLS-DA regression have the same mode of vizualisation data like a PCA. So we will show you the different type of graphs. 

### Screeplot 
 
This graphics show the number of components to select with criteria of below and kaiser. 

![image](https://user-images.githubusercontent.com/78345903/205446861-e4680567-087a-4ab2-a577-8ac461765228.png)

### Correlation circle variables 

This graph show the correlation between variables and the representation the axis. We can determine many fact with this graph. 

![image](https://user-images.githubusercontent.com/78345903/205446990-7d50eaf4-1d43-4e75-bd3a-cf6599dca41b.png)

### Individu plot 

This graph show the differents coordonates of individu on the graph and show the similarities between individu. When we execute the graph we see the class of individu with the variable Y.

![image](https://user-images.githubusercontent.com/78345903/205448732-326265dc-d1bd-4850-bc36-cf3130a4679b.png)

### Contributions variables 

This matrix show the contribution between variables. 

![image](https://user-images.githubusercontent.com/78345903/205447896-b41e1988-3c20-46e8-ad52-8b1e3772cd34.png)

### Cos2 graph 

This graph show the quality representation of variables on the different axis. 

![image](https://user-images.githubusercontent.com/78345903/205448025-d87cbffa-a64d-418f-bfe5-94e0ea0ed1d4.png)

### Correlation variables 

This graph show the correlation between variables.

![image](https://user-images.githubusercontent.com/78345903/205448161-36746bf6-7274-4f10-be49-76e2c85c540f.png)

### Plot VIP 

This graph show the variables selection on the graph. 

![image](https://user-images.githubusercontent.com/78345903/205448258-b9a0eb21-d5b0-49f6-89ca-3364d310409a.png)

For exemple, here we select only the variables where the bar is red. 

## Conclusion 

The PLS Regression method is a method not often used by Data Scientist but she is full of interest. In fact, we have different possibility to calcul the result : Canonical, SIMPLS, Nipals. Aslo with have the PLS-DA regression who is amazing for her utilisation. Indeed we can use the graph of PCA for data vizualisation. 
The PLS Regression only work with quantitatve variable cible Y and can work with multiple variable cible Y. 
To build this package, we have based ourselves on many documentacions and also the code source of Sklearn for the PLS Regression. 

# Rshiny tutorial :

After creating the package, we built an R-shiny application to deploy this package. 

Our application is now available on shinyapps.io, you can use it for free [here](https://ha8g60-samibgh.shinyapps.io/App_PLS_Regression/).
Or, you could just download our app [here](https://github.com/Samibgh/R-Shiny---PLS-DA-Deployment).

## Application Interface:

<img width="1425" alt="Capture d’écran 2022-12-02 à 15 23 52" src="https://user-images.githubusercontent.com/114235978/205315518-4e79b4ba-9da2-47a9-a622-717cfe4bce13.png">

After opening the app, you will see the header which contains name of the app (PLS-DA Application) and the menu.

The menu includes :
  - Data view : allows to upload, view and analyse your data.
  - Define status : allows to select features (independent variables), the target and modify parameters of algorithms if necessary.
  - Fit : allows to view the training results.
  - Prediction : allows to view the prediction results of the training model or the prediction results of the file that you want to get the prediction of.
  - Graphics : allows to view some graphics of the training model.

## App functionality :

### Data view section:

If you want to upload an excel file, please choose the sheet name before uploading, then upload the file from your local machine.

<img width="1354" alt="Capture d’écran 2022-12-02 à 16 26 58" src="https://user-images.githubusercontent.com/114235978/205327599-ea8bdef0-bfbb-470c-b62c-bf7434cbf17c.png">

If you want to upload a csv file, upload the file from your local machine, then select the separator (comma, semicolon or tab) and quote (none, double quote or single quote).

<img width="1297" alt="Capture d’écran 2022-12-02 à 16 34 04" src="https://user-images.githubusercontent.com/114235978/205329352-0f52734c-d216-48c8-a818-15096d05f0ac.png">
<img width="1350" alt="Capture d’écran 2022-12-02 à 16 35 24" src="https://user-images.githubusercontent.com/114235978/205329372-47d56fa3-8e93-4039-8e86-038105ba37eb.png">

Selection of the header is automatic, if you don't want to have the header, just don't select it.

If you just want to do some analysis and you don't have the file for prediction, just forget the section of prediction's upload.

After uploading your file, click on "head" if you want to view your data, or click on "summary" to get some analysis of your data.

### Define status section:

In the "Select x variable" section, please choose features. 
And in the "Select y variable", please choose the target.
Don't forget to click on the two submit's button.

<img width="1352" alt="Capture d’écran 2022-12-02 à 16 39 56" src="https://user-images.githubusercontent.com/114235978/205331587-1a743cdd-4061-4bd5-b533-f826d9e1602d.png">

If you want to change parameters or the algorithm, just change it. If not, let it by default.
You can :
  - Choose the algorithm that you prefer (nipals or simpls);
  - If you choose the nipals algorithm, you can change the threshold and the number of iteration maximum of this algorithm;
  - Choose the threshold of VIP function;
  - Choose the number of components (if you don't choose it (it is 0 by default), the number of components will be decided by cross-validation process).

### Fit section:

In this section, you can choose if you want to see the results of training model results or the whole data model results. If you choose "train" in the "Select train of full data", your data will be splitted in train and test parts.

In the "Results of fit", you can choose:
  - Classification : allows to see the coefficients and intercept of linear model.
  - Xweights, Yweights: weights of X and Y.
  - Xscores, Yscores
  - and Xloadings, Yloadings.
 
 <img width="1346" alt="Capture d’écran 2022-12-02 à 16 48 43" src="https://user-images.githubusercontent.com/114235978/205333579-f4cc606c-2138-4ebe-ab57-06411565b9f3.png">

### Prediction Results :

There are two sub-sections in this section: 
  - Training data prediction : allows to see the prediction results of training model. In this sub-section, you can choose:
    * Class : allows to see the group of each individual.
    * Probability : allows to see the probability's result of softmax function.
    * Confusion matrix
    * Accuracy
    * Precision
    * Recall
    * and F1 score
  
  <img width="1188" alt="Capture d’écran 2022-12-02 à 17 03 27" src="https://user-images.githubusercontent.com/114235978/205334656-fdfee13f-24b6-4d67-9537-368ef5e076d0.png">
  
  - Prediction Result : allows to see the prediction results of the file that you want to get the prediction of, and you can download this result on csv or excel format.

<img width="1205" alt="Capture d’écran 2022-12-02 à 17 04 10" src="https://user-images.githubusercontent.com/114235978/205334740-7e2927e6-9a31-4293-8142-77c7452e2049.png">

### Graphics :

There are two sub-sections in this section: 
  - First selection graph : allows to see the circle correlation of features, the individual plot and the correlation matrix plot.
  
  <img width="1191" alt="Capture d’écran 2022-12-02 à 17 05 43" src="https://user-images.githubusercontent.com/114235978/205335639-aacb8e98-5926-4dc7-9f34-124eca7dbe3f.png">

  - Second selection graph : allows to see cos2 plot, contribution of features plot, screeplot and VIP plot.

<img width="1202" alt="Capture d’écran 2022-12-02 à 17 06 01" src="https://user-images.githubusercontent.com/114235978/205335679-5cb2a05f-c187-4379-9802-4d0ba1841f0c.png">
