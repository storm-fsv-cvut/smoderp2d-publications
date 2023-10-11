setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/obr")
dir_ = '/home/hdd/data/16_smod_paper_optim/vysledky/sens_out.1.tmp/'
scenare = list.dirs(dir_,recursive = FALSE,full.names = FALSE)
scenare = scenare[grep(pattern = 'out-sens*', x = scenare)]
# i.scenare = grep(pattern = 'out-sens*', x = scenare)

D = c()
for (iscenar in scenare) {
  fn = paste(dir_,iscenar,'plus_minus_sa.dat',sep = '/') 
  if (file.exists(fn)) 
  {
    d = read.table(fn,header = TRUE, sep=';', comment.char = '*')
    #     print (d$SofSq[1])
    #     if ((d$SofSq[1] == 0.0)){
    #         print ('asdf')
    #     }
    if (!(d$SofSq[1] == 0.0)){
      #         d$SofSq = d$SofSq-d$SofSq[1]
      D = rbind(D,d$SofSq)
    }
  }
}

D[D<=0.0] = NA
# D[D==0.0] = NA

varnames = c('X','Y','b','Ks','S','ret')
header = c('bf',paste(c(rbind(varnames,varnames)),c('+','-')))
D = as.data.frame(D)
colnames(D) <- header
sens = D
save(sens, file = 'sens.rda')