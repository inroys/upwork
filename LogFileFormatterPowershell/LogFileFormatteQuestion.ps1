I have several log files in 1 folder. Need to combine and format them please see the steps so that you can build some simple pS script.
1) Copy the *. Log file for a particular month into another folder.  Folder contains all months and other year log file. So Pick either last 30/31 days log files and copy them to another folder.
2) Log File has date stamp like this tm1s202002102143000.log. (Naming covention of the log file tm1s followed by 4 digit year, 2 digit month and 2 digit day and then last few digits are timestamp) Log folder contains several files with date and timestamp but need to pull for particular month.
2) Remove the first 3 line and last line that has  -->(kind of arrow or end of file indicator) in each log file. Average there will be 30/31 files for each month having data of 80KB in each file
4) After above lines are removed then Merge all the *.log file content into 1 text file.
Merge without changing the content of file. Ex: t1.log, t2.log, t3.log file data need to be combined in 1 file without 1st 3 lines and last line.

5) Basically need to use this for auditng so that I can read the log files by putting in 1 text file instead of reading 30/31 log files per month.