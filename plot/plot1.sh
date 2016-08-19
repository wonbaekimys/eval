echo 'set term postscript color solid 16;
      set output "grep-250gb.ps";
      plot "../logs/grep-250gb.dat" w l' | gnuplot
# #latency evaluation time
# echo 'set key font ",30";
# set key spacing 2;
# set ylabel font ",30";
# set ylabel "Time (sec)";
# set style fill pattern 1;
# set style data histogram;
# set style histogram clustered gap 1;
# set term postscript color solid 16;
# set output "figures/latency_time.ps";
# plot newhistogram, "data/latency_time.dat" u 2:xtic(1) t "Cached First", "" u 3 t "ACS"' | gnuplot
# #latency evaluation hitratio
# echo 'set key font ",30";
# set yrange [0:100];
# set key spacing 2;
# set ylabel font ",30";
# set ylabel "Hit Ratio (%)";
# set style fill pattern 1;
# set style data histogram;
# set style histogram clustered gap 1;
# set term postscript color solid 16;
# set output "figures/latency_hit.ps";
# plot newhistogram, "data/latency_hit.dat" u 2:xtic(1) t "Cached First", "" u 3 t "ACS"' | gnuplot
# #osbuffer
# echo 'set key font ",30";
# set key spacing 2;
# set yrange [0:];
# set ylabel font ",30";
# set ylabel "Time (sec)";
# set style fill pattern 1;
# set style data histogram;
# set style histogram clustered gap 1;
# set term postscript color solid 16;
# set output "figures/osbuffer_time.ps";
# plot newhistogram, "data/osbuffer_time.dat" u 2:xtic(1) t "Delay" lc rgbcolor "blue", "" u 3 t "ACS"' | gnuplot
# #thrashing time
# echo 'set key font ",30";
# set key spacing 2;
# set yrange [0:];
# set ylabel font ",30";
# set ylabel "Time (sec)";
# set style fill pattern 1;
# set style data histogram;
# set style histogram clustered gap 1;
# set term postscript color solid 16;
# set output "figures/thrashing_time.ps";
# plot newhistogram, "data/thrashing_time.dat" u 2:xtic(1) t "Delay" lc rgbcolor "purple", "" u 3 t "ACS"' | gnuplot
# #thrashing hit
# echo 'set key font ",30";
# set key spacing 2;
# set yrange [0:];
# set ylabel font ",30";
# set ylabel "Time (sec)";
# set style fill pattern 1;
# set style data histogram;
# set style histogram clustered gap 1;
# set term postscript color solid 16;
# set output "figures/thrashing_hit.ps";
# plot newhistogram, "data/thrashing_hit.dat" u 2:xtic(1) t "Delay" lc rgbcolor "purple", "" u 3 t "ACS"' | gnuplot
# #remote time
# echo 'set key font ",30";
# set key spacing 2;
# set yrange [0:450];
# set ylabel font ",30";
# set ylabel "Time (sec)";
# set style fill pattern 1;
# set style data histogram;
# set style histogram clustered gap 1;
# set term postscript color solid 16;
# set output "figures/remote_time.ps";
# plot newhistogram, "data/remote_time.dat" u 2:xtic(1) t "NoRemote" lc rgbcolor "black", "" u 3 t "ACS"' | gnuplot
