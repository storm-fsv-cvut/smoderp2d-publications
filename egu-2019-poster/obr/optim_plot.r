setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/obr")
load_ = TRUE; if (load_) {load('optim.rda')}


width_ = 2300*2.5
height_ = 1200*2.5
res_  = 600
pointsize_ = 6*2.5
png_ = TRUE


plot_lines <- function(para_,classes_, box = FALSE){
  bf = BF[BF$param==para_,]
  nc = length(classes_)
  par(mar=c(3,3,2,1))
  par(mfrow = c(1,nc))
  for (ic in classes_){
    y = bf$val
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
    mtext(paste('parameter',para_), line = 1.85, side = 2, cex=0.8)
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


if (png_) {png(filename = 'Xfittex.png', width = wi, height = he/2, res = res, pointsize = ps)}
plot_lines('X', c('clay', 'silt', 'sand'), box = TRUE)
if (png_) {dev.off()}



if (png_) {png(filename = 'Yfittex.png', width = wi, height = he/2, res = res, pointsize = ps)}
plot_lines('Y', c('clay', 'silt', 'sand'), box = TRUE)
if (png_) {dev.off()}
if (png_) {png(filename = 'bfittex.png', width = wi, height = he/2, res = res, pointsize = ps)}
plot_lines('b', c('clay', 'silt', 'sand'), box = TRUE)
if (png_) {dev.off()}