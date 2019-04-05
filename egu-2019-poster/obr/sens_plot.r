setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/egu-2019-poster/obr/")
load_ = TRUE; if (load_) {load('sens.rda')}


width_ = 2300*2.5
height_ = 1200*2.
res_  = 600
pointsize_ = 6*2.5
png_ = TRUE

if (png_) {png('sens.png',width = width_,height = height_,res = res_, pointsize = pointsize_)}
par(mar = c(3,3,1,1))
boxplot(sens, log = 'y',lwd=2)
mtext(expression(paste('log'['10']," (cm min"^"-1",")",sep="")),side = 2, line = 1.8)
mtext('scenarios with incresed or deceased parameter', line = 2, side = 1)
abline(h=0)
if (png_) {dev.off()}
