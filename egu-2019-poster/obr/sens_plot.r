setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/obr")
load_ = TRUE; if (load_) {load('sens.rda')}


width_ = 2300*2.5
height_ = 1200*2.5
res_  = 600
pointsize_ = 6*2.5
png_ = TRUE

if (png_) {png('sens.png',width = width_,height = height_,res = res_, pointsize = pointsize_)}
par(mar = c(3,3,1,1))
boxplot(sens, log = 'y')
mtext('log10(sum of squeares [m/s]^2)', line = 2, side = 2)
mtext('scenario with incresed or deceased parameter', line = 2, side = 1)
abline(h=0)
if (png_) {dev.off()}