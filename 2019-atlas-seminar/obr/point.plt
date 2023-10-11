set terminal png medium size 640,480 font "Helvetica,15"
set output 'points.png'
set datafile separator ";"
set xlabel 'cas [sekundy]
set ylabel 'prutok [m3/s]'
set grid
plot 'point3.dat' u 1:5 title '' pt 1 ps 2
