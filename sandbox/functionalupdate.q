 /Using functional update to apply a function of 2 inputs
 /More infos here: https://code.kx.com/q/ref/funsql/
shifts:`p1`p2!(-.05 0 .05;-.2 -.15 -.10 -.05 -.03 -.02 -.01 0 .01 .02 .03 .05 .1 .15 .2);
getlowershift:{s:shifts[x];if[y<min s;:min s];max s where s <=y};
getuppershift:{s:shifts[x];if[y>max s;:max s];min s where s >=y};
t:{`param`varp xasc ([]param:x?`p1`p2;varp:-.3+x?0.6)}[100000]; /create a test table with random values
\ts ![t;();0b;(`lowershift`uppershift)!(({(getlowershift each x)y};`param;`varp);({(getuppershift each x)y};`param;`varp))]