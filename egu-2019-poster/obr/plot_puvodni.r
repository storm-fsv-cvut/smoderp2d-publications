params_orig = read.table('tabulka_puvodnich.csv', sep = ';', header = TRUE, dec=',')

params_orig$poradi = 1:12

plot(params_orig$poradi, params_orig$x, ylim = c(0,20))
points(params_orig$poradi, params_orig$y)
points(params_orig$poradi, params_orig$b)
