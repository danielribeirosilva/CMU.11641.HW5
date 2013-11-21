README FILE

The file you should run is run.m

The matlab code assumes that the DATA.TXT file is on the same folder.
If you have a problem with DATA.TXT you can input the values by hand by uncommenting lines 5-10

I am assuming you allow parallel processing. 
If you are having problems with "matlabpool open", please read and follow these instructions:
http://www.mathworks.com/support/bugreports/919688

If you aren't able to fix it, make the code non-parallelizable by doing the following:

-> comment lines 13-15
-> replace line 47 "parfor i_label = 1:length(labels)" by "for i_label = 1:length(labels)"

If you do that, please be generous with the 10 minutes limit time. 
It will very likely run in less than 10 minutes, but I was considering you would be able to run it as it is.

This script outputs the results to a text file called eval.txt

If you are curious, the scripts for SVM are inside the SVM folder.

If you have any further problems, please contact me at


