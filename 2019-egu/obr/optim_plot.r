setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/egu-2019-poster/obr")
load_ = TRUE; if (load_) {load('optim.rda')}


width_ = 2300*2.5
height_ = 1200*2.5
res_  = 600
pointsize_ = 6*2
png_ = TRUE


plot_lines <- function(para_,classes_, box = FALSE){
  bf = BF[BF$param==para_,]
  nc = length(classes_)+1
  par(mar=c(3,3,2,0))
  par(mfrow = c(1,nc))
  x = rep('all', length(bf[,'textira']))
  y = bf$val
  x = c(x,as.character(bf[,'textira']))
  y = c(y,bf$val)
  pd = data.frame(y=y, x=x)
  at_ = c(1,3,2,5,4)
  bb = boxplot(y~x, data = pd, at = at_, axes= FALSE)
  axis(2)
  axis(1, labels = c('all', 'SaLo', 'Lo', 'SiLo','SiCiLo'), at = 1:5)
  mtext('all textures', line = 0.25, side = 3, adj = 0, cex=0.8)
  mtext(paste('parameter',para_), line = 1.85, side = 2, cex=0.8)
  mtext(paste('n =',bb$n), line = 1.85, side = 1, cex=0.6, at = at_)
  par(mar=c(3,2,2,0.5))
  for (ic in classes_){
    x = bf[,ic]
    pd = data.frame(y=y, x=x)
    if (!box){
      plot(pd$x,pd$y)
    } else {
      bb = boxplot(y~x, data = pd, at = sort(unique(pd$x)))
    }
    fit = lm(y ~ x, data = pd)
    ab = coefficients(fit)
    curve(ab[1] + ab[2]*x, add = TRUE)
    mtext(paste(ic, paste(': r-sqr = ', round(summary(fit)$r.squared,3)), sep=''), line = 0.25, side = 3, adj = 0, cex=0.8)
    mtext('%', line = 2, side = 1, cex=0.8)
  }
}


if (png_) {png('Ks_fit.png',width = width_,height = height_,res = res_, pointsize = pointsize_)}
par(mar = c(3,3,0,1))
hist(BF2$Ks, breaks = 10, main = '')
mtext('count', line = 2, side = 2)
mtext('fitted saturated hydraulic conductivity [m/s]', line = 2, side = 1)
if (png_) {dev.off()}


if (png_) {png('S_fit.png',width = width_,height = height_,res = res_, pointsize = pointsize_)}
par(mar = c(3,3,0,1))
hist(BF2$S, breaks = 10, main='')
mtext('count', line = 2, side = 2)
mtext('fitted sorptivity [m/sqrt(s)]', line = 2, side = 1)
if (png_) {dev.off()}


if (png_) {png(filename = 'Xfittex.png', width = width_, height = height_/2, res = res_, pointsize = pointsize_)}
plot_lines('X', c('clay', 'silt', 'sand'), box = TRUE)
if (png_) {dev.off()}


if (png_) {png(filename = 'Yfittex.png', width = width_, height = height_/2, res = res_, pointsize = pointsize_)}
plot_lines('Y', c('clay', 'silt', 'sand'), box = TRUE)
if (png_) {dev.off()}
if (png_) {png(filename = 'bfittex.png', width = width_, height = height_/2, res = res_, pointsize = pointsize_)}
plot_lines('b', c('clay', 'silt', 'sand'), box = TRUE)
if (png_) {dev.off()}