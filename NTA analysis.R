#make sure this Rscripts is in the folder with the .txt files you get from the NTA, make sure you DONT paste the  11pos.txt files in here. ONLY the regular .txt file
#also make sure there are no random .txt files in the folder as the script will open all .txt files.
#clear workspace
rm(list =ls())

library(readr)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Create % dataframe
NTA.pct.conc  <- data.frame(matrix(ncol=5,nrow=0))
NTA.pct.vol   <- data.frame(matrix(ncol=5,nrow=0))
NTA.pct.area  <- data.frame(matrix(ncol=5,nrow=0))

#get files list in directory that end in .txt
files <- list.files(pattern = ".*\\.txt$")
files
#for each file in files do:

for(i in 1:length(files)){
  #read rawNTA file in directory
   NTA <- read_delim(files[i],
                    "\t", escape_double = FALSE, trim_ws = TRUE, 
                    skip = 69)
     #select 1-1000nm
  NTAsel <- NTA[1:34,] 
  #calculate percentage of total for concentration
  a <-(sum(NTAsel$`Concentration / cm-3`[1:4]) / sum(NTAsel$`Concentration / cm-3`)*100)
  b <-(sum(NTAsel$`Concentration / cm-3`[5:7]) / sum(NTAsel$`Concentration / cm-3`)*100)
  c <-(sum(NTAsel$`Concentration / cm-3`[8:14]) / sum(NTAsel$`Concentration / cm-3`)*100)
  d <-(sum(NTAsel$`Concentration / cm-3`[15:21]) / sum(NTAsel$`Concentration / cm-3`)*100)
  e <-(sum(NTAsel$`Concentration / cm-3`[22:34]) / sum(NTAsel$`Concentration / cm-3`)*100)
  NTA.pct.conc  <- rbind(NTA.pct.conc, c(a,b,c,d,e))  
  
  #calculate percentage of total for volume
  f <-(sum(NTAsel$`Volume / nm^3`[1:4]) / sum(NTAsel$`Volume / nm^3`)*100)
  g <-(sum(NTAsel$`Volume / nm^3`[5:7]) / sum(NTAsel$`Volume / nm^3`)*100)
  h <-(sum(NTAsel$`Volume / nm^3`[8:14]) / sum(NTAsel$`Volume / nm^3`)*100)
  i <-(sum(NTAsel$`Volume / nm^3`[15:21]) / sum(NTAsel$`Volume / nm^3`)*100)
  j <-(sum(NTAsel$`Volume / nm^3`[22:34]) / sum(NTAsel$`Volume / nm^3`)*100)
  NTA.pct.vol   <- rbind(NTA.pct.vol, c(f,g,h,i,j))
  #calculate percentage of total for area
  k <-(sum(NTAsel$`Area / nm^2`[1:4]) / sum(NTAsel$`Area / nm^2`)*100)
  l <-(sum(NTAsel$`Area / nm^2`[5:7]) / sum(NTAsel$`Area / nm^2`)*100)
  m <-(sum(NTAsel$`Area / nm^2`[8:14]) / sum(NTAsel$`Area / nm^2`)*100)
  n <-(sum(NTAsel$`Area / nm^2`[15:21]) / sum(NTAsel$`Area / nm^2`)*100)
  o <-(sum(NTAsel$`Area / nm^2`[22:34]) / sum(NTAsel$`Area / nm^2`)*100)
  NTA.pct.area  <- rbind(NTA.pct.area, c(k,l,m,n,o))

}
#add column names
coln <- c("0-105nm","105-195nm","195-405nm","405-615nm","615-1005nm")
colnames(NTA.pct.conc) <- coln
colnames(NTA.pct.vol) <- coln
colnames(NTA.pct.area) <- coln

#add row mames as the filename
row.names(NTA.pct.conc) <- files
row.names(NTA.pct.vol) <- files
row.names(NTA.pct.area) <- files

##show dataframe
#print(NTA.pct.conc)
#print(NTA.pct.vol)
#print(NTA.pct.area)

#save file as .csv
write.csv(NTA.pct.conc,"pct.of.total.concentration.csv")
write.csv(NTA.pct.vol,"pct.of.total.volume.csv")
write.csv(NTA.pct.area,"pct.of.total.area.csv")