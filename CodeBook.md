---
title: "CodeBook"
output: html_document
---
Needed package: reshape2

Data tracking movement collected with a cellphone was Downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

To create the tidy datasets, just run run_analysis.R with the data unzipped in the working directory. 

Variable names of mean_std_tidy_set.txt. 
```{r}
colnames(tidy_mean_set)
```


Variable names of the means per activity and subject
```{r}
colnames(reduced_means)
```



