setwd("~/ownCloud/Knihovna/poster/EGU2019_smod/egu-2019-poster/obr")
dir_ = '/home/hdd/data/16_smod_paper_optim/vysledky/sens_out.1.mc/'
scenare = list.dirs(dir_,recursive = FALSE,full.names = FALSE)
scenare = scenare[grep(pattern = 'out-sens*', x = scenare)]
#
# save ?
save_ = TRUE
#


prehled = read.table('/home/hdd/data/16_smod_paper_optim/vysledky/LabD_prehled_simulaci.csv',sep = ';', header = TRUE, comment.char = '*', na.strings = 'na')

# vykousne texturu z prehldu
get_texture <- function(scenar){
  for (loc in prehled$id_name){
    if (1 == length(grep(pattern = loc, scenar))) {
      return (as.character(droplevels(prehled$soiltype[prehled$id_name == loc])))
    }
  }
}

# vykousne texturu z prehldu
get_ClSiSa <- function(scenar){
  for (loc in prehled$id_name){
    if (1 == length(grep(pattern = loc, scenar))) {
      Cl = prehled$clay.....[prehled$id_name == loc]
      Si = prehled$silt....[prehled$id_name == loc]
      Sa = prehled$sand....[prehled$id_name == loc]
      return(data.frame(clay=Cl, silt=Si, sand=Sa))
    }
  }
}

# nacte vsechna data
read_mc <- function(scenare){
  # MONTE CARLO DATA
  MC_D = c()
  for (isc_sens in scenare){
    
    print (isc_sens)
    
    # jmeno scenare bez out-sens-
    jm_scenar = (gsub("*out-sens-*","",isc_sens))
    MC_D[[jm_scenar]]$class = get_texture(jm_scenar)
    MC_D[[jm_scenar]]$textura = get_ClSiSa(jm_scenar)
    
    # fn= paste(dir_,isc_sens,'monte_carlo_sa.dat',sep = '/')
    # 
    # # monte carlo data
    # mc_d = read.table(fn,header = TRUE, sep=';', comment.char = '*')
    # MC_D[[jm_scenar]]$mc_par = mc_d
    
    # pokud byly lepsi scenare tak jsou v ls_dirs
    ls_dirs = list.dirs(paste(dir_,isc_sens,sep = '/'), recursive = TRUE)
    if (length(ls_dirs)>0){
      for (ils_dirs in ls_dirs){
        bname = basename(ils_dirs)
        if (nchar(bname) == 5){
          MC_D[[jm_scenar]]$good_fit[[bname]]$para = read.table(paste(ils_dirs, 'params.dat', sep='/'),header = TRUE, sep=';', comment.char = '*')
          MC_D[[jm_scenar]]$good_fit[[bname]]$data = read.table(paste(ils_dirs, 'mod_obs.dat', sep='/'),header = TRUE, sep=';', comment.char = '*')
        }
      }
    }
  }
  return(MC_D)
}

# agreguje dobre fity
vybere_good_fit_params <- function(MC_D){
  cl = c()
  te = c()
  loc_ = c()
  pars = c()
  N = length(MC_D)
  JM = names(MC_D)
  for (iloc in 1:N){
    print (JM[iloc])
    loc = MC_D[[iloc]]
    n_good_fit = length(loc$good_fit)
    for (i in 1:n_good_fit){
      loc_ = c(loc_,JM[iloc])
      pars = rbind(pars,loc$good_fit[[i]]$para)
      cl = c(cl,loc$class)
      te = rbind(te,loc$textura)
    }
  }
  d = as.data.frame(te)
  d$class = cl
  d$loc = loc_
  d = cbind(d,pars)
  return(d)
}

# MC_D  = read_mc(scenare)

mc_agg = vybere_good_fit_params(MC_D)

if (save_) {save(MC_D, mc_agg, file = 'mc.rda')}