# getting-cleaning-data-project
Course project for Getting and Cleaning Data Week 3

The accompanying 'run_analysis.R' script reads in several data files:

- x_test.txt: test data file
- y_test.txt: file that denotes the activity ID number of each observation in the test data file
- x_train.txt: training data file
- y_train.txt: file that denotes the activity type of each observation in the training data file
- features.txt: provides a look-up for the variable names for both the training and the test data files
- activities.txt: provides a look-up for the type of activity of each observation

The script then merges the training and test data files together; it uses the other files as lookups, in order to provide appropriate descriptive labels for each variable and activity type.

The script also renames variables to make their meaning clearer.

Finally the script loads and uses the reshape2 package in order to melt() the data by subject and activity name and then dcast() the data and obtain the mean values for each variable, broken down by subject and activity name.

The script then writes this second tidy dataset to a file named output.txt.