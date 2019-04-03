setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/egu-2019-poster/obr")
load_ = FALSE; if (load_) {load('mc.rda')}

hist(mc_agg$b)
hist(mc_agg$X)
hist(mc_agg$Y)
hist(mc_agg$ret)


boxplot(mc_agg$X ~ mc_agg$class)
boxplot(mc_agg$Y ~ mc_agg$class)
boxplot(mc_agg$b ~ mc_agg$class)



boxplot(mc_agg$X ~ mc_agg$clay)
boxplot(mc_agg$X ~ mc_agg$silt)
boxplot(mc_agg$X ~ mc_agg$sand)

boxplot(mc_agg$Y ~ mc_agg$silt)
boxplot(mc_agg$Y ~ mc_agg$sand)

boxplot(mc_agg$b ~ mc_agg$clay)
boxplot(mc_agg$b ~ mc_agg$silt)
boxplot(mc_agg$b ~ mc_agg$sand)

plot(mc_agg$silt, mc_agg$X)
