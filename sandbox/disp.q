/create sample table
tb:([]sym:(4#`EEM),4#`SPX;date:2018.01.01+mod[;4]til 8;ivol:0N 55.1 0N 57.2 0N 14.44 0N 15.07);

/fill missing values backward
update fills ivol by sym from `sym`date xdesc tb