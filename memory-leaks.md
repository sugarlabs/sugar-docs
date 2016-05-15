# Finding Memory Leaks

This is a guide to finding and fixing memory leaks.

Memory leaks are a common bug where a program retains allocated memory after it is no longer needed, and over time this makes the program slow (and even slows down the whole operating system.) 

(A memory leak was found and discussed in the Sugar Desktop programs (jarabe), <https://github.com/sugarlabs/sugar/pull/520>, with a fix in <https://github.com/sugarlabs/sugar/pull/614> and that discussions is the source for this guide.)

## Graph Memory Usage

Start sugar, your Activity, then the Terminal Activity.

In Terminal run,

    htop

Look for the `pid` of your Activity, and quit. 

Run a loop that measures the memory consumption of your Activity,

```bash
while true; do
  echo $(date +%s.%N) \
    $(awk '/VmSize/ { print $2; }' /proc/$(pgrep -f jarabe)/status)
  sleep 1
done | tee memory.log
```

Switch to your Activity, and follow some procedure to test it, then stop using it and wait a couple of minutes to let it settle down. 

**Tip:** Use [xdotool](https://github.com/jordansissel/xdotool) to script the interaction with your activity, so you can reliably reproduce the testing procedure. 
For example, `xdotool key F6`

Switch to Terminal and stop the loop by pressing `CTRL-C`

Create a graph of the data, either quickly with plotutils, 

    graph -T png data > graph.png;

or with gnuplot, run this script


```bash
#!/bin/bash
gnuplot -persist <<EOF
# comment out the following 2 lines to display on screen
set terminal png
set output "memory.png"

set title "XO-1.5 ... \nVmSize leak test\n2015-10-06\nby James Cameron"
set xlabel "Clock time MM:SS"
set ylabel "VmSize kb"
set nokey

set xdata time
set timefmt "%s"

set grid
set style data step

plot "memory.log" using 1:2 title "run #1" lw 2
```

Finally removes the files,

    rm data  graph.png memory.log memory.png;
