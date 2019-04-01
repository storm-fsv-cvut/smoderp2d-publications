setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/obr")
bf_dir = list.dirs('/home/hdd/data/16_smod_paper_optim/vysledky/best_fit.1/')

prehled = read.table('/home/hdd/data/16_smod_paper_optim/vysledky/LabD_prehled_simulaci.csv',sep = ';', header = TRUE, comment.char = '*', na.strings = 'na')

read_bf <- function(bf_dir, mereni, locname, texture=''){
  dir_list <- grep(pattern = mereni, bf_dir, value = TRUE)
  print (dir_list)
  D = c()
  JM = c()
  H = c()
  for (idl in dir_list){
    bn = basename(idl)
    d = read.table(file = paste(idl,'params.dat',sep='/'), header = FALSE, 
                   sep = ';', dec = '.',nrows = 1, skip = 1)
    h = read.table(file = paste(idl,'params.dat',sep='/'), header = FALSE, 
                   sep = ';', dec = '.',nrows = 1, skip = 0)
    d = (c(t(d)))
    h = (c(t(h)))
    D = c(D,d)
    H = c(H,h)
    JM = c(JM,rep(bn,length(d)))
  }
  Loc = rep(locname,length(D))
  Tex= rep(texture,length(D))
  return (data.frame(loc = Loc, sim = JM, param = H, val = D, textira = Tex))
}

srazka <- function(srazka_float){
  if (srazka_float <= 5){
    return('00-05')
  }
  if (srazka_float <= 15){
    return('05-15')
  }
  if (srazka_float <= 25){
    return('15-25')
  }
  if (srazka_float <=35){
    return('25-35')
  }
  if (srazka_float <= 45){
    return('35-45')
  }
  if (srazka_float <= 55){
    return('45-45')
  }
  if (srazka_float <= 65){
    return('55-65')
  }
  if (srazka_float <= 75){
    return('65-75')
  }
  if (srazka_float <= 85){
    return('75-85')
  }
  return(NA)
}

read_bf2 <- function(bf_dir){
  dir_list <- grep(pattern = 'out-', bf_dir, value = TRUE)
  mer = c()
  vals = c()
  Cl = c()
  Si = c()
  Sa = c()
  Te = c()
  sr = c()
  for (ibf in dir_list){
    ffparam = paste(ibf,'params.dat',sep='/')
    d = read.table(file = ffparam, header = TRUE, 
                   sep = ';', dec = '.',nrows = 1, skip = 0)
    # extract jmeno lokality
    bff = basename(ibf)
    # useknu out-
    bff = substr(bff,5,nchar(bff))
    mer = c(mer, bff)
    # useknu -* ma konci
    bff = substr(bff,1,gregexpr(pattern ='-',bff)[[1]][1]-1)
    
    sprehled = prehled[prehled$id_name == bff, ]
    Cl = c(Cl,sprehled$clay.....)
    Si = c(Si,sprehled$silt....)
    Sa = c(Sa,sprehled$sand....)
    Te = c(Te,as.character(sprehled$soiltype))
    
    vals = rbind(vals,d)
    
    sr = c(sr,srazka(d$rainfall*1000*60*60))
    
  }
  BF = as.data.frame(vals)
  BF$mer = mer
  # print (length(mer))
  # print (length(Cl))
  BF$clay = Cl
  BF$silt = Si
  BF$sand = Sa
  BF$textura = Te
  BF$b_rainfall = sr
  return(BF)
}
BF2 = read_bf2(bf_dir)

# 



trebsin_i = read_bf(bf_dir = bf_dir, mereni = '*trebsin_i_2004-*', locname = 'trebsin_i_2004', texture = 'silty loam')


neustupov = read_bf(bf_dir = bf_dir, mereni = '*neust*', locname = 'neustupov_2006', texture = 'sandy loam')
klapy = read_bf(bf_dir = bf_dir, mereni = '*kla*', locname = 'klapy_2007', texture = 'silty clay loam')
trebsin_ii = read_bf(bf_dir = bf_dir, mereni = '*trebsin_ii_2008-*', locname = 'trebsin_ii_2008', texture = 'silty loam')
trebesice_i = read_bf(bf_dir = bf_dir, mereni = '*trebesice_2009-*', locname = 'trebesice_2009', texture = 'sandy loam')
trebesice_ii = read_bf(bf_dir = bf_dir, mereni = '*trebesice_2010-*', locname = 'trebesice_2010', texture = 'sandy loam')
nucice = read_bf(bf_dir = bf_dir, mereni = '*nucice*', locname = 'nucice_2011', texture =  'silty loam')
vsetaty_i = read_bf(bf_dir = bf_dir, mereni = '*vsetaty_2012-*', locname = 'vsetaty_2012', texture =  'loam')
vsetaty_ii = read_bf(bf_dir = bf_dir, mereni = '*vsetaty_2013-*', locname = 'vsetaty_2013', texture =  'loam')
trebesice_iii = read_bf(bf_dir = bf_dir, mereni = '*trebesice_2014-*', locname = 'trebesice_2014', texture = 'silty loam')
nove_straseci = read_bf(bf_dir = bf_dir, mereni = '*nove_straseci*', locname = 'nove_straseci_2015', texture = 'loam')
risuty = read_bf(bf_dir = bf_dir, mereni = '*risuty*', locname = 'risuty_2017', texture = 'loam')

BF = rbind(neustupov, klapy, trebsin_i, trebsin_ii, trebesice_i, trebesice_ii, 
           trebesice_iii, nucice, vsetaty_i, vsetaty_ii, nove_straseci, risuty)
BF$clay = NA
BF$silt = NA
BF$sand = NA


for (i in unique(BF$loc)){
  ii = which(prehled$id_name == i)
  jj = which(BF$loc == i)
  BF$clay[jj] = prehled$clay.....[ii]
  BF$silt[jj] = prehled$silt....[ii]
  BF$sand[jj] = prehled$sand....[ii]
}


save(BF, BF2, file = 'optim.rda')