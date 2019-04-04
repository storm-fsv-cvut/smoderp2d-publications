setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/egu-2019-poster/obr")
load_ = FALSE; if (load_) {load('mc.3.rda')}


width_ = 2300*2.5
height_ = 1200*2.5*2.3
res_  = 600
pointsize_ = 6*2*2
png_ = TRUE

plot.mc <- function(par, break_){
  par(mfrow=c(2,1))
  par(mar=c(2,3,1,1))
  x = mc_agg[,par]
  y = mc_agg$class
  df = data.frame(x=x, y=y)
  opar <- par(lwd=2)
  hh = hist(df$x,breaks = break_, plot = FALSE)
  plot(hh, main = '')
  par(opar)
  mtext(paste('parameter',par),side = 1, line = 2)
  mtext('frequency',side = 2, line = 2)
  
  
  x = c(x,mc_agg[,par])
  y = c(y,rep('all', length(mc_agg$class)))
  at_ = c(1,3,2,5,4)  
  df = data.frame(x=x, y=y)
  boxplot(df$x ~ df$y, at = at_, axes = FALSE,lwd=2)
  axis(1, labels = c('all', 'SaLo', 'Lo', 'SiLo','SiCiLo'), at = 1:5)
  axis(2)
  mtext(paste('parameter',par),side = 2, line = 2)
}

if (png_) {png(filename = 'mc_b.png', width = width_, height = height_, res = res_, pointsize = pointsize_)}
plot.mc('b', break_ = seq(1,4, length.out = 51))
if (png_) {dev.off()}

if (png_) {png(filename = 'mc_x.png', width = width_, height = height_, res = res_, pointsize = pointsize_)}
plot.mc('X', break_ = seq(0,100,by = 2))
if (png_) {dev.off()}

if (png_) {png(filename = 'mc_y.png', width = width_, height = height_, res = res_, pointsize = pointsize_)}
plot.mc('Y', break_ = c(0,(1:50)/10))
if (png_) {dev.off()}


# 
# adsf
# hist(mc_agg$X,breaks = seq(0,100,by = 2))
# hist(mc_agg$Y, breaks = c(0,(1:50)/10))
# 
# asdf
# hist(mc_agg$ret)
# 
# 
# boxplot(mc_agg$X ~ mc_agg$class)
# boxplot(mc_agg$Y ~ mc_agg$class)
# 
# 
# boxplot(mc_agg$b ~ mc_agg$clay)
# boxplot(mc_agg$b ~ mc_agg$silt)
# boxplot(mc_agg$b ~ mc_agg$sand)
# 
# boxplot(mc_agg$X ~ mc_agg$clay)
# boxplot(mc_agg$X ~ mc_agg$silt)
# boxplot(mc_agg$X ~ mc_agg$sand)
# 
# boxplot(mc_agg$Y ~ mc_agg$clay)
# boxplot(mc_agg$Y ~ mc_agg$sand)
# boxplot(mc_agg$Y ~ mc_agg$silt)
# 
# 
# plot(mc_agg$silt, mc_agg$X)
